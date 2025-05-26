import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/components/select_dropdown.dart';
import 'package:dsfulfill_admin_app/views/workbench/order_list/order_quotation/order_quotation_controller.dart';
import 'package:dsfulfill_admin_app/views/workbench/widget/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderQuotationView extends GetView<OrderQuotationController> {
  const OrderQuotationView({super.key});

  void _showEditDialog(
      BuildContext context, TextEditingController textController, String type) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.10), blurRadius: 16),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: '编辑'.tr,
                      fontSize: 15.sp,
                      color: AppStyles.textBlack,
                    ),
                    SizedBox(width: 16.w),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                AppText(
                  text: type == 'favourable' ? '折扣金额'.tr : '其他补价'.tr,
                  fontSize: 13.sp,
                  color: AppStyles.textBlack,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  child: BaseInput(
                    controller: textController,
                    hintText: '改价'.tr,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 42.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: () {
                      var bool = true;
                      controller.editPrice.value = textController.text;
                      bool = controller.customPriceEdit(type);
                      if (bool) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: AppText(
                      text: '确认'.tr,
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: AppStyles.white,
                    border: Border.all(color: AppStyles.line),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: AppText(
                      text: '取消'.tr,
                      color: AppStyles.textBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      backgroundColor: AppStyles.white,
      title: '订单报价'.tr,
      hasBack: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 34.h),
        decoration: const BoxDecoration(
          color: AppStyles.white,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.submitQuote();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: AppText(
                text: '提交'.tr,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppStyles.white,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final order = controller.orderDetail.value;
        if (order == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 28,
                              child: Column(
                                children: [
                                  // 圆点
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 4.h, bottom: 0),
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: AppStyles.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const AppText(
                                      text: '1',
                                      color: AppStyles.white,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  // 非最后一行显示竖线
                                  Expanded(
                                    child: Container(
                                      width: 2,
                                      color: const Color(0xFFE6E6E6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 右侧内容
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4.0),
                                    child: Row(
                                      children: [
                                        5.horizontalSpaceDiagonal,
                                        AppText(
                                          text:
                                              '${'匹配本地产品'.tr}(${order.lineItems?.length})',
                                          fontSize: 13.sp,
                                          color: AppStyles.textBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(() {
                                    final order = controller.orderDetail.value;
                                    if (order == null) return const SizedBox();
                                    return ProductCardWidget(
                                      order: order,
                                      isShowRelated: true,
                                      onTap: (item, index) {
                                        controller.skuSelectResult(item, index);
                                      },
                                    );
                                  }),
                                  10.verticalSpaceFromWidth,
                                  AppText(
                                    text: '库存消耗'.tr,
                                    fontSize: 13.sp,
                                    color: AppStyles.textBlack,
                                  ),
                                  10.verticalSpaceFromWidth,
                                  _InventoryRadio(controller: controller),
                                  10.verticalSpaceFromWidth,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 28,
                              child: Column(
                                children: [
                                  // 圆点
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 4.h, bottom: 0),
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: AppStyles.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const AppText(
                                      text: '2',
                                      color: AppStyles.white,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  // 非最后一行显示竖线
                                  Expanded(
                                    child: Container(
                                      width: 2,
                                      color: const Color(0xFFE6E6E6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 右侧内容
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4.0),
                                    child: Row(
                                      children: [
                                        5.horizontalSpaceDiagonal,
                                        AppText(
                                          text: '匹配物流渠道'.tr,
                                          fontSize: 13.sp,
                                          color: AppStyles.textBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.verticalSpaceFromWidth,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => SelectDropdown(
                                            hint: '请选择'.tr,
                                            items: controller.generationQuote
                                                    .value.channelList ??
                                                [],
                                            getId: (e) => e.id.toString(),
                                            showClear: false,
                                            getName: (e) => e.name ?? '',
                                            selectedId: controller
                                                        .expressLineId.value ==
                                                    0
                                                ? ''
                                                : controller.expressLineId.value
                                                    .toString(),
                                            onChanged: (id) {
                                              controller.expressLineId.value =
                                                  int.parse(id);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  10.verticalSpaceFromWidth,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 28,
                              child: Column(
                                children: [
                                  // 圆点
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 4.h, bottom: 0),
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: AppStyles.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const AppText(
                                      text: '3',
                                      color: AppStyles.white,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 右侧内容
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4.0),
                                    child: Row(
                                      children: [
                                        5.horizontalSpaceDiagonal,
                                        AppText(
                                          text: '报价核对'.tr,
                                          fontSize: 13.sp,
                                          color: AppStyles.textBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.verticalSpaceFromWidth,
                                  Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: const Color(0xFFE5E5E5)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 报价人
                                        AppText(
                                          text: '报价人'.tr,
                                          fontSize: 15.sp,
                                          color: AppStyles.textBlack,
                                        ),
                                        const SizedBox(height: 8),
                                        SelectDropdown(
                                          hint: '请选择报价人'.tr,
                                          items: controller.staffList,
                                          showClear: false,
                                          getId: (e) => e.id.toString(),
                                          getName: (e) => e.name,
                                          selectedId:
                                              controller.staffId.value == 0
                                                  ? ''
                                                  : controller.staffId.value
                                                      .toString(),
                                          onChanged: (id) {
                                            controller.staffId.value =
                                                int.parse(id);
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        // 明细行
                                        _feeRow('商品总价'.tr,
                                            '${controller.currencyModel['code']} ${controller.goodsPrice.value}'),
                                        _feeRow('物流总价'.tr,
                                            '${controller.currencyModel['code']} ${controller.logisticsPrice.value}'),
                                        _feeRow('折扣优惠'.tr,
                                            '${controller.currencyModel['code']} ${controller.favourablePrice.value}',
                                            editable: true, onEdit: () {
                                          _showEditDialog(
                                              context,
                                              TextEditingController(
                                                  text: controller
                                                      .editPrice.value),
                                              'favourable');
                                        }),
                                        _feeRow('其他补价'.tr,
                                            '${controller.currencyModel['code']} ${controller.generationQuote.value.otherSupplementPrice}',
                                            editable: true, onEdit: () {
                                          _showEditDialog(
                                              context,
                                              TextEditingController(
                                                  text: controller
                                                      .editPrice.value),
                                              'otherSupplementPrice');
                                        }),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            AppText(
                                              text: '(人工操作费)'.tr,
                                              fontSize: 12.sp,
                                              textAlign: TextAlign.right,
                                              color: AppStyles.textBlack,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.verticalSpaceFromWidth,
                                  Row(
                                    children: [
                                      AppText(
                                        text: '合计'.tr,
                                      ),
                                      SizedBox(width: 16.w),
                                      AppText(
                                        text:
                                            '${controller.currencyModel['code']} ${controller.totalPrice.value}',
                                        fontSize: 15.sp,
                                        color: AppStyles.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _InventoryRadio extends StatelessWidget {
  final OrderQuotationController controller;
  const _InventoryRadio({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            _buildRadio(0, '本企业'.tr),
            SizedBox(width: 16.w),
            _buildRadio(1, '客户库存'.tr),
          ],
        ));
  }

  Widget _buildRadio(int value, String label) {
    final isActive = controller.useCustomerStock.value == value;
    return GestureDetector(
      onTap: () {
        controller.useCustomerStock.value = value;
      },
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppStyles.primary : const Color(0xFFE6E6E6),
                width: 2,
              ),
            ),
            child: isActive
                ? Center(
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: AppStyles.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              color: isActive ? AppStyles.primary : AppStyles.textBlack,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// 费用行组件
Widget _feeRow(String label, String value,
    {bool editable = false, VoidCallback? onEdit}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      children: [
        SizedBox(
          width: 150.w,
          child: Text(label,
              style: TextStyle(fontSize: 15.sp, color: AppStyles.textBlack)),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              if (editable)
                GestureDetector(
                  onTap: onEdit,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: LoadAssetImage(
                      image: 'workbench/edit',
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
