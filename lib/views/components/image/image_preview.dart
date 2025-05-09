import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final Uint8List? imageBytes;

  const ImagePreview({
    Key? key,
    this.imageUrl,
    this.assetPath,
    this.imageBytes,
  })  : assert(imageUrl != null || assetPath != null || imageBytes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: _getImageProvider(),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded /
                      (event.expectedTotalBytes ?? 1),
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider() {
    if (imageUrl != null) {
      return NetworkImage(imageUrl!);
    } else if (assetPath != null) {
      return AssetImage(assetPath!);
    } else {
      return MemoryImage(imageBytes!);
    }
  }
}

// 打开图片预览的工具方法
void showImagePreview({
  String? imageUrl,
  String? assetPath,
  Uint8List? imageBytes,
}) {
  Get.to(
    () => ImagePreview(
      imageUrl: imageUrl,
      assetPath: assetPath,
      imageBytes: imageBytes,
    ),
    transition: Transition.zoom,
  );
}
