import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';

class SelectDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final String Function(T) getId;
  final String Function(T) getName;
  final RxString? rxSelectedId;
  final String? selectedId;
  final Function(String id) onChanged;
  final bool showClear;

  const SelectDropdown({
    Key? key,
    required this.hint,
    required this.items,
    required this.getId,
    required this.getName,
    this.rxSelectedId,
    this.selectedId,
    required this.onChanged,
    this.showClear = true,
  })  : assert(rxSelectedId != null || selectedId != null,
            'Either rxSelectedId or selectedId must be provided'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxOrDefault(
      rxSelectedId,
      () => _buildDropdown(context, rxSelectedId?.value ?? selectedId ?? ''),
      () => _buildDropdown(context, selectedId ?? ''),
    );
  }

  Widget _buildDropdown(BuildContext context, String selectedValue) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: double.infinity,
          height: 48.h,
          padding: EdgeInsets.only(bottom: 12.h, top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue.isEmpty ? null : selectedValue,
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
                    if (rxSelectedId != null) rxSelectedId!.value = value;
                    onChanged(value);
                  }
                },
                items: items.map<DropdownMenuItem<String>>((item) {
                  final id = getId(item);
                  final name = getName(item);
                  return DropdownMenuItem<String>(
                    value: id,
                    child: Text(name),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return items.map((item) {
                    final name = getName(item);
                    return Text(name, style: TextStyle(fontSize: 14.sp));
                  }).toList();
                },
              ),
            ),
          ),
        ),
        if (showClear && selectedValue.isNotEmpty)
          Positioned(
            right: 8.w,
            child: GestureDetector(
              onTap: () {
                if (rxSelectedId != null) rxSelectedId!.value = '';
                onChanged('');
              },
              child: Icon(Icons.clear, size: 18.sp, color: Colors.grey),
            ),
          ),
      ],
    );
  }
}

/// Helper: ObxOrDefault
class ObxOrDefault extends StatelessWidget {
  final RxString? rxValue;
  final Widget Function() rxBuilder;
  final Widget Function() defaultBuilder;
  const ObxOrDefault(this.rxValue, this.rxBuilder, this.defaultBuilder,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (rxValue != null) {
      return Obx(rxBuilder);
    } else {
      return defaultBuilder();
    }
  }
}
