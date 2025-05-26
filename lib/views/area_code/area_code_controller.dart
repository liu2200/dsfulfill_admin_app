import 'package:dsfulfill_admin_app/models/area_code_model.dart';
import 'package:dsfulfill_admin_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AreaCodeController extends GetxController {
  final RxList<AreaCodeModel> areaCodeList = <AreaCodeModel>[].obs;
  final RxList<AreaCodeModel> filteredList = <AreaCodeModel>[].obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  get isTrue => null;

  @override
  void onInit() {
    super.onInit();
    getAreaCodeList();
    searchController.addListener(onSearch);
  }

  void onSearch() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredList.value = areaCodeList;
    } else {
      filteredList.value = areaCodeList.where((item) {
        return item.name.toLowerCase().contains(query) ||
            item.code.contains(query) ||
            (item.code2?.toLowerCase().contains(query) ?? false);
      }).toList();
    }
  }

  void getAreaCodeList() async {
    var result = await UserService.getPhoneAreaCodeList();
    areaCodeList.value = result;
    filteredList.value = result;
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
