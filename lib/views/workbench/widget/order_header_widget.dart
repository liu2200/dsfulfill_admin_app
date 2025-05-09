import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/models/order_model.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
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
          _buildAddress(order),
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
                    image: 'workbench/${order.shop.platform}',
                    width: 24.w,
                    height: 24.w,
                  ),
                  8.horizontalSpace,
                  AppText(
                    text: order.shop.shopName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
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
            AppText(
              text: addr.name,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppStyles.textBlack,
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
