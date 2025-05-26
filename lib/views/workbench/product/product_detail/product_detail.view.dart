import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/models/product_model.dart';
import 'package:dsfulfill_admin_app/utils/base_utils.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/workbench/product/product_detail/product_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 整体背景改为白色
      extendBodyBehindAppBar: true, // 内容延伸到AppBar下方
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // 禁用默认返回按钮
        leading: null,
        actions: null,
        toolbarHeight: 0, // 设置高度为0，完全隐藏AppBar
      ),
      // 固定底部按钮
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
                _showEditPriceDialog(context);
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
                text: '编辑报价'.tr,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppStyles.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            final detail = controller.productDetail.value;
            if (detail == null) {
              return const Center(child: CircularProgressIndicator());
            }

            // 假设 detail.mainImages 是图片数组
            final mainImages = detail.mainImages;

            return ListView(
              padding: EdgeInsets.zero, // 移除默认内边距
              children: [
                // 商品主图轮播
                Stack(
                  children: [
                    GestureDetector(
                      onPanDown: (_) => controller.stopAutoPlay(),
                      onPanEnd: (_) => controller.startAutoPlay(),
                      onPanCancel: () => controller.startAutoPlay(),
                      child: SizedBox(
                        height: 320.h,
                        child: PageView.builder(
                          itemCount: mainImages.length,
                          controller: controller.pageController,
                          onPageChanged: (index) =>
                              controller.currentPage.value = index,
                          itemBuilder: (context, index) {
                            return Image.network(
                              mainImages[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // 指示器
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      mainImages.length,
                      (index) => Obx(() => Container(
                            width: 8.w,
                            height: 8.w,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage.value == index
                                  ? AppStyles.primary
                                  : Colors.grey[300],
                            ),
                          )),
                    ),
                  ),
                ),

                // 缩略图列表
                Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mainImages.length,
                    itemBuilder: (context, index) {
                      return Obx(() => GestureDetector(
                            onTap: () =>
                                controller.pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              margin: EdgeInsets.only(right: 16.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.currentPage.value == index
                                      ? AppStyles.primary
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2.r),
                                child: Image.network(
                                  mainImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),

                // 商品标题和价格
                Container(
                  padding: EdgeInsets.all(16.w),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.goodsName,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDEF9D4),
                                borderRadius: BorderRadius.circular(9.r),
                              ),
                              child: Row(
                                children: [
                                  AppText(
                                    text: 'SPU: ${detail.spu}',
                                    color: AppStyles.primary,
                                    fontSize: 12.sp,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BaseUtils.copy(detail.spu);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Icon(
                                        Icons.copy,
                                        size: 16.w,
                                        color: AppStyles.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        _formatPriceRange(detail.skus),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppStyles.textBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 16.h,
                  color: const Color(0xFFF7F7F7),
                ), // 分隔

                // 规格卡片标题
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  color: Colors.white,
                  child: Text(
                    '产品规格'.tr,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                // 规格Tab和列表
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                  child: _buildSkuTable(detail),
                ),

                // 底部空间，避免被按钮挡住
                SizedBox(height: 70.h),
              ],
            );
          }),

          // 将返回和分享按钮放在最外层Stack，确保它们始终在最上层
          Positioned(
            top: 50.h,
            left: 16.w,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onTap: () {
                  Get.back();
                },
                child: Ink(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA8A7A6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: LoadAssetImage(
                    image: 'workbench/arrow_back_ios',
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              ),
            ),
          ),

          // Positioned(
          //   top: 50.h,
          //   right: 16.w,
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWell(
          //       customBorder: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(4),
          //       ),
          //       onTap: () {},
          //       child: Ink(
          //         width: 30,
          //         height: 30,
          //         decoration: BoxDecoration(
          //           color: const Color(0xFFA8A7A6),
          //           borderRadius: BorderRadius.circular(4),
          //         ),
          //         child: LoadAssetImage(
          //           image: 'workbench/share_outlined',
          //           width: 30.w,
          //           height: 30.h,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildStaticTab(String text, String iconPath, bool isActive) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16.w),
        ),
        iconPath.isNotEmpty
            ? LoadAssetImage(image: iconPath, width: 18.w, height: 18.w)
            : SizedBox(width: 0.w),
        Container(
          width: 4.w,
        ),
        Text(
          text,
          style: TextStyle(
            color: isActive ? AppStyles.primary : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildSkuTable(ProductModel detail) {
    // 假设 detail.options[0].specs 是规格列表
    final specs = detail.skus.isNotEmpty ? detail.skus : [];
    return Container(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部Tab - 静态设计
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                _buildStaticTab("说明".tr, '', false),
                _buildStaticTab("报价".tr, 'workbench/attach_money', true),
                _buildStaticTab("利润".tr, 'workbench/profit', false),
                _buildStaticTab(
                    "成本".tr, 'workbench/account_balance_wallet', false),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // 只显示说明标签的内容
          Column(
            children: List.generate(specs.length, (index) {
              final sku = specs[index];
              return Column(
                children: [
                  if (index > 0)
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 左侧图片
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: sku.images.isNotEmpty && sku.images[0] != null
                              ? Image.network(sku.images[0].toString(),
                                  width: 50.w, height: 50.w, fit: BoxFit.cover)
                              : Container(
                                  width: 50.w,
                                  height: 50.w,
                                  color: Colors.grey[200]),
                        ),
                        SizedBox(width: 12.w),
                        // 规格名和SKU
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${sku.specName}',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 4.h),
                              Text('sku: ${sku.skuId}',
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.black54)),
                            ],
                          ),
                        ),
                        // 价格区块
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                LoadAssetImage(
                                  image: 'workbench/attach_money',
                                  width: 15.w,
                                  height: 15.w,
                                ),
                                SizedBox(width: 4.w),
                                Text('USD ${sku.quotePrice}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyles.primary,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                LoadAssetImage(
                                  image: 'workbench/profit',
                                  width: 15.w,
                                  height: 15.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(' CNY ${sku.profit}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                LoadAssetImage(
                                  image: 'workbench/account_balance_wallet',
                                  width: 15.w,
                                  height: 15.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(' CNY ${sku.purchasePrice}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // 显示编辑报价弹窗
  void _showEditPriceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题栏
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFEEEEEE),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '批量编辑'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 24.sp),
                    ),
                  ],
                ),
              ),

              // 表单内容
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 报价输入框
                      _buildInputField(
                        label: '${'产品报价'.tr}(\$)',
                        hint: '请输入'.tr,
                        controller: controller.quotePriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.h),
                      // 利润输入框
                      _buildInputField(
                        label: '${'采购价'.tr}(¥)',
                        hint: '请输入'.tr,
                        controller: controller.purchasePriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.h),

                      // 成本输入框
                      _buildInputField(
                        label: '${'产品重量'.tr}(g)',
                        hint: '请输入'.tr,
                        controller: controller.weightController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.h),

                      // 尺寸输入区域
                      Text(
                        '${'产品尺寸'.tr}(cm)',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: BaseInput(
                              controller: controller.lengthController,
                              hintText: '长'.tr,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: BaseInput(
                              controller: controller.widthController,
                              hintText: '宽'.tr,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: BaseInput(
                              controller: controller.heightController,
                              hintText: '高'.tr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 底部按钮
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () async {
                      // 处理表单提交
                      var bool = await controller.updateProduct();
                      if (bool) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      '确定'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 构建输入字段
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        BaseInput(
          controller: controller,
          hintText: hint,
        ),
      ],
    );
  }

  // 获取并格式化价格范围
  String _formatPriceRange(List<dynamic> skus) {
    if (skus.isEmpty) return 'USD 0';

    // 初始化最大最小价格为第一个sku的价格
    double minPrice = double.tryParse(skus.first.quotePrice ?? '0') ?? 0;
    double maxPrice = minPrice;

    // 遍历所有sku找出最大和最小价格
    for (var sku in skus) {
      double price = double.tryParse(sku.quotePrice ?? '0') ?? 0;
      if (price < minPrice) {
        minPrice = price;
      }
      if (price > maxPrice) {
        maxPrice = price;
      }
    }

    // 判断是否只有一个价格或最大最小价格相同
    if (minPrice == maxPrice) {
      return 'USD ${minPrice.toStringAsFixed(2)}';
    } else {
      return 'USD ${minPrice.toStringAsFixed(2)}-USD ${maxPrice.toStringAsFixed(2)}';
    }
  }
}
