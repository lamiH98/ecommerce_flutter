import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Color? color;
  final Widget? child;
  final Function? onPressed;
  final OutlinedBorder? shape;

  const CustomButton({
    this.color,
    this.child,
    this.onPressed,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      // child: CustomText(text: text, color: textColor),
      child: child,
      style: ElevatedButton.styleFrom(
        primary: color != null ? color : mainColor,
        shadowColor: Colors.transparent,
        shape: shape,
        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        // textStyle: TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold
        // ),
      ),
    );
  }
}