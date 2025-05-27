import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:flutter/material.dart';

class BaseScafflod extends StatelessWidget {
  const BaseScafflod({
    super.key,
    this.title,
    this.hasBack = true,
    required this.body,
    this.leading,
    this.leadingWidth,
    this.padding,
    this.bottomNavigationBar,
    this.actions,
    this.backgroundColor,
  });
  final String? title;
  final Widget? leading;
  final bool hasBack;
  final Widget body;
  final double? leadingWidth;
  final EdgeInsets? padding;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: leadingWidth,
        elevation: 0,
        automaticallyImplyLeading: leading != null || hasBack,
        leading: leading ??
            (hasBack
                ? const BackButton(
                    color: AppStyles.textMain,
                  )
                : null),
        title: title != null
            ? AppText(
                text: title!,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            : null,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: actions,
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor ?? AppStyles.background,
      body: body,
    );
  }
}
