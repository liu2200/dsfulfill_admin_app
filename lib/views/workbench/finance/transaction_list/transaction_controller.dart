import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/models/customer_model.dart';
import 'package:dsfulfill_admin_app/services/finance_service.dart';
import 'package:dsfulfill_admin_app/services/marketing_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransactionController extends BaseController {
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController outSerialNoController = TextEditingController();
  final RxString customerIdController = ''.obs; // 选中的客户id
  final RxString status = ''.obs;
  int pageIndex = 0;
  final currencyModel = Get.find<AppState>().currencyModel;
  final RxList<CustomerModel> clientList = <CustomerModel>[].obs; // 客户列表
  final Rx<DateTime?> filterStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> filterEndDate = Rx<DateTime?>(null);
  final RxInt activeFiltersCount = 0.obs;
  final operation = [
    {"label": "增加", "id": "1"},
    {"label": "减少", "id": "2"},
  ].obs; //轨迹
  @override
  void onInit() {
    super.onInit();
    getCustomList();
  }

  @override
  void onClose() {
    keywordController.dispose();
    super.onClose();
  }

  getCustomList() async {
    var result = await MarketingService.getCustomList({
      'page': 1,
      'size': 1000,
    });
    clientList.value = result;
  }

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  loadMoreList() async {
    Map<String, dynamic> dic = {
      "page": (++pageIndex),
      "serial_no": keywordController.text,
      "end_date": filterEndDate.value,
      "begin_date": filterStartDate.value,
      "customer_id": customerIdController.value,
      "out_serial_no": outSerialNoController.text,
      "type": status.value,
    };
    Map result = await FinanceService.getBalanceRecordList(dic);
    return result;
  }

  copySerialNo(String serialNo) async {
    await Clipboard.setData(ClipboardData(text: serialNo));
    showToast('复制成功'.tr);
  }

  reset() {
    customerIdController.value = '';
    status.value = '';
    filterStartDate.value = null;
    filterEndDate.value = null;
    keywordController.text = '';
    outSerialNoController.text = '';
    activeFiltersCount.value = 0;
  }

  // 更新活跃筛选条件计数
  updateActiveFiltersCount() {
    int count = 0;
    // 检查各个筛选条件是否有值
    if (customerIdController.value.isNotEmpty) count++;
    if (outSerialNoController.text.isNotEmpty) count++;
    if (filterStartDate.value != null || filterEndDate.value != null) count++;
    // 检查其他状态筛选
    if (status.value.isNotEmpty) count++;
    activeFiltersCount.value = count;
  }
}
