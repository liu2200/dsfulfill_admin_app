import 'package:dsfulfill_admin_app/views/components/image/image_preview.dart';
import 'package:flutter/material.dart';

class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage({
    super.key,
    required this.image,
    this.suffix = 'png',
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
    this.onPressed,
    this.enablePreview = false,
  });
  final String image;
  final String suffix;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final Function? onPressed;
  final bool enablePreview;

  @override
  Widget build(BuildContext context) {
    Widget imageItem = Image.asset(
      'assets/images/$image.$suffix',
      width: width,
      height: height,
      color: color,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      },
    );

    if (enablePreview) {
      return GestureDetector(
        onTap: () =>
            showImagePreview(assetPath: 'assets/images/$image.$suffix'),
        child: imageItem,
      );
    }

    return onPressed != null
        ? InkResponse(
            onTap: () {
              onPressed!();
            },
            child: imageItem,
          )
        : imageItem;
  }

  Widget imageItem() {
    return Image.asset(
      'assets/images/$image.$suffix',
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }
}
