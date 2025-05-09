import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/models/generation_quote_model.dart';
import 'package:dsfulfill_cient_app/models/line_items_model.dart';
import 'package:dsfulfill_cient_app/models/order_model.dart';
import 'package:dsfulfill_cient_app/models/staff_model.dart';
import 'package:dsfulfill_cient_app/services/marketing_service.dart';
import 'package:dsfulfill_cient_app/services/workbench_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:get/get.dart';

class OrderQuotationController extends BaseController {
  final orderDetail = Rxn<OrderModel>();
  final staffId = 0.obs; //员工ID
  final expressLineId = 0.obs; //物流方式
  final isSubmitQuote = false.obs; //是否提交报价
  final orderOnePrice = 0.obs; //是否开启商品一口价
  final customLogisticPrice = '-1'.obs;
  final customFavourablePrice = '-1'.obs; //优惠金额
  final otherSupplementPrice = ''.obs; //其他补价
  final useCustomerStock = 0.obs; //库存消耗 0 本企业 1客户 使用客户库存时不计算商品报价
  final mappingList = [].obs; //sku物流总报价
  final generationQuote = GenerationQuoteModel().obs;
  final staffList = <StaffModel>[].obs; //员工列表
  final currencyModel = Get.find<AppState>().currencyModel;

  final goodsPrice = ''.obs; //商品总价
  final logisticsPrice = ''.obs; //物流总价
  final favourablePrice = ''.obs; //优惠总价
  final totalPrice = ''.obs; //合计

  final editPrice = ''.obs; //修改金额

  final activeRow = Rxn<LineItemsModel>(); //选择产品列表

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['id'] != null) {
      getOrderDetail(Get.arguments['id'].toString());
    }
    getStaffList();
  }

  getStaffList() async {
    var result = await MarketingService.getStaffList({"size": 1000});
    if (result.isNotEmpty) {
      staffList.value = result;
    }
  }

  void skuSelectResult(item, index) async {
    activeRow.value = item;
    var s = await Get.toNamed(Routers.productRelevancy);
    if (s != null) {
      if (item.mapping != null) {
        item.mapping.goodsSku = s;
        orderDetail.refresh(); // 让所有依赖 orderDetail 的 Obx 刷新
        mappingList[index] = {'sku_id': s.id, 'line_item_id': item.id};
        generationQuoteInfo();
      }
    }
  }

  getOrderDetail(String id) async {
    var result = await WorkbenchService.orderQuoteInfo(id);
    if (result != null) {
      staffId.value = result['staff_id'] ?? '';
      expressLineId.value = result['express_line_id'] ?? '';
      if (result['line_items'] != null) {
        for (var item in result['line_items']!) {
          mappingList.add(
              {'sku_id': item['goods_sku_id'], 'line_item_id': item['id']});
        }
      }
      if (result['quote_price'] != null) {
        otherSupplementPrice.value =
            result['quote_price']['other_supplement_price'];
        useCustomerStock.value = result['quote_price']['use_customer_stock'];

        if (result['quote_price']['logistics_fee'] !=
            result['quote_price']['logistics_compute_fee']) {
          customLogisticPrice.value = result['quote_price']['logistics_fee'];
        }
        if (result['quote_price']['favourable_price'] !=
            result['quote_price']['favourable_compute_price']) {
          customFavourablePrice.value =
              result['quote_price']['favourable_price'];
        }
      }
      orderDetail.value = OrderModel.fromJson(result);
      generationQuoteInfo();
    }
  }

  customPriceEdit(String type) {
    var boole = true;
    if (editPrice.value.isEmpty) {
      boole = false;
      showToast('请输入金额'.tr);
    } else {
      if (type == 'favourable') {
        customFavourablePrice.value = editPrice.value;
      } else if (type == 'otherSupplementPrice') {
        otherSupplementPrice.value = editPrice.value;
      }
      generationQuoteInfo();
      editPrice.value = '';
    }
    return boole;
  }

  generationQuoteInfo() async {
    var result =
        await WorkbenchService.generationQuoteInfo(orderDetail.value!.id, {
      'custom_favourable_price': customFavourablePrice.value,
      'custom_logistic_price': customLogisticPrice.value,
      'express_line_id': expressLineId.value,
      'is_submit_quote': isSubmitQuote.value,
      'mapping_list': mappingList,
      'order_one_price': orderOnePrice.value,
      'other_supplement_price': otherSupplementPrice.value,
      'use_customer_stock': useCustomerStock.value,
      'staff_id': staffId.value,
    });
    if (result != null) {
      generationQuote.value = result;
      goodsPrice.value = result.goodsPrice ?? '';
      logisticsPrice.value = result.logisticsFee ?? '';
      favourablePrice.value = result.favourablePrice ?? '';
      totalPrice.value = result.totalPrice ?? '';
    }
  }

  submitQuote() async {
    if (mappingList.isEmpty) {
      showToast('未关联sku'.tr);
      return;
    }
    var result = await WorkbenchService.mappingQuote(orderDetail.value!.id, {
      "mapping_list": mappingList,
      "is_submit_quote": true,
      "staff_id": staffId.value,
      "express_line_id": expressLineId.value,
      "order_one_price": orderOnePrice.value,
      "other_supplement_price": otherSupplementPrice.value,
      "use_customer_stock": useCustomerStock.value,
      "custom_favourable_price": customFavourablePrice.value,
      "custom_logistic_price": customLogisticPrice.value,
    });
    if (result != null) {
      showToast('提交成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Get.back();
    }
  }
}
