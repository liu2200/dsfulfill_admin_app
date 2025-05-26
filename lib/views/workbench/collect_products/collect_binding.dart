import 'package:dsfulfill_admin_app/views/workbench/collect_products/collect_controller.dart';
import 'package:get/get.dart';

class CollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectController());
  }
}
