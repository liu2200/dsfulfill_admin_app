import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BaseUtils {
  static void showToast(String message) {
    EasyLoading.showToast(message);
  }

  static void copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    showToast('复制成功'.tr);
  }
}
