import 'package:dsfulfill_admin_app/views/workbench/client_list/client_detail/client_detail_controller.dart';
import 'package:get/get.dart';

class ClientDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientDetailController());
  }
}
