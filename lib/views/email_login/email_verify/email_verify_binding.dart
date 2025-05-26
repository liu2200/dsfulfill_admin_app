import 'package:dsfulfill_admin_app/views/email_login/email_verify/email_verify_controller.dart';
import 'package:get/get.dart';

class EmailVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerifyController());
  }
}
