import 'package:dsfulfill_cient_app/views/workbench/product/product_detail/product_detail.controller.dart';
import 'package:get/get.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
