import 'package:dsfulfill_cient_app/views/me/set_theme/set_theme_controller.dart';
import 'package:get/get.dart';

class SetThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetThemeController());
  }
}
