import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/models/order_model.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({Key? key, required this.order, this.onTap})
      : super(key: key);
  final OrderModel order;
  final void Function(dynamic item, int index)? onTap;
  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late PageController pageController;
  final currentPage = 0.obs;
  final currencyModel = Get.find<AppState>().currencyModel;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final lineItems = widget.order.lineItems ?? [];
    if (lineItems.isEmpty) return const SizedBox();
    return Column(
      children: [
        SizedBox(
          height: 450.w,
          child: PageView.builder(
            controller: pageController,
            itemCount: lineItems.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final item = lineItems[index];
              return Container(
                margin: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppStyles.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildProductCard(item, index),
                    _buildRelatedProducts(item, index),
                  ],
                ),
              );
            },
          ),
        ),
        12.verticalSpaceFromWidth,
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(lineItems.length, (index) {
                final isActive = currentPage.value == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 12 : 8,
                  height: isActive ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? const Color(0xFF2E9750)
                        : const Color(0xFFE5E5E5),
                    boxShadow: isActive
                        ? [
                            const BoxShadow(
                                color: Color(0x332E9750), blurRadius: 4)
                          ]
                        : [],
                  ),
                );
              }),
            )),
      ],
    );
  }

  Widget _buildProductCard(item, index) {
    final hasImage = item.imgs.isNotEmpty && item.imgs[0] != null;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppStyles.background,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: hasImage
                ? Image.network(
                    item.imgs[0],
                    width: 68.w,
                    height: 68.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        width: 68.w,
                        height: 68.w,
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  )
                : SizedBox(
                    width: 68.w,
                    height: 68.w,
                    child: const Icon(Icons.image_not_supported),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: item.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppStyles.textBlack,
                ),
                4.verticalSpaceFromWidth,
                AppText(
                  text: item.variantTitle ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13.sp,
                  color: const Color(0xFF888888),
                ),
                4.verticalSpaceFromWidth,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppText(
                        text: '${item.sku}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onTap?.call(item, index);
                      },
                      child: LoadAssetImage(
                        image: 'workbench/relevancy',
                        width: 18.w,
                        height: 18.w,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts(item, index) {
    final related = item.mapping?.goodsSku;

    if (related == null) return const SizedBox();
    final hasImage = related.images.isNotEmpty && related.images[0] != null;
    final profitN = related.profit ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 8.w, bottom: 4.w),
              child: AppText(
                text: '关联'.tr,
                fontSize: 14.sp,
                color: const Color(0xFF222222),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppStyles.background,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: hasImage
                    ? Image.network(
                        related.images[0],
                        width: 68.w,
                        height: 68.w,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(
                        width: 68.w,
                        height: 68.w,
                        child: const Icon(Icons.image_not_supported),
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: related.goods['goods_name'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppStyles.textBlack,
                    ),
                    4.verticalSpaceFromWidth,
                    AppText(
                      text: related.specName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13.sp,
                      color: const Color(0xFF888888),
                    ),
                    4.verticalSpaceFromWidth,
                    AppText(
                      text: related.skuId ?? '',
                      fontSize: 13.sp,
                      color: const Color(0xFF888888),
                    ),
                    4.verticalSpaceFromWidth,
                    Row(
                      children: [
                        LoadAssetImage(
                          image: 'workbench/attach_money',
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        AppText(
                          text:
                              '${currencyModel['code']} ${related.quotePrice}',
                          fontSize: 14.sp,
                          color: AppStyles.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    4.verticalSpaceFromWidth,
                    Row(
                      children: [
                        LoadAssetImage(
                          image: 'workbench/profit',
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        AppText(
                          text: '${currencyModel['code']} ${profitN}',
                          fontSize: 14.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    4.verticalSpaceFromWidth,
                    Row(
                      children: [
                        LoadAssetImage(
                          image: 'workbench/account_balance_wallet',
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(' CNY ${related.purchasePrice}',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        12.verticalSpaceFromWidth,
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              Row(
                children: [
                  AppText(
                    text: '数量'.tr,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.primary,
                  ),
                  AppText(
                    text: ': ×${item.quantity}',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.primary,
                  ),
                ],
              ),
              12.horizontalSpace,
              Row(
                children: [
                  AppText(
                    text: '报价'.tr,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.primary,
                  ),
                  AppText(
                    text: ': ${currencyModel['code']} ${related.quotePrice}',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.primary,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
