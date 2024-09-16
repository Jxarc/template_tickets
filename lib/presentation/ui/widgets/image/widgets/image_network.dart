part of '../clg_image.dart';

class _ImageNetwork extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  final BoxFit? fitPlaceholder;

  const _ImageNetwork(
    this.path, {
    Key? key,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.fitPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typePlaceholder = _getType(placeholder ?? '');
    if (typePlaceholder == _SourceType.network) {
      throw 'Placeholder attribute should be a image asset: $placeholder';
    }

    final image = CLGImage(
      path: placeholder ?? CLGIcons.imageFile,
      color: placeholder != null ? null : context.theme.background,
      width: width,
      height: height,
      fit: fitPlaceholder,
    );
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: path,
      placeholder: (context, url) => image,
      errorWidget: (context, url, error) => image,
    );
  }
}
