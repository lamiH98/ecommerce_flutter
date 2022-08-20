import 'package:ecommerce/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLanguage extends GetxController{

  var appLocale = 'ar';

  @override
  void onInit() async{
    super.onInit();

    LocalStorage localStorage = LocalStorage();
    appLocale = await localStorage.languageSelected == null ? "ar" : await localStorage.languageSelected;
    Get.updateLocale(Locale(appLocale));
    update();
  }

  void changeLanguage(String type) {
    LocalStorage localStorage = LocalStorage();
    if(appLocale == type)  {
      return;
    }
    else if(type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguage('ar');
    }
    else if(type == 'en') {
      appLocale = 'en';
      localStorage.saveLanguage('en');
    }
    update();
  }

}