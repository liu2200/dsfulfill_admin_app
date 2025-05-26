import 'dart:io';
import 'package:dsfulfill_admin_app/config/app_config.dart';
import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/edit_custom_event.dart';
import 'package:dsfulfill_admin_app/services/common_service.dart';
import 'package:dsfulfill_admin_app/services/me_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetBrandLogoController extends BaseController {
  final appState = Get.find<AppState>();
  final logoUrl = Rx<String?>(
      'https://api.dsfulfill.com/storage/admin/20250322-Pg4paaKRywzjrNmN.png');
  final iconUrl = Rx<String?>(
      'https://api.dsfulfill.com/storage/admin/20250322-QyoiInqqHZuUsrQm.png');
  final ImagePicker _picker = ImagePicker();
  final TextEditingController siteNameController = TextEditingController();
  final type = 'logo'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  onClose() {
    siteNameController.dispose();
    super.onClose();
  }

  void _loadInitialData() async {
    var res = await MeService.getCustomClient();
    if (res != null) {
      siteNameController.text = res.name;
      logoUrl.value = res.logo == ''
          ? 'https://api.dsfulfill.com/storage/admin/20250322-Pg4paaKRywzjrNmN.png'
          : res.logo;
      iconUrl.value = res.tabIcon == ''
          ? 'https://api.dsfulfill.com/storage/admin/20250322-QyoiInqqHZuUsrQm.png'
          : res.tabIcon;
    }
  }

  Future<void> uploadLogo() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    List imageUrl = await CommonService.uploadImage(File(image?.path ?? ''));
    if (imageUrl.isNotEmpty) {
      logoUrl.value = BaseUrls.getBaseUrl() + imageUrl[0]['path'];
    }
  }

  Future<void> uploadIcon() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    List imageUrl = await CommonService.uploadImage(File(image?.path ?? ''));
    if (imageUrl.isNotEmpty) {
      iconUrl.value = BaseUrls.getBaseUrl() + imageUrl[0]['path'];
    }
  }

  void submitForm() async {
    var result = await MeService.editCustomClientConfig({
      'name': siteNameController.text,
      'logo': logoUrl.value,
      'tab_icon': iconUrl.value,
    });
    if (result) {
      ApplicationEvent.getInstance().event.fire(EditCustomEvent());
      if (type.value == 'logo') {
        type.value = 'icon';
      } else {
        Get.back();
        Get.back();
      }
    }
  }
}
