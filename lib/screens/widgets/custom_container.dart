import 'package:ecommerce/controllers/languageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerLang extends StatelessWidget {

  final double? width;
  final double? height;
  final Widget? child;

  ContainerLang({
    this.width,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLanguage>(
      init: AppLanguage(),
      builder: (controller) {
        return Container(
          alignment: controller.appLocale == 'ar' ? Alignment.bottomRight : Alignment.bottomLeft,
          width: width,
          height: height,
          child: child,
        );
      },
    );
  }
}