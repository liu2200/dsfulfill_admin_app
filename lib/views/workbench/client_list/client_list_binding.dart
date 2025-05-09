import 'package:dsfulfill_cient_app/views/workbench/client_list/client_list_controller.dart';
import 'package:get/get.dart';

class ClientListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientListController());
  }
}
