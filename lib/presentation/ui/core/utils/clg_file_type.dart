import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

enum CLGFileType {
  pdf,
  audio,
  image,
  video,
  excel,
  word,
  powerPoint,
  other,
  csv,
  compress;

  factory CLGFileType.fromExtension(String ext) {
    for (var value in CLGFileType.values) {
      if (value.ext.contains(ext.toLowerCase())) {
        return value;
      }
    }

    return CLGFileType.other;
  }
}

extension CLGFileTypeExtension on CLGFileType {
  String get iconPath => switch (this) {
        CLGFileType.pdf => CLGIcons.pdfFile,
        CLGFileType.audio => CLGIcons.audioFile,
        CLGFileType.image => CLGIcons.imageFile,
        CLGFileType.video => CLGIcons.videoFile,
        CLGFileType.excel => CLGIcons.xlsFile,
        CLGFileType.word => CLGIcons.docFile,
        CLGFileType.powerPoint => CLGIcons.pptFile,
        CLGFileType.csv => CLGIcons.csvFile,
        CLGFileType.compress => CLGIcons.compressFile,
        CLGFileType.other => CLGIcons.unkownFile,
      };

  Widget get icon => CLGImage(path: iconPath);

  List<String> get ext {
    switch (this) {
      case CLGFileType.pdf:
        return ['pdf'];
      case CLGFileType.audio:
        return ['mp3', 'wav', 'aac'];
      case CLGFileType.image:
        return ['gif', 'jpg', 'jpeg', 'png', 'svg'];
      case CLGFileType.video:
        return ['mp4', 'avi', 'mov', 'hevc'];
      case CLGFileType.excel:
        return ['xls', 'xlsx'];
      case CLGFileType.word:
        return ['doc', 'docx'];
      case CLGFileType.powerPoint:
        return ['ppt', 'ppsx', 'pptx'];
      case CLGFileType.csv:
        return ['csv'];
      case CLGFileType.compress:
        return ['zip', 'rar'];
      case CLGFileType.other:
        return ['doc', 'docx'];
    }
  }
}
