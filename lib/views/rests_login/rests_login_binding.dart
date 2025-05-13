import 'package:dsfulfill_cient_app/views/rests_login/rests_login_controller.dart';
import 'package:get/get.dart';

class RestLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestLoginController());
  }
}
