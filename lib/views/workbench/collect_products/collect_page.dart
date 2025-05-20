import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:dsfulfill_cient_app/views/workbench/collect_products/collect_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CollectPage extends GetView<CollectController> {
  const CollectPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '采集产品'.tr,
      hasBack: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品链接与语言选择在同一行
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabelText('产品链接'.tr),
                // 语言选择器
                _buildLanguageSelector(),
              ],
            ),
            SizedBox(height: 8.h),

            // 产品链接输入框(增加高度)
            BaseInput(
              controller: controller.productLinkController,
              hintText: '请输入'.tr,
              maxLines: 3,
              minLines: 3,
            ),
            SizedBox(height: 20.h),

            // 产品重量
            _buildLabelText('${'产品重量'.tr}(KG)'),
            SizedBox(height: 8.h),
            BaseInput(
              controller: controller.weightController,
              hintText: '请输入'.tr,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20.h),

            // 产品分类(多级选择)
            _buildLabelText('产品分类'.tr),
            SizedBox(height: 8.h),
            _buildDropdownField(
              hint: '请选择'.tr,
              onTap: () => _showCategorySelectionDialog(context),
              selectedValue: controller.selectedCategoryName,
            ),
            SizedBox(height: 20.h),

            // 供应商
            _buildLabelText('供应商'.tr),
            SizedBox(height: 8.h),
            Obx(
              () => _buildSelectDropdown(
                hint: '请选择'.tr,
                items:
                    controller.supplierList.map((e) => e.supplierName).toList(),
                selectedValue: controller.selectedSupplierName,
                onChanged: (value) {
                  final supplier = controller.findSupplierByName(value);
                  if (supplier != null) {
                    controller.selectSupplier(
                        supplier.id, supplier.supplierName);
                  }
                },
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              '利润'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppStyles.textBlack,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 8.h),
            BaseInput(
              controller: controller.profitController,
              hintText: '请输入'.tr,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 40.h),

            // 确定按钮(绿色)
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // 标签文本
  Widget _buildLabelText(String text) {
    return Row(
      children: [
        Text(
          text.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppStyles.textBlack,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '*',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.red,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // 语言选择器
  Widget _buildLanguageSelector() {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: Obx(() => DropdownButton<String>(
                isDense: true,
                value: controller.selectedLanguage.value,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 16.sp,
                  color: AppStyles.textGrey,
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppStyles.textBlack,
                ),
                onChanged: (value) {
                  if (value != null) {
                    controller.changeLanguage(value);
                  }
                },
                items:
                    controller.languages.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item['value'],
                    child: Text(item['label']!.tr),
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }

  // 下拉选择框
  Widget _buildDropdownField({
    required String hint,
    required Function() onTap,
    required RxString selectedValue,
  }) {
    return Obx(() => GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue.value.isEmpty ? hint : selectedValue.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: selectedValue.value.isEmpty
                        ? AppStyles.textGrey
                        : AppStyles.textBlack,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20.sp,
                    color: AppStyles.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // 下拉选择框（带下拉菜单）
  Widget _buildSelectDropdown({
    required String hint,
    required List<String> items,
    required Rx<String> selectedValue,
    required Function(String) onChanged,
  }) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: Obx(() => DropdownButton<String>(
                isExpanded: true,
                value: selectedValue.value.isEmpty ? null : selectedValue.value,
                hint: Text(
                  hint,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppStyles.textGrey,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppStyles.textBlack,
                ),
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }

  // 提交按钮
  Widget _buildSubmitButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: controller.isSubmitting.value
                ? null
                : () => controller.submitForm(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              disabledBackgroundColor: AppStyles.primary.withOpacity(0.5),
              elevation: 0,
            ),
            child: controller.isSubmitting.value
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                : Text(
                    '确定'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ));
  }

  // 显示产品分类多级选择对话框
  void _showCategorySelectionDialog(BuildContext context) {
    // 获取分类数据
    final RxInt selectedPrimaryIndex = (-1).obs;
    final RxString selectedSubCategory = ''.obs;
    final RxBool useSubCategory = false.obs; // 判断是否使用二级分类

    final double dialogWidth = MediaQuery.of(context).size.width * 0.9;
    final double dialogHeight = MediaQuery.of(context).size.height * 0.6;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Container(
          width: dialogWidth,
          constraints: BoxConstraints(
            maxHeight: dialogHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '选择产品分类'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.textBlack,
                  ),
                ),
              ),

              // 分类选择内容
              Expanded(
                child: Obx(() {
                  // 如果正在加载分类
                  if (controller.isLoadingCategories.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: 16.h),
                          Text(
                            '正在加载分类数据'.tr,
                            style: TextStyle(
                              color: AppStyles.textGrey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // 如果分类为空
                  if (controller.categoryList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 40.w,
                            color: AppStyles.greyHint,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            '暂无分类数据'.tr,
                            style: TextStyle(
                              color: AppStyles.textGrey,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: () {
                              controller.loadCategory();
                            },
                            child: Text('重新加载'.tr),
                          ),
                        ],
                      ),
                    );
                  }

                  // 显示分类数据
                  return Row(
                    children: [
                      // 左侧一级分类
                      Container(
                        width: dialogWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border(
                            right: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: controller.categoryList.length,
                          itemBuilder: (context, index) {
                            return Obx(() => GestureDetector(
                                  onTap: () {
                                    selectedPrimaryIndex.value = index;
                                    selectedSubCategory.value = '';
                                    useSubCategory.value = false; // 默认不使用二级分类
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 16.w),
                                    decoration: BoxDecoration(
                                      color: selectedPrimaryIndex.value == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      border: Border(
                                        left: BorderSide(
                                          color: selectedPrimaryIndex.value ==
                                                  index
                                              ? AppStyles.primary
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            controller.categoryList[index].name,
                                            style: TextStyle(
                                              color:
                                                  selectedPrimaryIndex.value ==
                                                          index
                                                      ? AppStyles.primary
                                                      : AppStyles.textBlack,
                                              fontWeight:
                                                  selectedPrimaryIndex.value ==
                                                          index
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        // 添加选中图标
                                        if (selectedPrimaryIndex.value ==
                                                index &&
                                            !useSubCategory.value)
                                          Icon(
                                            Icons.check,
                                            color: AppStyles.primary,
                                            size: 18.sp,
                                          ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                      // 右侧二级分类
                      Expanded(
                        child: Obx(() => selectedPrimaryIndex.value >= 0
                            ? Container(
                                color: Colors.white,
                                child: controller
                                        .categoryList[
                                            selectedPrimaryIndex.value]
                                        .categories
                                        .isEmpty
                                    ? Center(
                                        child: Text(
                                          '暂无二级分类'.tr,
                                          style: TextStyle(
                                            color: AppStyles.textGrey,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      )
                                    : ListView.separated(
                                        itemCount: controller
                                            .categoryList[
                                                selectedPrimaryIndex.value]
                                            .categories
                                            .length,
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          height: 1,
                                          color: Colors.grey.shade200,
                                        ),
                                        itemBuilder: (context, index) {
                                          final subCategory = controller
                                              .categoryList[
                                                  selectedPrimaryIndex.value]
                                              .categories[index];
                                          return GestureDetector(
                                            onTap: () {
                                              selectedSubCategory.value =
                                                  subCategory.name;
                                              useSubCategory.value =
                                                  true; // 选择了二级分类
                                            },
                                            child: Obx(() => Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                    horizontal: 24.w,
                                                  ),
                                                  color: selectedSubCategory
                                                              .value ==
                                                          subCategory.name
                                                      ? Colors.grey.shade50
                                                      : Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        subCategory.name,
                                                        style: TextStyle(
                                                          color: selectedSubCategory
                                                                      .value ==
                                                                  subCategory
                                                                      .name
                                                              ? AppStyles
                                                                  .primary
                                                              : AppStyles
                                                                  .textBlack,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                      if (selectedSubCategory
                                                              .value ==
                                                          subCategory.name)
                                                        Icon(
                                                          Icons.check,
                                                          color:
                                                              AppStyles.primary,
                                                          size: 18.sp,
                                                        ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                              )
                            : Container(
                                color: Colors.white,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    '请选择分类'.tr,
                                    style: TextStyle(
                                      color: AppStyles.textGrey,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              )),
                      ),
                    ],
                  );
                }),
              ),

              // 底部按钮
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: AppStyles.textGrey,
                      ),
                      child: Text('取消'.tr),
                    ),
                    Obx(() => ElevatedButton(
                          onPressed: selectedPrimaryIndex.value >= 0 &&
                                  !controller.isLoadingCategories.value &&
                                  controller.categoryList.isNotEmpty
                              ? () {
                                  final primary = controller
                                      .categoryList[selectedPrimaryIndex.value];

                                  // 如果选择了二级分类，则使用二级分类ID和完整显示名称
                                  if (useSubCategory.value &&
                                      selectedSubCategory.value.isNotEmpty) {
                                    try {
                                      final sub = primary.categories.firstWhere(
                                          (cat) =>
                                              cat.name ==
                                              selectedSubCategory.value);
                                      controller.selectCategory(sub.id,
                                          '${primary.name} > ${sub.name}');
                                    } catch (e) {
                                      // 如果找不到二级分类，则使用一级分类
                                      controller.selectCategory(
                                          primary.id, primary.name);
                                      print('未找到二级分类，使用一级分类: $e');
                                    }
                                  } else {
                                    // 否则使用一级分类ID和名称
                                    controller.selectCategory(
                                        primary.id, primary.name);
                                  }
                                  Navigator.pop(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyles.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                const Color(0xFF2E9750).withOpacity(0.5),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 8.h),
                          ),
                          child: Text('确定'.tr),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
