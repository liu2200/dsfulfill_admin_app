import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/font_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 英文环境下的字体选项
enum EnglishFontFamily {
  montserrat, // Montserrat 常规
  montserratBlack, // Montserrat-Black
  montserratBlackItalic, // Montserrat-BlackItalic
  montserratBold, // Montserrat-Bold
  montserratBoldItalic, // Montserrat-BoldItalic
  montserratExtraBold, // Montserrat-ExtraBold
  montserratExtraBoldItalic, // Montserrat-ExtraBoldItalic
  montserratExtraLight, // Montserrat-ExtraLight
  montserratExtraLightItalic, // Montserrat-ExtraLightItalic
  montserratItalic, // Montserrat-Italic
  montserratLight, // Montserrat-Light
  montserratLightItalic, // Montserrat-LightItalic
  montserratMedium, // Montserrat-Medium
  montserratMediumItalic, // Montserrat-MediumItalic
  montserratRegular, // Montserrat-Regular
  montserratSemiBold, // Montserrat-SemiBold
  montserratSemiBoldItalic, // Montserrat-SemiBoldItalic
  montserratThin, // Montserrat-Thin
  montserratThinItalic, // Montserrat-ThinItalic
  roboto, // Roboto
  openSans, // Open Sans
  lato // Lato
}

