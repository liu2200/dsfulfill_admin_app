import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanInput extends StatefulWidget {
  const ScanInput({
    super.key,
    this.hintText,
    this.contentPadding,
    this.bgColor,
    this.borderRadius,
    this.suffix,
  });
  final String? hintText;
  final Color? bgColor;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final Widget? suffix;

  @override
  State<ScanInput> createState() => _ScanInputState();
}

class _ScanInputState extends State<ScanInput> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.r),
        color: widget.bgColor,
      ),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          8.horizontalSpace,
          Expanded(
            child: BaseInput(
              controller: _keywordController,
              hintText: widget.hintText,
              clearable: true,
              contentPadding: widget.contentPadding,
            ),
          ),
          10.horizontalSpace,
          widget.suffix ?? 0.horizontalSpace,
        ],
      ),
    );
  }
}
