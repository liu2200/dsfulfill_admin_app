import 'package:dsfulfill_admin_app/views/guide_page/guide_controller.dart';
import 'package:get/get.dart';

class GuideBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GuideController());
  }
}
