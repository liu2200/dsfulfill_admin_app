import 'dart:io';
import 'package:dsfulfill_admin_app/services/common_service.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

/*
  上传图片
 */
class ImagePickers {
  /*
    图片选择
    不带编辑
   */
  static final ImagePicker _picker = ImagePicker();

  static void imagePicker(
      {required BuildContext context,
      Widget? child,
      required Function onSuccessCallback}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) =>
          child ??
          CupertinoActionSheet(
            title: Text('请选择上传方式'.tr),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('相册'.tr),
                onPressed: () {
                  Navigator.pop(context, 'gallery');
                },
              ),
              CupertinoActionSheetAction(
                child: Text('相机'.tr),
                onPressed: () {
                  Navigator.pop(context, 'camera');
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: AppText(text: '取消'.tr),
            ),
          ),
    ).then((String? type) async {
      XFile? image;

      if (type == 'camera') {
        image = await _picker.pickImage(source: ImageSource.camera);
      } else if (type == 'gallery') {
        image = await _picker.pickImage(source: ImageSource.gallery);
      }
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
          sourcePath: image.path,
          maxWidth: 800,
          maxHeight: 800,
        );
        if (croppedFile != null) {
          EasyLoading.show(status: 'uploading'.tr);
          List imageUrl =
              await CommonService.uploadImage(File(croppedFile.path));
          EasyLoading.dismiss();
          onSuccessCallback(imageUrl);
        }
      }
    });
  }

  static Future<String?> imagePickerByLibray() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  /*
    图片选择
    带裁剪
   */
  static void imagePickerEditor(
      {required BuildContext context,
      required Widget child,
      required Function onSuccessCallback}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String? type) async {
      XFile? image;
      if (type == 'camera') {
        image = await _picker.pickImage(source: ImageSource.camera);
      } else if (type == 'gallery') {
        image = await _picker.pickImage(source: ImageSource.gallery);
      }
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
            sourcePath: image.path,
            aspectRatio: const CropAspectRatio(ratioX: 75, ratioY: 31),
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
            ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'edit image'.tr,
                  toolbarColor: Colors.deepOrange,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'edit image'.tr,
              ),
            ]);
        if (croppedFile != null) {
          List imageUrl =
              await CommonService.uploadImage(File(croppedFile.path));
          onSuccessCallback(imageUrl);
        }
      }
    });
  }
}
