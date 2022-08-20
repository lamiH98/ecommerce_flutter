import 'package:ecommerce/models/coupon.dart';
import 'package:ecommerce/services/couponServices.dart';
import 'package:get/get.dart';

class CouponController extends GetxController{
  
  var isLoading = true.obs;
  var isCoupon = false.obs;
  // var newTotal = 0.0.obs;
  // var couponCode = ''.obs;
  // var couponValue = ''.obs;
  var couponList = [].obs;
  Rx<Coupon?> coupon = Coupon().obs;

  @override
  void onInit() {
    fetchCoupon();
    coupon.value = null;
    super.onInit();
  }
  
  void deleteCoupon() {
    coupon.value = null;
    isCoupon(false);
  }

  void fetchCoupon() async{
    try{
      isLoading(true);
      var coupons = await CouponServices.fetchCoupon();
      if(coupons != null) {
        couponList.value = coupons;
      }
    } finally{
      isLoading(false);
    }
  }

  void getCoupon(code, total, userId) async{
    try{
      isLoading(true);
      var coupons = await CouponServices.getCoupon(code, total, userId);
      if(coupons != null) {
        coupon.value = coupons;
      }
      // print(coupon.value.code);
    } finally{
      isLoading(false);
    }
  }

}