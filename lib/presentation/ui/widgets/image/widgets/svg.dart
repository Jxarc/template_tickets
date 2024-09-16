part of '../clg_image.dart';

class _Svg extends StatelessWidget {
  final _SourceType source;
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final String? placeholderPath;
  final BoxFit? fitPlaceholder;

  const _Svg({
    Key? key,
    required this.source,
    required this.path,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.placeholderPath,
    this.fitPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (source) {
      case _SourceType.asset:
        return SvgPicture.asset(
          path,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
        );
      case _SourceType.file:
        return SvgPicture.file(
          File(path),
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
        );
      case _SourceType.base64:
      case _SourceType.network:
        return _SvgNetwork(
          path,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          placeholder: placeholderPath,
          fitPlaceholder: fitPlaceholder,
        );
    }
  }
}
