import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:template/presentation/ui/ui.dart';

enum CLGSourceType { asset, file, url }

class CLGSource {
  final String path;
  final String? fileName;
  final CLGSourceType type;
  final bool useS3;

  String get name => pathValidated.split('/').last;
  String get ext => pathValidated.split('/').last.split('.').last;
  String get nameOnly => name.replaceAll(RegExp('\\.$ext\$'), '');

  CLGSource.asset(this.path, {this.fileName})
      : type = CLGSourceType.asset,
        useS3 = false;
  CLGSource.file(this.path, {this.fileName})
      : type = CLGSourceType.file,
        useS3 = false;
  CLGSource.url(this.path, {this.fileName, this.useS3 = false}) : type = CLGSourceType.url;

  Future<int> getSize() async {
    final file = await toTemporaryFile();
    return await file?.length() ?? 0;
  }

  Future<File> getCacheFile() async {
    final ext = pathValidated.split('.').last;
    final sourceId = await CLGUtils.generateIdFromName(pathValidated);
    final temporalyPath = await CLGUtils.getTemporalyPath();
    final file = File('$temporalyPath/$sourceId.$ext');

    return file;
  }

  Future<File?> toTemporaryFile() async {
    final file = await getCacheFile();
    try {
      if (file.existsSync()) return file;

      debugPrint('CLGSource:toTemporaryFile - Creating temporary file');
      switch (type) {
        case CLGSourceType.asset:
          final bytes = await rootBundle.load(path);
          await file.writeAsBytes(bytes.buffer.asInt8List());
          break;

        case CLGSourceType.file:
          final bytes = await File(path).readAsBytes();
          await file.writeAsBytes(bytes.buffer.asInt8List());
          break;

        case CLGSourceType.url:
          CLGUtils.checkNetworkConnection();
          String urlToDownload = path;
          if (useS3 && !RegExp('^https?://.*').hasMatch(path)) {
            // urlToDownload = await AmplifyService().getDownloadUrl(pathValidated) ?? '';
          }
          final response = await Isolate.run(() => http.get(Uri.parse(urlToDownload)));
          await file.writeAsBytes(response.bodyBytes);
          break;
      }
      debugPrint('CLGSource:toTemporaryFile - Temporary file created');
      return file;
    } on SocketException catch (e) {
      if (file.existsSync()) file.deleteSync();
      debugPrint('CLGSource:toTemporaryFile - ${e.message}: ${e.address} - $path');
    } catch (e) {
      if (file.existsSync()) file.deleteSync();
      debugPrint('CLGSource:toTemporaryFile - Error to load source: $path');
    }
    return null;
  }

  bool get isVideo {
    final ext = pathValidated.split('.').last.toLowerCase();
    return CLGFileType.video.ext.contains(ext);
  }

  bool get isImage {
    final ext = pathValidated.split('.').last.toLowerCase();
    return CLGFileType.image.ext.contains(ext);
  }

  bool get isAudio {
    final ext = pathValidated.split('.').last.toLowerCase();
    return CLGFileType.audio.ext.contains(ext);
  }

  String get pathValidated {
    if (type == CLGSourceType.url) {
      final uri = Uri.parse(path);
      return uri.path;
    }

    return path;
  }
}
