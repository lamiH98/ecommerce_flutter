import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/brandController.dart';
import 'package:ecommerce/controllers/categoryController.dart';
import 'package:ecommerce/controllers/checkoutController.dart';
import 'package:ecommerce/controllers/colorController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/controllers/networkController.dart';
import 'package:ecommerce/controllers/notification.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/reviewController.dart';
import 'package:ecommerce/controllers/sizeController.dart';
import 'package:ecommerce/controllers/sliderController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings{
  
  @override
  void dependencies() {
    // Get.lazyPut<CheckoutController>(() => CheckoutController(), fenix: true);
    Get.lazyPut<NetworkController>(() => NetworkController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<CheckoutController>(() => CheckoutController());
    Get.lazyPut<SliderController>(() => SliderController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<CouponController>(() => CouponController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<BrandController>(() => BrandController());
    Get.lazyPut<SizeController>(() => SizeController());
    Get.lazyPut<ColorController>(() => ColorController());
    Get.lazyPut<ReviewController>(() => ReviewController());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}