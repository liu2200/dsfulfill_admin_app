import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/models/goods_category_model.dart';
import 'package:dsfulfill_admin_app/models/supplier_model.dart';
import 'package:dsfulfill_admin_app/services/workbench_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectController extends BaseController {
  // 表单控制器
  final TextEditingController productLinkController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final RxString selectedCategoryName = ''.obs; // 用于显示的分类名称
  final RxInt selectedCategoryId = RxInt(0); // 存储选择的分类ID
  final RxString selectedSupplierName = ''.obs; // 用于显示的供应商名称
  final RxInt selectedSupplierId = RxInt(0); // 存储选择的供应商ID
  final TextEditingController profitController = TextEditingController();

  // 加载状态
  final RxBool isSubmitting = false.obs;
  final RxBool isLoadingCategories = false.obs;

  // 语言选择
  final RxString selectedLanguage = 'en_US'.obs;
  final List<Map<String, String>> languages = [
    {'value': 'en_US', 'label': 'English'.tr},
    {'value': 'zh_CN', 'label': '中文'.tr},
  ];

  // 分类列表
  final RxList<GoodsCategoryModel> categoryList = <GoodsCategoryModel>[].obs;

  // 供应商列表
  final RxList<SupplierModel> supplierList = <SupplierModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategory();
    loadSupplier();
  }

  @override
  void onClose() {
    productLinkController.dispose();
    weightController.dispose();
    profitController.dispose();
    selectedCategoryName.value = '';
    selectedCategoryId.value = 0;
    selectedSupplierName.value = '';
    selectedSupplierId.value = 0;
    selectedLanguage.value = 'zh_CN';
    super.onClose();
  }

  void loadCategory() async {
    isLoadingCategories.value = true;
    try {
      var result = await WorkbenchService.getGoodsCategory({
        'name': '',
        'status': '',
      });

      if (result.isNotEmpty) {
        categoryList.clear();
        categoryList.addAll(result);
      }
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void loadSupplier() async {
    try {
      var result = await WorkbenchService.getSupplierList({
        'page': 1,
        'size': 1000,
      });
      if (result.isNotEmpty) {
        supplierList.value = result;
      } else {
        print('没有加载到供应商数据');
      }
    } catch (e) {
      print('加载供应商错误: $e');
    }
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  // 选择分类（一级或二级），只保存ID
  void selectCategory(int categoryId, String categoryName) {
    selectedCategoryId.value = categoryId;
    selectedCategoryName.value = categoryName;
  }

  // 选择供应商，只保存ID
  void selectSupplier(int supplierId, String supplierName) {
    selectedSupplierId.value = supplierId;
    selectedSupplierName.value = supplierName;
  }

  // 根据名称查找供应商ID
  SupplierModel? findSupplierByName(String name) {
    try {
      return supplierList
          .firstWhere((supplier) => supplier.supplierName == name);
    } catch (e) {
      return null;
    }
  }

  bool validateForm() {
    // 检查产品链接是否已输入
    if (productLinkController.text.isEmpty) {
      showToast('请输入产品链接'.tr);
      return false;
    }

    // 检查产品重量是否已输入
    if (weightController.text.isEmpty) {
      showToast('请输入产品重量'.tr);
      return false;
    }

    // 尝试解析重量为数字
    try {
      double weight = double.parse(weightController.text);
      if (weight <= 0) {
        showToast('产品重量必须大于0'.tr);
        return false;
      }
    } catch (e) {
      showToast('请输入有效的产品重量'.tr);
      return false;
    }

    // 检查产品分类是否已选择
    if (selectedCategoryId.value <= 0) {
      showToast('请选择产品分类'.tr);
      return false;
    }

    // 检查供应商是否已选择
    if (selectedSupplierId.value <= 0) {
      showToast('请选择供应商'.tr);
      return false;
    }
    return true;
  }

  void submitForm() async {
    if (!validateForm()) {
      return;
    }
    isSubmitting.value = true;
    // 构建提交数据
    final Map<String, dynamic> formData = {
      'category_id': selectedCategoryId.value,
      'supplier_id': selectedSupplierId.value,
      'url': productLinkController.text,
      'language': selectedLanguage.value,
      'weight': double.parse(weightController.text),
      'profit': profitController.text.isNotEmpty
          ? double.parse(profitController.text)
          : 0,
      'fixed_price': 0,
      'percentage': 0
    };
    try {
      bool result = await WorkbenchService.collectProduct(formData);
      isSubmitting.value = false;
      if (result) {
        showToast('提交成功'.tr);
        Get.back(result: true);
      } else {
        showToast('提交失败，请稍后重试'.tr);
      }
    } catch (e) {
      isSubmitting.value = false;
      showToast('提交出错: $e'.tr);
    }
  }
}
