import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dsfulfill_cient_app/views/components/image/image_preview.dart';

class LoadNetworkImage extends StatefulWidget {
  const LoadNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.onPressed,
    this.enablePreview = false,
  });
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Function? onPressed;
  final bool enablePreview;

  @override
  State<LoadNetworkImage> createState() => _LoadNetworkImageState();
}

class _LoadNetworkImageState extends State<LoadNetworkImage> {
  bool _reload = false;

  @override
  Widget build(BuildContext context) {
    Widget image = widget.onPressed != null
        ? InkResponse(
            onTap: () => widget.onPressed!(),
            child: imageItem(),
          )
        : imageItem();

    if (widget.enablePreview) {
      return GestureDetector(
        onTap: () => showImagePreview(imageUrl: widget.url),
        child: image,
      );
    }

    return image;
  }

  Widget imageItem() {
    return CachedNetworkImage(
      imageUrl: widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      placeholder: (context, url) => Container(
        color: AppStyles.greyBg,
      ),
      errorWidget: (context, url, error) => GestureDetector(
        onTap: () {
          setState(() {
            _reload = !_reload;
          });
        },
        child: Container(
          color: AppStyles.greyBg,
          child: Icon(
            Icons.refresh,
            color: AppStyles.textSub,
            size: 20.sp,
          ),
        ),
      ),
      key: ValueKey(_reload),
    );
  }
}
