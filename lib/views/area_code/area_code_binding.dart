import 'package:dsfulfill_cient_app/views/area_code/area_code_controller.dart';
import 'package:get/get.dart';

class AreaCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AreaCodeController());
  }
}
