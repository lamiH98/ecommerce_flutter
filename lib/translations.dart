import 'package:ecommerce/lang/ar.dart';
import 'package:ecommerce/lang/en.dart';
import 'package:get/get.dart';

class Translation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'ar': ar
  };

}