import 'package:dsfulfill_cient_app/views/me/set_brand_logo/set_brand_logo_controller.dart';
import 'package:get/get.dart';

class SetBrandLogoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetBrandLogoController());
  }
}
