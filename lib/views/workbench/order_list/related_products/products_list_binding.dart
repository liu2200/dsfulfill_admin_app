import 'package:dsfulfill_cient_app/views/workbench/order_list/related_products/products_list_controller.dart';
import 'package:get/get.dart';

class ProductsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsListController());
  }
}
