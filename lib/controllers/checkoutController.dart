import 'package:ecommerce/services/CheckoutServices.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController{
  
  var isLoading = true.obs;
  var isCheckoutLoading = false.obs;

  void checkoutOrder(order) async{
    try{
      isLoading(true);
      await CheckoutServices.checkoutOrder(order);
    } finally{
      isCheckoutLoading(false);
      isLoading(false);
    }
  }

}