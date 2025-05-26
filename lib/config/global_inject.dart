import 'package:get/get.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';

class GlobalInject {
  static Future<void> init() async {
    Get.put(AppState());
  }
}
