import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_detail/order_detall_controller.dart';
import 'package:dsfulfill_cient_app/views/workbench/widget/order_header_widget.dart';
import 'package:dsfulfill_cient_app/views/workbench/widget/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      backgroundColor: AppStyles.background,
      title: '订单详情'.tr,
      hasBack: true,
      // 固定底部按钮
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 34.h),
        decoration: const BoxDecoration(
          color: AppStyles.white,
        ),
        child: Obx(() {
          final showQuote =
              [0, 1, 2].contains(controller.orderDetail.value?.status);
          final showAbnormal = controller.abnormalStatus.value == 1;
          final hasTwoButtons = showQuote && showAbnormal;
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: hasTwoButtons
                  ? 100.h
                  : showQuote
                      ? 50.h
                      : 0, // 动态高度
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if ([0, 1, 2].contains(controller.orderDetail.value?.status))
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Routers.push(Routers.orderQuotation,
                              {'id': controller.orderDetail.value!.id});
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
                          text: '订单报价'.tr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppStyles.white,
                        ),
                      ),
                    ),
                  if (controller.abnormalStatus.value == 1)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: Get.context!,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: '异常提醒'.tr,
                                          fontSize: 16.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...controller.abnormal.value!
                                                .map((abnormal) => Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AppText(
                                                            text: abnormal
                                                                .abnormalTime,
                                                            fontSize: 14.sp,
                                                            color: const Color(
                                                                0xFFFE5C73),
                                                          ),
                                                          SizedBox(height: 5.h),
                                                          AppText(
                                                            text: abnormal
                                                                .description,
                                                            fontSize: 14.sp,
                                                            color: const Color(
                                                                0xFFFE5C73),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                          ],
                                        ),
                                        SizedBox(height: 16.h),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppStyles.primary,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: AppText(
                                              text: '知道了'.tr,
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                image: 'workbench/abnormal',
                                width: 20.w,
                                height: 20.h,
                              ),
                              AppText(
                                text: '异常处理'.tr,
                                fontSize: 12.sp,
                                color: const Color(0xFFFE5C73),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: Get.context!,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 12.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.10),
                                            blurRadius: 16,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...[
                                            '移入报价中'.tr,
                                            '重新获取运单号'.tr,
                                            '取消'.tr,
                                            '取消并退款'.tr,
                                            '忽略异常'.tr,
                                          ].asMap().entries.map((entry) =>
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.of(context).pop();
                                                  switch (entry.key) {
                                                    case 0:
                                                      // 移入报价中逻辑
                                                      Get.dialog(
                                                        AlertDialog(
                                                          content: AppText(
                                                            text:
                                                                '打回报价已支付的款项将自动退回，确定吗？'
                                                                    .tr,
                                                            fontSize: 14.sp,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: AppText(
                                                                text: '取消'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .textGrey,
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                controller
                                                                    .moveToQuote(
                                                                        context);
                                                              },
                                                              child: AppText(
                                                                text: '确定'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                      break;
                                                    case 1:
                                                      // 重新获取运单号逻辑
                                                      controller
                                                          .getExpress(context);
                                                      break;
                                                    case 2:
                                                      // 取消逻辑
                                                      Get.dialog(
                                                        AlertDialog(
                                                          content: AppText(
                                                            text: '确认取消订单吗？'.tr,
                                                            fontSize: 14.sp,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: AppText(
                                                                text: '取消'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .textGrey,
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                controller
                                                                    .orderCancel(
                                                                        context);
                                                              },
                                                              child: AppText(
                                                                text: '确定'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                      break;
                                                    case 3:
                                                      // 取消并退款逻辑
                                                      Get.dialog(
                                                        AlertDialog(
                                                          content: AppText(
                                                            text: '确认取消订单并退款吗？'
                                                                .tr,
                                                            fontSize: 14.sp,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: AppText(
                                                                text: '取消'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .textGrey,
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                controller
                                                                    .orderCancelAndRefund(
                                                                        context);
                                                              },
                                                              child: AppText(
                                                                text: '确定'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                      break;
                                                    case 4:
                                                      // 忽略异常逻辑
                                                      Get.dialog(
                                                        AlertDialog(
                                                          content: AppText(
                                                            text:
                                                                '确认要忽略异常吗？该操作不会进行任何处理直接移除订单异常'
                                                                    .tr,
                                                            fontSize: 14.sp,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: AppText(
                                                                text: '取消'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .textGrey,
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                controller
                                                                    .ignoreAbnormal(
                                                                        context);
                                                              },
                                                              child: AppText(
                                                                text: '确定'.tr,
                                                                fontSize: 14.sp,
                                                                color: AppStyles
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                      break;
                                                  }
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12.h),
                                                  child: Center(
                                                    child: AppText(
                                                      text: entry.value,
                                                      fontSize: 16.sp,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
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
                              text: '处理异常'.tr,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppStyles.white,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ));
        }),
      ),
      body: Obx(() {
        final order = controller.orderDetail.value;
        if (order == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: OrderHeaderWidget(order: order),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 16.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppStyles.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppStyles.white,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: TabBar(
                                controller: controller.tabController,
                                labelColor: AppStyles.primary,
                                unselectedLabelColor: const Color(0xFF999999),
                                indicatorColor: AppStyles.primary,
                                tabs: [
                                  Tab(text: '报价'.tr),
                                  Tab(text: '报关'.tr),
                                  Tab(text: '日志'.tr),
                                ],
                              ),
                            ),
                            Obx(() {
                              if (controller.tabIndex.value == 0) {
                                return _buildQuoteTab(order);
                              } else if (controller.tabIndex.value == 1) {
                                return _buildCustomsClearanceTab(order);
                              } else {
                                return _buildLogsTab(order);
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLogsTab(order) {
    final logs = order.logs ?? [];
    if (logs.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(24.w),
        child: Center(
          child: Text('暂无日志'.tr,
              style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: List.generate(logs.length, (index) {
          final log = logs[index];
          final isLast = index == logs.length - 1;
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧竖线+圆点
                SizedBox(
                  width: 28,
                  child: Column(
                    children: [
                      // 圆点
                      Container(
                        margin: EdgeInsets.only(top: 4.h, bottom: 0),
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: AppStyles.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // 非最后一行显示竖线
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: const Color(0xFFE6E6E6),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // 右侧内容
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 时间和用户（无边框）
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
                        child: Row(
                          children: [
                            Text(
                              log.createdAt ?? '',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 内容卡片
                      Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          log.content ?? '',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCustomsClearanceTab(order) {
    final lineItems = order.lineItems ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: List.generate(lineItems.length, (index) {
          final item = lineItems[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 第一行
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SKU:${item.sku}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
                // 第二行
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.declaration?['cn_name'] ?? '',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Text(
                      '${controller.currencyModel['code']} ${item.declaration?['unit_price'] ?? '-'}',
                      style: const TextStyle(
                        color: Color(0xFF2E9750),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 第三行
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.declaration?['material'] ?? '',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    Text(
                      '${item.declaration?['weight'] ?? '-'} (g)',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
                // code
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${item.variantId ?? '-'}',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuoteTab(order) {
    final lineItems = order.lineItems ?? [];
    if (lineItems.isEmpty) return const SizedBox();
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              ProductCardWidget(order: order),
              // 费用明细
              _buildFeeDetail(order),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeeDetail(order) {
    final quote = order.quotePrice ?? {};
    return Container(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _feeRow('库存消耗'.tr, '本企业'.tr),
          // Divider(height: 16.h, thickness: 0.5),
          // _feeRow('物流方式'.tr, '云途加拿大专线'.tr),
          // Divider(height: 16.h, thickness: 0.5),
          _feeRow('商品总报价'.tr, 'USD ${quote['goods_price'] ?? ''}'),
          _feeRow('物流总报价'.tr, 'USD ${quote['logistics_fee'] ?? ''}'),
          _feeRow('折扣优惠'.tr, 'USD ${quote['favourable_price'] ?? ''}'),
          _feeRow('其他补收'.tr, '- USD ${quote['other_supplement_price'] ?? ''}'),
          // _feeRow('报价人'.tr, '张三'),
          Divider(height: 16.h, thickness: 0.5),
          _feeRow('合计'.tr, 'USD ${quote['total_price'] ?? ''}', isTotal: true),
        ],
      ),
    );
  }

  Widget _feeRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppStyles.textBlack,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: AppStyles.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}
