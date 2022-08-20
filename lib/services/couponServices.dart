import 'dart:convert';
import 'package:ecommerce/api.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/coupon.dart';
import 'package:get/get.dart';

class CouponServices{

  static Future<List<Coupon>?> fetchCoupon() async{
    var response = await http.get(Uri.parse('$my_api/coupons'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return couponFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future getCoupon(code, total, userId) async{
    var response = await http.post(
      Uri.parse('$my_api/check-coupon'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'coupon_code': code,
        'total': total,
        'id': userId
      }),
    );
    if(response.statusCode == 200) {
      var couponBody = jsonDecode(response.body);
      var coupon = Coupon.fromJson(couponBody['coupons']);
      return coupon;
    } else {
      var couponBody = jsonDecode(response.body);
      showErrorSnackBar('coupon_error'.tr, couponBody['message']);
    }
  }

}