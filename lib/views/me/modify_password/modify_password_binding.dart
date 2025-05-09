import 'package:dsfulfill_cient_app/views/me/modify_password/modify_password_controller.dart';
import 'package:get/get.dart';

class ModifyPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModifyPasswordController());
  }
}
