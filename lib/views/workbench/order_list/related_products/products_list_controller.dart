import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/models/skus_model.dart';
import 'package:dsfulfill_admin_app/services/workbench_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsListController extends BaseController {
  final TextEditingController keywordController = TextEditingController();
  int pageIndex = 0;
  final skuList = <SkusModel>[].obs;
  final attrs = <String>[].obs;
  final selectSku = Rxn<SkusModel>();
  final currencyModel = Get.find<AppState>().currencyModel;

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  loadMoreList() async {
    Map<String, dynamic> dic = {
      "page": (++pageIndex),
      "any_keyword": keywordController.text,
      "goods_type": '1',
    };
    Map result = await WorkbenchService.getGoodsList(dic);
    return result;
  }

  getGoodsSkuList(id) async {
    attrs.value = [];
    selectSku.value = null;
    Map<String, dynamic> dic = {
      "page": 1,
      "goods_id": id,
      "size": 2000,
    };
    var result = await WorkbenchService.getGoodsSkuList(dic);
    if (result.isNotEmpty) {
      skuList.value = result;
    }
  }

  submitSku(BuildContext context) {
    var bool = true;
    if (selectSku.value == null) {
      bool = false;
      return showToast('请选择商品'.tr);
    } else {
      Navigator.of(context).pop(selectSku.value);
    }
    return bool;
  }

  void selectSpec(String name, int index) {
    if (attrs.length > index) {
      attrs[index] = name;
    } else {
      while (attrs.length <= index) {
        attrs.add('');
      }
      attrs[index] = name;
    }
    attrs.refresh();
    String properties = attrs.join('/');
    var skus = skuList.where((item) => item.specName == properties).toList();
    if (skus.isNotEmpty) {
      selectSku.value = skus[0];
    }
  }
}
