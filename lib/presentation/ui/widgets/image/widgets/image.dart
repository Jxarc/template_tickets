part of '../clg_image.dart';

class _Image extends StatelessWidget {
  final _SourceType source;
  final Widget? placeholder;
  final String placeholderPath;
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final BoxFit? fitPlaceholder;

  const _Image({
    Key? key,
    required this.source,
    required this.path,
    required this.fit,
    this.height,
    this.width,
    this.color,
    this.placeholder,
    this.placeholderPath = '',
    this.fitPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider image;
    switch (source) {
      case _SourceType.asset:
        image = AssetImage(path);
        break;
      case _SourceType.file:
        image = FileImage(File(path));
        break;
      case _SourceType.network:
        return _ImageNetwork(
          path,
          width: width,
          height: height,
          fit: fit,
          fitPlaceholder: fitPlaceholder,
        );

      case _SourceType.base64:
        var imgBase64 = path.replaceAll(RegExp('data:image/.*;base64,'), '');
        image = Image.memory(base64Decode(imgBase64)).image;
        break;
    }

    return Image(
      width: width,
      height: height,
      color: color,
      fit: fit,
      image: image,
      errorBuilder: (context, error, stackTrace) {
        _onError();
        return placeholder ?? CLGIcon(path: placeholderPath);
      },
    );
  }

  void _onError() {
    if (source == _SourceType.file) {
      final file = File(path);
      if (file.existsSync()) {
        file.deleteSync();
      }
      debugPrint('CLGImage: Error loading file ($path). File was deleted');
    }
  }
}
