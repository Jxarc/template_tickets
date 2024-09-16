part of '../clg_image.dart';

enum _SourceType { file, asset, network, base64 }

_SourceType _getType(String path) {
  final regexAsset = RegExp('^(packages/.+/)?assets?/.*\$');
  final regexNetwork = RegExp('^https?://.*');

  if (regexAsset.hasMatch(path)) {
    return _SourceType.asset;
  } else if (regexNetwork.hasMatch(path)) {
    return _SourceType.network;
  } else if (_validBase64(path)) {
    return _SourceType.base64;
  }

  return _SourceType.file;
}

String _getExt(String path) {
  if (path.isEmpty) return '';
  if (_validBase64(path)) return 'jpg';
  final parts = path.toLowerCase().split('.');
  return parts[parts.length - 1];
}

bool _validBase64(String text) {
  final regex = RegExp('^data:image/.*;base64,.*');
  return regex.hasMatch(text);
}
