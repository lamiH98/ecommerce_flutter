import 'package:ecommerce/controllers/languageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextLang extends StatelessWidget {

  final String? text;
  final String? textAR;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final Alignment alignment;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final int? maxLines;
  final TextAlign textAlign;

  CustomTextLang({
    this.text = '',
    this.textAR = '',
    this.fontSize = 16.0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.alignment = Alignment.bottomRight,
    this.decoration = TextDecoration.none,
    this.overflow = TextOverflow.visible,
    this.maxLines,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLanguage>(
      init: AppLanguage(),
      builder: (controller) {
        return Text(controller.appLocale == 'ar' ? textAR ?? '' : text ?? '' , style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight, decoration: decoration), overflow: overflow, maxLines: maxLines, textAlign: controller.appLocale == 'ar' ? TextAlign.right : TextAlign.left);
      },
    );
  }
}