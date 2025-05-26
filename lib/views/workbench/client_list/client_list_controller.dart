import 'package:dsfulfill_admin_app/models/custom_group_model.dart';
import 'package:dsfulfill_admin_app/models/customer_model.dart';
import 'package:dsfulfill_admin_app/models/staff_model.dart';
import 'package:dsfulfill_admin_app/services/custom_service.dart';
import 'package:dsfulfill_admin_app/services/marketing_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientListController extends GetxController {
  final clientList = <CustomerModel>[].obs;
  int pageIndex = 0;
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController keywordIdController = TextEditingController();
  final currencyModel = Get.find<AppState>().currencyModel;
  final staffList = <StaffModel>[].obs; //员工列表
  final RxList<CustomGroupModel> clientGroupList =
      <CustomGroupModel>[].obs; // 客户分组列表
  final RxString groupId = ''.obs;
  final RxString staffId = ''.obs;
  final RxString keywordType = '1'.obs;
  final keywordTypeList = [
    {"label": "客户昵称", "id": "1"},
    {"label": "手机号", "id": "2"},
    {"label": "邮箱", "id": "3"},
  ].obs;
  // 添加筛选条件计数
  final RxInt activeFiltersCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomGroupList();
    getStaffList();
  }

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  loadMoreList() async {
    Map<String, dynamic> dic = {
      "page": (++pageIndex),
      "id": keywordIdController.text,
      "keyword_type": keywordType.value,
      "keyword": keywordController.text,
      "group_id": groupId.value,
      "invite_id": "",
      "staff_id": staffId.value
    };
    Map result = await CustomService.getCustomList(dic);
    return result;
  }

  getCustomGroupList() async {
    var result = await CustomService.getCustomGroupList({
      'page': 1,
      'size': 1000,
    });
    if (result.isNotEmpty) {
      clientGroupList.value = result;
    }
  }

  getStaffList() async {
    var result = await MarketingService.getStaffList({"size": 1000});
    if (result.isNotEmpty) {
      staffList.value = result;
    }
  }

  reset() {
    keywordController.clear();
    keywordIdController.clear();
    groupId.value = '';
    staffId.value = '';
    keywordType.value = '1';
    activeFiltersCount.value = 0;
  }

  updateActiveFiltersCount() {
    int count = 0;
    if (keywordController.text.isNotEmpty) count++;
    if (groupId.value.isNotEmpty) count++;
    if (staffId.value.isNotEmpty) count++;
    activeFiltersCount.value = count;
  }
}
