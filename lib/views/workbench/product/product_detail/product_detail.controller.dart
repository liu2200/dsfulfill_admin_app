import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/models/product_model.dart';
import 'package:dsfulfill_cient_app/services/workbench_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class ProductDetailController extends BaseController {
  final id = 0.obs;
  final currentPage = 0.obs; // 当前轮播图页码
  final tabIndex = 0.obs; // 当前选中的Tab
  final productDetail = Rxn<ProductModel>();
  var detail = {};
  late PageController pageController;
  Timer? _autoPlayTimer;
  final TextEditingController quotePriceController =
      TextEditingController(); //产品报价
  final TextEditingController purchasePriceController =
      TextEditingController(); //采购价
  final TextEditingController weightController = TextEditingController(); //产品重量
  final TextEditingController lengthController = TextEditingController(); //产品尺寸
  final TextEditingController widthController = TextEditingController(); //产品尺寸
  final TextEditingController heightController = TextEditingController(); //产品尺寸
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    if (Get.arguments != null && Get.arguments['id'] != null) {
      getGoodsDetails(Get.arguments['id']);
    }
  }

  @override
  void onReady() {
    super.onReady();
    // 启动自动轮播
    startAutoPlay();
  }

  @override
  void onClose() {
    pageController.dispose();
    quotePriceController.dispose();
    purchasePriceController.dispose();
    weightController.dispose();
    lengthController.dispose();
    widthController.dispose();
    heightController.dispose();
    stopAutoPlay();
    super.onClose();
  }

  updateProduct() async {
    if (quotePriceController.text.isEmpty ||
        purchasePriceController.text.isEmpty ||
        weightController.text.isEmpty ||
        lengthController.text.isEmpty ||
        widthController.text.isEmpty ||
        heightController.text.isEmpty) {
      showToast('请输入完整信息'.tr);
      return false;
    }
    var sku = [];
    for (var item in detail['skus'] ?? []) {
      sku.add({
        'id': item['id'],
        'defaultSupplier': item['defaultSupplier'],
        'goods_suppliers': item['goods_suppliers'],
        'images': item['images'].map((e) => e).toList(),
        'spec_info': item['spec_info'],
        'sku_id': item['sku_id'],
        'quote_price': quotePriceController.text,
        'purchase_price': purchasePriceController.text,
        'weight': weightController.text,
        'length': lengthController.text,
        'width': widthController.text,
        'height': heightController.text,
        'status': item['status'],
        'spec_name': item['spec_name'],
      });
    }
    var params = {
      'goods_name': productDetail.value?.goodsName,
      'category_id': productDetail.value?.categoryId,
      'cover_image': productDetail.value?.coverImage,
      'main_images': productDetail.value?.mainImages,
      'purchase_url': productDetail.value?.purchaseUrl,
      'purchase_price': productDetail.value?.purchasePrice,
      'alias': detail['alias'],
      'detail': detail['detail'],
      'unit': detail['unit'],
      'skus': sku,
      'options': detail['options'],
      'logistics': detail['logistics'],
      'props': detail['props'],
      'addr': detail['addr'],
      'developer_id': detail['developer_id'],
      'goods_type': detail['goods_type'],
      'packing_materials_type': detail['packing_materials_type'],
      'main_video': detail['main_video']
    };
    var result =
        await WorkbenchService.updateGoods(productDetail.value!.id, params);
    if (result) {
      getGoodsDetails(productDetail.value!.id);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
    }
    return result;
  }

  // 启动自动轮播
  void startAutoPlay() {
    stopAutoPlay(); // 先停止已有的定时器
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (productDetail.value != null) {
        final imageCount = (productDetail.value!.mainImages).length;
        if (imageCount > 1) {
          final nextPage = (currentPage.value + 1) % imageCount;
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  // 停止自动轮播
  void stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  getGoodsDetails(id) async {
    var result = await WorkbenchService.getGoodsDetails(id);
    productDetail.value = ProductModel.fromJson(result!);
    detail = result;
  }
}
