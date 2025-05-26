import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/models/order_model.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:dsfulfill_admin_app/utils/base_utils.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DashedBorder extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedBorder({
    this.color = const Color(0xFFE5E5E5),
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double dashWidth = 5.0;
    double dashSpace = gap;
    double distance = 0;

    // Top line
    while (distance < size.width) {
      canvas.drawLine(
        Offset(distance, 0),
        Offset(distance + dashWidth, 0),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    // Right line
    distance = 0;
    while (distance < size.height) {
      canvas.drawLine(
        Offset(size.width, distance),
        Offset(size.width, distance + dashWidth),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    // Bottom line
    distance = 0;
    while (distance < size.width) {
      canvas.drawLine(
        Offset(distance, size.height),
        Offset(distance + dashWidth, size.height),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    // Left line
    distance = 0;
    while (distance < size.height) {
      canvas.drawLine(
        Offset(0, distance),
        Offset(0, distance + dashWidth),
        paint,
      );
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class OrderHeaderWidget extends StatelessWidget {
  OrderHeaderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;

  final currencyModel = Get.find<AppState>().currencyModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppStyles.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        children: [
          _buildOrderHeader(order),
          const SizedBox(height: 12),
          if (order.shippingAddress?.country != '') _buildAddress(order),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppStyles.background,
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 左侧店铺信息
              Row(
                children: [
                  LoadAssetImage(
                    image: 'workbench/${order.platform}',
                    width: 24.w,
                    height: 24.w,
                  ),
                  8.horizontalSpace,
                  SizedBox(
                    width: 100.w,
                    child: AppText(
                      text: order.shop?.shopName ?? '',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // 右侧状态标签
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFDEF9D4),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: AppText(
                  text: order.statusName,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppStyles.primary,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          // 第二行：订单号和金额
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppText(
                    text: order.name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () => BaseUtils.copy(order.name),
                    child: Icon(
                      Icons.copy,
                      size: 16.sp,
                      color: AppStyles.primary,
                    ),
                  ),
                ],
              ),
              AppText(
                text:
                    '${currencyModel['code']} ${order.quotePrice?['total_price'] ?? '0'}',
                fontSize: 14.sp,
                color: const Color(0xFF2E9750),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          12.verticalSpace,
          // 状态标签区域
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Wrap(
              spacing: 10.w, // 水平间距
              runSpacing: 10.h, // 垂直间距
              alignment: WrapAlignment.start, // 水平左对齐
              crossAxisAlignment: WrapCrossAlignment.center, // 垂直居中
              children: [
                if (order.isShipping == 1)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadAssetImage(
                        image: 'workbench/shipment',
                        width: 20.w,
                        height: 20.w,
                      ),
                      4.horizontalSpace,
                      AppText(
                        text: '交运'.tr,
                        fontSize: 13.sp,
                        color: const Color(0xFF279A32),
                      ),
                    ],
                  ),
                if (order.stockStatus == 'lack')
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadAssetImage(
                        image: 'workbench/stockout',
                        width: 20.w,
                        height: 20.w,
                      ),
                      4.horizontalSpace,
                      AppText(
                        text: '缺货'.tr,
                        fontSize: 13.sp,
                        color: const Color(0xFFE37318),
                      ),
                    ],
                  ),
                if (order.financialStatus == 4)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadAssetImage(
                        image: 'workbench/refund',
                        width: 20.w,
                        height: 20.w,
                      ),
                      4.horizontalSpace,
                      AppText(
                        text: '退款'.tr,
                        fontSize: 13.sp,
                        color: const Color(0xFFFE5C73),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddress(order) {
    final addr = order.shippingAddress;
    if (addr == null) return const SizedBox();
    return CustomPaint(
      painter: DashedBorder(),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: addr.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppStyles.textBlack,
                ),
                GestureDetector(
                  onTap: () {
                    BaseUtils.copy(
                        '${'名'.tr}:${addr.name}\n${'国家/地区'.tr}:${addr.country ?? ''}\n${'省/州'.tr}:${addr.province ?? ''}\n${'城市'.tr}: ${addr.city ?? ''}\n${'地址'.tr}:${addr.address1 ?? ''} ${addr.address2 ?? ''}\n${'电话'.tr}:${addr.phone ?? ''}\n${'邮编'.tr}:${addr.zip ?? ''}');
                  },
                  child: Icon(
                    Icons.copy,
                    size: 16.sp,
                    color: AppStyles.primary,
                  ),
                ),
              ],
            ),
            5.verticalSpaceFromWidth,
            AppText(
              text: '${addr.address1 ?? ''} ${addr.address2 ?? ''}',
              fontSize: 14.sp,
            ),
            5.verticalSpaceFromWidth,
            AppText(
              text: '${addr.city ?? ''} ${addr.province ?? ''}',
              fontSize: 14.sp,
            ),
            5.verticalSpaceFromWidth,
            AppText(
              text: '${addr.country ?? ''}',
              fontSize: 14.sp,
            ),
            5.verticalSpaceFromWidth,
            AppText(
              text: '${addr.phone ?? ''}',
              fontSize: 14.sp,
            ),
            5.verticalSpaceFromWidth,
            AppText(
              text: '${addr.zip ?? ''}',
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
