import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String? text;
  final String textAR;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final Alignment alignment;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final int? maxLines;
  final TextAlign textAlign;

  const CustomText({
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
    return Text(text!, style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight, decoration: decoration), softWrap: true ,overflow: overflow, maxLines: maxLines, textAlign: textAlign,);
  }
}