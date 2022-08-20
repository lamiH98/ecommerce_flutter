import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/checkoutController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/screens/order_placed.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final CheckoutController checkoutController = Get.find();
final CartController cartController = Get.find();
final CouponController couponController = Get.find();
final ProductController productController = Get.find();

class CheckoutServices{

  static Future checkoutOrder(order) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.post(Uri.parse('$my_api/checkout'), body: jsonEncode(order), headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      checkoutController.isCheckoutLoading.value = true;
      // cartController.deleteAllItems();
      couponController.deleteCoupon();
      cartController.fetchCartItems();
      productController.fetchProduct();
      Get.off(OrderPlaced());
    } else if(response.statusCode == 404) {
      var responseBody = jsonDecode(response.body);
      showErrorSnackBar('error_add_order'.tr, responseBody['message']);
    } else {
      showErrorSnackBar('error_add_order'.tr, 'there_are_error_in_order'.tr);
    }
  }

}