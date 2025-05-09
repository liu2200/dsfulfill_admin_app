import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseInput extends StatefulWidget {
  const BaseInput(
      {super.key,
      required this.controller,
      this.focusNode,
      this.contentPadding,
      this.fillColor,
      this.hintText,
      this.hintColor,
      this.hintFontSize,
      this.textColor,
      this.textFontSize,
      this.prefix,
      this.clearable = false,
      this.obscureText = false,
      this.isBorder = true,
      this.borderColor,
      this.maxLines = 1,
      this.minLines,
      this.enabled = true,
      this.keyboardType});
  final TextEditingController controller;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final String? hintText;
  final double? hintFontSize;
  final double? textFontSize;
  final Color? hintColor;
  final Color? textColor;
  final Widget? prefix;
  final bool clearable;
  final bool obscureText;
  final bool isBorder;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final TextInputType? keyboardType;
  final Color? borderColor;
  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  bool _showClearButton = false;
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.clearable) {
      widget.controller.addListener(onInput);
    }
  }

  onInput() {
    if (widget.controller.text.isEmpty) {
      setState(() => _showClearButton = false);
    } else {
      setState(() => _showClearButton = true);
    }
  }

  @override
  void dispose() {
    if (widget.clearable) {
      widget.controller.removeListener(onInput);
    }
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 在build中初始化或获取focusNode
    final focusNode = widget.focusNode ?? (_focusNode ??= FocusNode());

    return TextField(
      cursorColor: AppStyles.primary,
      controller: widget.controller,
      focusNode: focusNode,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      style: TextStyle(
        color: widget.enabled
            ? (widget.textColor ?? AppStyles.textGrey)
            : AppStyles.textGrey.withOpacity(0.6),
        fontSize: widget.textFontSize ?? 14.sp,
      ),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        isCollapsed: true,
        fillColor: widget.enabled
            ? widget.fillColor
            : (widget.fillColor ?? Colors.grey[100]),
        filled: widget.fillColor != null || !widget.enabled,
        border: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:
                    BorderSide(color: widget.borderColor ?? AppStyles.line),
              )
            : InputBorder.none,
        focusedBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:
                    BorderSide(color: widget.borderColor ?? AppStyles.line),
              )
            : InputBorder.none,
        enabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:
                    BorderSide(color: widget.borderColor ?? AppStyles.line),
              )
            : InputBorder.none,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(12.w),
        hintText: widget.hintText,
        prefix: widget.prefix,
        hintStyle: TextStyle(
          color: widget.hintColor ?? AppStyles.greyHint,
          fontSize: widget.hintFontSize ?? 14.sp,
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 20,
          minWidth: 20,
        ),
        suffixIcon: widget.clearable && _showClearButton
            ? GestureDetector(
                onTap: () {
                  widget.controller.clear();
                },
                child: Icon(
                  Icons.cancel,
                  color: AppStyles.grey9,
                  size: 16.sp,
                ),
              )
            : 0.horizontalSpace,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
