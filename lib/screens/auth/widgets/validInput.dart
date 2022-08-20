import 'package:get/get.dart';

String? validInput(String value , int max , int min , String  type, {passwordController}) {
  if (value.trim().isEmpty) {
    return type + "empty".tr;
  } else if(type == 'email' && !value.trim().contains('@')) {
    return 'email@'.tr;
  } else if(type == 'email' && !value.trim().contains('.com')) {
    return 'email_com'.tr;
  } else if(type == 'confirm password' && value != passwordController.text) {
    return "passwords_not_match".tr;
  } else if (value.trim().length < min) {
    return type + 'more'.tr + min.toString() + "characters".tr;
  } else if (value.trim().length > max) {
    return type + 'less'.tr + max.toString() + "characters".tr;
  }
  return null;
}