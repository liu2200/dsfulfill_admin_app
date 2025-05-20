import 'package:dsfulfill_cient_app/services/workbench_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController keywordController = TextEditingController();
  final tabIndex = 0.obs;
  late TabController tabController;
  int pageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  loadMoreList() async {
    Map<String, dynamic> dic = {
      "page": (++pageIndex),
      "keyword": keywordController.text,
      "search_type": "goods_name",
      "status": '',
    };
    Map result = await WorkbenchService.getGoodsList(dic);
    return result;
  }
}
