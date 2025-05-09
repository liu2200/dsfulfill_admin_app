import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BaseController extends GetxController {
  showToast(
    String msg, {
    Duration? duration,
  }) {
    EasyLoading.showToast(msg.tr, duration: duration);
  }

  Future<void> showSuccess(String msg) {
    return EasyLoading.showSuccess(msg.tr);
  }

  showError(String msg) {
    EasyLoading.showError(msg.tr);
  }

  showLoading([String? msg]) {
    EasyLoading.show(status: (msg ?? '加载中').tr);
  }

  hideLoading() {
    EasyLoading.dismiss();
  }
}