class AppText extends StatefulWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = AppStyles.textMain,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textAlign,
    this.lines,
    this.maxLines,
    this.overflow,
    this.fontFamily,
    this.englishFont = EnglishFontFamily.montserrat,
    this.showLoadingEffect = false,
  });
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextAlign? textAlign;
  final int? lines;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? fontFamily;
  final EnglishFontFamily englishFont;
  final bool showLoadingEffect;

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> with SingleTickerProviderStateMixin {
  String? _fontFamily;
  bool _loading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _loadCustomFont();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果字体选项改变，重新加载字体
    if (oldWidget.englishFont != widget.englishFont ||
        oldWidget.fontWeight != widget.fontWeight ||
        oldWidget.fontStyle != widget.fontStyle) {
      _loadCustomFont();
    }
  }

  // 加载远程字体
  Future<void> _loadCustomFont() async {
    // 获取当前语言环境
    final isEnglish = Get.locale?.languageCode == 'en';

    // 如果不是英文环境或者提供了自定义字体，则不需要加载远程字体
    if (!isEnglish || widget.fontFamily != null) {
      return;
    }

    // 防止重复加载
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    try {
      // 根据字体选项和字重选择合适的字体URL
      String fontUrl =
          _getFontUrl(widget.englishFont, widget.fontWeight, widget.fontStyle);

      // 加载远程字体
      final fontFamily = await CachedNetworkFontLoader().loadFont(fontUrl);

      // 更新状态
      if (mounted) {
        setState(() {
          _fontFamily = fontFamily;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      print('Font loading error: $e');
    }
  }

  // 根据字体选项和字重获取字体URL
  String _getFontUrl(
      EnglishFontFamily fontFamily, FontWeight weight, FontStyle style) {
    const baseUrl = 'https://daigou-static.haiousaas.com/fonts/';
    String fontName;

    // 如果是指定的特定字体变体，直接返回对应文件
    switch (fontFamily) {
      case EnglishFontFamily.montserratBlack:
        fontName = 'Montserrat-Black.ttf';
        break;
      case EnglishFontFamily.montserratBlackItalic:
        fontName = 'Montserrat-BlackItalic.ttf';
        break;
      case EnglishFontFamily.montserratBold:
        fontName = 'Montserrat-Bold.ttf';
        break;
      case EnglishFontFamily.montserratBoldItalic:
        fontName = 'Montserrat-BoldItalic.ttf';
        break;
      case EnglishFontFamily.montserratExtraBold:
        fontName = 'Montserrat-ExtraBold.ttf';
        break;
      case EnglishFontFamily.montserratExtraBoldItalic:
        fontName = 'Montserrat-ExtraBoldItalic.ttf';
        break;
      case EnglishFontFamily.montserratExtraLight:
        fontName = 'Montserrat-ExtraLight.ttf';
        break;
      case EnglishFontFamily.montserratExtraLightItalic:
        fontName = 'Montserrat-ExtraLightItalic.ttf';
        break;
      case EnglishFontFamily.montserratItalic:
        fontName = 'Montserrat-Italic.ttf';
        break;
      case EnglishFontFamily.montserratLight:
        fontName = 'Montserrat-Light.ttf';
        break;
      case EnglishFontFamily.montserratLightItalic:
        fontName = 'Montserrat-LightItalic.ttf';
        break;
      case EnglishFontFamily.montserratMedium:
        fontName = 'Montserrat-Medium.ttf';
        break;
      case EnglishFontFamily.montserratMediumItalic:
        fontName = 'Montserrat-MediumItalic.ttf';
        break;
      case EnglishFontFamily.montserratRegular:
        fontName = 'Montserrat-Regular.ttf';
        break;
      case EnglishFontFamily.montserratSemiBold:
        fontName = 'Montserrat-SemiBold.ttf';
        break;
      case EnglishFontFamily.montserratSemiBoldItalic:
        fontName = 'Montserrat-SemiBoldItalic.ttf';
        break;
      case EnglishFontFamily.montserratThin:
        fontName = 'Montserrat-Thin.ttf';
        break;
      case EnglishFontFamily.montserratThinItalic:
        fontName = 'Montserrat-ThinItalic.ttf';
        break;
      case EnglishFontFamily.montserrat:
        // 如果是通用Montserrat字体，则根据weight和style选择具体变体
        if (style == FontStyle.italic) {
          // 斜体字体
          if (weight == FontWeight.w900) {
            fontName = 'Montserrat-BlackItalic.ttf';
          } else if (weight == FontWeight.w800) {
            fontName = 'Montserrat-ExtraBoldItalic.ttf';
          } else if (weight == FontWeight.w700 || weight == FontWeight.bold) {
            fontName = 'Montserrat-BoldItalic.ttf';
          } else if (weight == FontWeight.w600) {
            fontName = 'Montserrat-SemiBoldItalic.ttf';
          } else if (weight == FontWeight.w500) {
            fontName = 'Montserrat-MediumItalic.ttf';
          } else if (weight == FontWeight.w400 || weight == FontWeight.normal) {
            fontName = 'Montserrat-Italic.ttf';
          } else if (weight == FontWeight.w300) {
            fontName = 'Montserrat-LightItalic.ttf';
          } else if (weight == FontWeight.w200) {
            fontName = 'Montserrat-ExtraLightItalic.ttf';
          } else if (weight == FontWeight.w100) {
            fontName = 'Montserrat-ThinItalic.ttf';
          } else {
            fontName = 'Montserrat-Italic.ttf';
          }
        } else {
          // 常规字体
          if (weight == FontWeight.w900) {
            fontName = 'Montserrat-Black.ttf';
          } else if (weight == FontWeight.w800) {
            fontName = 'Montserrat-ExtraBold.ttf';
          } else if (weight == FontWeight.w700 || weight == FontWeight.bold) {
            fontName = 'Montserrat-Bold.ttf';
          } else if (weight == FontWeight.w600) {
            fontName = 'Montserrat-SemiBold.ttf';
          } else if (weight == FontWeight.w500) {
            fontName = 'Montserrat-Medium.ttf';
          } else if (weight == FontWeight.w400 || weight == FontWeight.normal) {
            fontName = 'Montserrat-Regular.ttf';
          } else if (weight == FontWeight.w300) {
            fontName = 'Montserrat-Light.ttf';
          } else if (weight == FontWeight.w200) {
            fontName = 'Montserrat-ExtraLight.ttf';
          } else if (weight == FontWeight.w100) {
            fontName = 'Montserrat-Thin.ttf';
          } else {
            fontName = 'Montserrat-Regular.ttf';
          }
        }
        break;
      case EnglishFontFamily.roboto:
        if (style == FontStyle.italic) {
          if (weight == FontWeight.bold ||
              weight == FontWeight.w700 ||
              weight == FontWeight.w800) {
            fontName = 'Roboto-BoldItalic.ttf';
          } else if (weight == FontWeight.w500 || weight == FontWeight.w600) {
            fontName = 'Roboto-MediumItalic.ttf';
          } else {
            fontName = 'Roboto-Italic.ttf';
          }
        } else {
          if (weight == FontWeight.bold ||
              weight == FontWeight.w700 ||
              weight == FontWeight.w800) {
            fontName = 'Roboto-Bold.ttf';
          } else if (weight == FontWeight.w500 || weight == FontWeight.w600) {
            fontName = 'Roboto-Medium.ttf';
          } else {
            fontName = 'Roboto-Regular.ttf';
          }
        }
        break;
      case EnglishFontFamily.openSans:
        if (style == FontStyle.italic) {
          if (weight == FontWeight.bold ||
              weight == FontWeight.w700 ||
              weight == FontWeight.w800) {
            fontName = 'OpenSans-BoldItalic.ttf';
          } else if (weight == FontWeight.w500 || weight == FontWeight.w600) {
            fontName = 'OpenSans-MediumItalic.ttf';
          } else {
            fontName = 'OpenSans-Italic.ttf';
          }
        } else {
          if (weight == FontWeight.bold ||
              weight == FontWeight.w700 ||
              weight == FontWeight.w800) {
            fontName = 'OpenSans-Bold.ttf';
          } else if (weight == FontWeight.w500 || weight == FontWeight.w600) {
            fontName = 'OpenSans-Medium.ttf';
          } else {
            fontName = 'OpenSans-Regular.ttf';
          }
        }
        break;
      case EnglishFontFamily.lato:
        if (style == FontStyle.italic) {
          if (weight == FontWeight.bold ||
              weight == FontWeight.w700 ||
              weight == FontWeight.w800) {
            fontName = 'Lato-BoldItalic.ttf';
          } else if (weight == FontWeight.w500 || weight == FontWeight.w600) {
            fontName = 'Lato-MediumItalic.ttf';
          } else {
            fontName = 'Lato-Italic.ttf';
          }
        } else {
          if (weight == FontWeight.bold ||
              weight == FontWeight.w700 ||
              weight == FontWeight.w800) {
            fontName = 'Lato-Bold.ttf';
          } else if (weight == FontWeight.w500 || weight == FontWeight.w600) {
            fontName = 'Lato-Medium.ttf';
          } else {
            fontName = 'Lato-Regular.ttf';
          }
        }
        break;
    }

    return baseUrl + fontName;
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前语言环境
    final isEnglish = Get.locale?.languageCode == 'en';

    // 确定要使用的字体
    final fontFamilyToUse =
        widget.fontFamily ?? (isEnglish ? _fontFamily : null);

    // 构建文本样式
    final textStyle = TextStyle(
      fontSize: widget.fontSize.sp,
      color: widget.color,
      fontWeight: widget.fontWeight,
      fontStyle: widget.fontStyle,
      fontFamily: fontFamilyToUse,
      height: isEnglish ? 1.2 : null,
      letterSpacing: isEnglish ? 0.2 : null,
    );

    // 构建文本组件
    final textWidget = Text(
      widget.text,
      style: textStyle,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
    );

    // 如果正在加载字体并且设置了显示加载效果，显示淡入淡出效果
    if (_loading && widget.showLoadingEffect) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: 0.3 + 0.7 * _animationController.value,
            child: textWidget,
          );
        },
      );
    }

    return textWidget;
  }
}
