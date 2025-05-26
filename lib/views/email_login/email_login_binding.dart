import 'package:dsfulfill_admin_app/views/email_login/email_login_controller.dart';
import 'package:get/get.dart';

class EmailLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailLoginController());
  }
}
