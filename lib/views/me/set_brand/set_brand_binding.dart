import 'package:dsfulfill_cient_app/views/me/set_brand/set_brand_controller.dart';
import 'package:get/get.dart';

class SetBrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetBrandController());
  }
}
