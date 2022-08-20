import 'dart:io';

import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/controllers/languageController.dart';
import 'package:ecommerce/controllers/notification.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/address/address.dart';
import 'package:ecommerce/screens/delivery_status.dart';
import 'package:ecommerce/screens/edit_profile.dart';
import 'package:ecommerce/screens/order_history.dart';
import 'package:ecommerce/screens/q_a.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';

class Profile extends StatefulWidget{

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  
  final UserController userController = Get.find();
  final AddressController addressController = Get.put(AddressController());
  final FavoriteController favoriteController = Get.find();
  final NotificationController notificationController = Get.find();

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // googlePlayIdentifier: 'fr.skyost.example',
    // appStoreIdentifier: '1491556149',
  );
  
  @override
  Widget build(BuildContext context) {

  var size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 38.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: GetX<UserController>(
                builder: (val) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: val.userData.value.image == null ?
                        Image.asset('assets/images/people/people_1.jpg', height: 100.0)
                        : Image.asset('assets/images/people/people_1.jpg', height: 100.0)
                        // : cachedNetworkImage('$image_api/image/${val.userData.value.image}', context, 90,width:  90),
                      ),
                      InkWell(
                        onTap: () => print('$image_api/image/${val.userData.value.image}'),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: val.userData.value.name == null ? '' : val.userData.value.name, fontWeight: FontWeight.w500, fontSize: 16.0),
                              CustomText(text: val.userData.value.email == null ? '' : val.userData.value.email, fontSize: 16.0),
                              CustomButton(
                                child: CustomText(text: 'edit_profile'.tr, color: Colors.white),
                                onPressed: () => Get.to(EditProfile()),
                                color: mainColor.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 7),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 8.0, bottom: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(AllAddress());
                        addressController.fetchAddress();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'shipping_address'.tr),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: () => notificationController.fetchNotification(userController.userData.value.id),
                      // onTap: () => Get.isDarkMode ? Get.changeTheme(ThemeData.light()) : Get.changeTheme(ThemeData.dark()),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.payment, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'payment_methods'.tr),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: () {
                        userController.getUserOrders(userController.userData.value.id);
                        Get.to(OrderHistory());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.history, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'order_history'.tr),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: () {
                        userController.getUserDeliveryOrders(userController.userData.value.id);
                        Get.to(DeliveryStatus());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.switch_camera, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'delivery_status'.tr),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    GetBuilder<AppLanguage>(
                      init: AppLanguage(),
                      builder: (controller) {
                        return InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: 'select_language'.tr,
                              content: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      controller.changeLanguage('en');
                                      Get.updateLocale(Locale('en'));
                                    },
                                    child: CustomText(text: 'English'),
                                  ),
                                  // SizedBox(height: 12.0),
                                  TextButton(
                                    onPressed: () {
                                      controller.changeLanguage('ar');
                                      Get.updateLocale(Locale('ar'));
                                    },
                                    child: CustomText(text: 'العربية'),
                                  ),
                                ]
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.language, color: Colors.blue),
                                    SizedBox(width: 12.0),
                                    CustomText(text: 'language'.tr),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CustomText(text: controller.appLocale == 'ar' ? 'العربية' : 'English'),
                                ),
                              ]
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 7),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 8.0, bottom: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        favoriteController.fetchFavoriteItem();
                        Get.toNamed('/favorite');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'favorite'.tr),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment, color: Colors.blue),
                          SizedBox(width: 12.0),
                          CustomText(text: 'privacy_policy'.tr),
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: () => Get.to(QA()),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.history, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'f_q'.tr),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: () {
                        _rateMyApp.init().then((_) => {
                          _rateMyApp.showRateDialog(
                            context,
                            title: 'title_rate'.tr, // The dialog title.
                            message: 'message_rate'.tr, // The dialog message.
                            rateButton: 'rate'.tr, // The dialog "rate" button text.
                            noButton: 'no_thanks'.tr, // The dialog "no" button text.
                            laterButton: 'maybe_later'.tr, // The dialog "later" button text.
                            listener: (button) {
                              if(button == RateMyAppDialogButton.rate) {
                                print('Clicked on "Rate".');
                              } else if(button == RateMyAppDialogButton.later) {
                                print('Clicked on "Later".');
                              }
                              return true; // Return false if you want to cancel the click event.
                            },
                            ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
                            dialogStyle: const DialogStyle(
                              titleStyle: TextStyle(color: mainColor),
                              titleAlign: TextAlign.left,
                              messageAlign: TextAlign.left,
                              messagePadding: const EdgeInsets.only(bottom: 20.0)
                            ), // Custom dialog styles.
                            onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed)
                          ),
                          
                          // Or if you prefer to show a star rating bar (powered by `flutter_rating_bar`) :
                          // _rateMyApp.showStarRateDialog(
                          //   context,
                          //   title: 'title_rate'.tr,
                          //   message: 'message_rate'.tr,
                          //   dialogStyle: DialogStyle(
                          //     titleAlign: TextAlign.center,
                          //     messageAlign: TextAlign.center,
                          //     messagePadding: const EdgeInsets.only(bottom: 20.0)
                          //   ),
                          //   starRatingOptions: StarRatingOptions(),
                          //   ignoreNativeDialog: Platform.isAndroid,
                          //   onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
                          //   actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
                          //     return [ // Return a list of actions (that will be shown at the bottom of the dialog).
                          //       CustomButton(
                          //         child: Text('OK'),
                          //         onPressed: () async {
                          //           print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
                          //           // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                          //           // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                          //           await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                          //           Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                          //         },
                          //       ),
                          //     ];
                          //   },
                          // ),
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.language, color: Colors.blue),
                            SizedBox(width: 12.0),
                            CustomText(text: 'rate_our_app'.tr),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              userController.logout();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app),
                  CustomText(text: 'log_out'.tr, fontSize: 20.0, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}