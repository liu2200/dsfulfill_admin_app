import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderInput extends StatefulWidget {
  const OrderInput({
    super.key,
    this.hintText,
    this.contentPadding,
    this.bgColor,
    this.borderRadius,
    this.suffix,
    this.controller,
    this.onSearch,
  });
  final String? hintText;
  final Color? bgColor;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final Widget? suffix;
  final TextEditingController? controller;
  final Function(String)? onSearch;

  @override
  State<OrderInput> createState() => _OrderInputState();
}

class _OrderInputState extends State<OrderInput> {
  // 添加 FocusNode
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose(); // 释放 FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击空白处时失去焦点
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 34.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.r),
          color: widget.bgColor ?? const Color(0xFFF7F7F7),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: EdgeInsets.all(5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            color: const Color(0xFFF7F7F7),
          ),
          child: Row(
            children: [
              Expanded(
                child: BaseInput(
                  controller: widget.controller ?? TextEditingController(),
                  focusNode: _focusNode, // 添加 focusNode
                  hintText: widget.hintText,
                  clearable: false,
                  obscureText: false,
                  isBorder: false,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(horizontal: 12.w),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.onSearch != null) {
                    widget.onSearch!(widget.controller?.text ?? '');
                  }
                },
                child: Container(
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppStyles.primary,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
