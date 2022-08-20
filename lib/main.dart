import 'package:ecommerce/bindings.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/auth/forgot_password.dart';
import 'package:ecommerce/screens/onboarding.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/categories.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/screens/favorite.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/notifications.dart';
import 'package:ecommerce/screens/order_placed.dart';
import 'package:ecommerce/screens/order_tracking.dart';
import 'package:ecommerce/screens/products.dart';
import 'package:ecommerce/screens/profile.dart';
import 'package:ecommerce/screens/widgets/scrollBehavior.dart';
import 'package:ecommerce/translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// When the app is terminated (close) or in background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message: ${message.messageId}");
  print("Handling a background message Title: ${message.notification!.title}");
  print("Handling a background message Body: ${message.notification!.body}");
}
// int initScreen;
// String token;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();  // للتأكد أن التطبيق لم يفتح قبل عمل ال asycn and await
  await Firebase.initializeApp();
  await GetStorage.init();
  // When the app is terminated (close) or in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // App is Background and Terminated
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final UserController userController = Get.put(UserController());
  await userController.getUser();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lang = GetStorage().read('lang');
  int? initScreen = prefs.getInt('initScreen');
  String? token = prefs.getString('token');
  runApp(
    GetMaterialApp(
      title: 'app_title'.tr,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      home: initScreen != 0
        ? Onboarding() : token == null ? Login() : Home(),
      // home: Onboarding(),
      initialBinding: AppBinding(),
      translations: Translation(),
      locale: Locale(lang == null ? 'ar' : lang),     // تغير يدوي
      fallbackLocale: Locale(lang == null ? 'ar' : lang),
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/categories', page: () => Categories()),
        GetPage(name: '/favorite', page: () => Favorite()),
        GetPage(name: '/cart', page: () => Cart()),
        GetPage(name: '/Notifications', page: () => Notifications()),
        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/checkout', page: () => Checkout()),
        GetPage(name: '/placeOrder', page: () => OrderPlaced()),
        GetPage(name: '/tracking', page: () => Tracking()),
        GetPage(name: '/products', page: () => Products()),
        GetPage(name: '/forgotPassword', page: () => ForgotPassword()),
      ],
    ),
  );
}