import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:template/presentation/ui/ui.dart';

part 'type/source_type.dart';
part 'widgets/image.dart';
part 'widgets/image_network.dart';
part 'widgets/svg.dart';
part 'widgets/svg_network.dart';

class CLGImage extends StatelessWidget {
  final String path;
  final String? placeholderPath;
  final Widget? placeholder;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxFit fitPlaceholder;
  final Color? color;
  final Duration? cacheDuration;
  final bool useS3;

  const CLGImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.placeholder,
    this.placeholderPath,
    this.fitPlaceholder = BoxFit.none,
    this.cacheDuration,
    this.useS3 = false,
  });

  @override
  Widget build(BuildContext context) {
    final source = _getType(path.trim());

    if (source == _SourceType.network || useS3) {
      return FutureBuilder(
        future: _checkStat(),
        builder: (context, snapshot) {
          Widget? image;
          if (snapshot.data != null) {
            image = _getImage(snapshot.data!.path);
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: image ?? placeholder ?? const SizedBox(),
          );
        },
      );
    }

    return _getImage(path);
  }

  Future<File?> _checkStat() async {
    final isFile = File(path).existsSync();
    final source = isFile ? CLGSource.file(path) : CLGSource.url(path, useS3: useS3);

    if (source.path.isNotEmpty) {
      final file = await source.getCacheFile();
      if (cacheDuration != null && file.existsSync()) {
        final fileStat = file.statSync();
        final currentDate = DateTime.now().secondsSinceEpoch;
        final modifiedDate = fileStat.modified.secondsSinceEpoch;
        final diff = Duration(seconds: currentDate - modifiedDate);

        if (diff > cacheDuration!) {
          file.deleteSync();
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }

      return source.toTemporaryFile();
    }

    return null;
  }

  Widget _getImage(String path) {
    final defaultPlaceholder = placeholderPath ?? CLGIcons.unkownFile;
    final pathValidated = path.isEmpty ? defaultPlaceholder : path;
    final fitValidated = path.isEmpty ? fitPlaceholder : fit;
    final ext = _getExt(pathValidated);
    final source = _getType(pathValidated);
    return ext == 'svg'
        ? _Svg(
            path: pathValidated,
            source: source,
            fit: fitValidated,
            height: height,
            width: width,
            color: color,
            placeholderPath: defaultPlaceholder,
            fitPlaceholder: fitPlaceholder,
          )
        : _Image(
            path: pathValidated,
            source: source,
            fit: fitValidated,
            height: height,
            width: width,
            color: color,
            placeholder: placeholder,
            placeholderPath: defaultPlaceholder,
            fitPlaceholder: fitPlaceholder,
          );
  }
}
