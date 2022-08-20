import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/checkoutController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/models/coupon.dart';
import 'package:ecommerce/screens/address/add_address.dart';
import 'package:ecommerce/screens/widgets/cartCheckout.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkout extends StatefulWidget{

  final Coupon? coupon;
  Checkout({this.coupon});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final CouponController couponController = Get.find();
  final UserController userController = Get.find();

  get couponCode => widget.coupon == null ? 'no coupon' : widget.coupon!.code;
  get couponValue => widget.coupon == null ? 'no coupon': widget.coupon!.discount;
  get couponNewTotal => widget.coupon == null ? cartController.total.toString() : widget.coupon!.newTotal.toString();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back)
                ),
                CustomText(text: 'checkout'.tr, fontWeight: FontWeight.bold, fontSize: 22.0,),
                CustomText(text: ''),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            child: Container(
              alignment: Alignment.topRight,
              child: CustomText(text: 'shipping_address'.tr, fontSize: 19.0, fontWeight: FontWeight.w500)
            ),
          ),
          Obx(() {
            var address = addressController.addressList.where((address) => address.check == 1).toList();
            return addressController.addressList.length > 0 ? Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(text: 'street'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                        SizedBox(width: 6.0),
                        CustomText(text: address.isEmpty ? addressController.addressList[addressController.addressList.length - 1].street : address[0].street),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      children: [
                        CustomText(text: 'neighourhood'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                        SizedBox(width: 6.0),
                        CustomText(text: address.isEmpty ? addressController.addressList[addressController.addressList.length - 1].neighourhood : address[0].neighourhood),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      children: [
                        CustomText(text: 'city'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                        SizedBox(width: 6.0),
                        CustomText(text: address.isEmpty ? addressController.addressList[addressController.addressList.length - 1].city : address[0].city),
                      ],
                    ),
                  ],
                ),
              ),
            ) : Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.to(AddAddress()),
                    child: Container(
                      width: 180.0,
                      height: 38.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: mainColor,
                      ),
                      child: Center(child: CustomText(text: 'please_add_address'.tr, color: Colors.white))
                    ),
                  ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 14.0, top: 16.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: CustomText(text: 'payment_method'.tr, fontSize: 19.0, fontWeight: FontWeight.w500)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => print(couponCode),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: 'Christine Ortiz', fontSize: 17.0, fontWeight: FontWeight.w600),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFdadde0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 28.0),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Row(
              children: [
                CustomText(text: 'items'.tr, fontSize: 20.0, fontWeight: FontWeight.w500),
                SizedBox(width: 8.0),
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: CustomText(text: cartController.cartItemsList.length.toString(), color: mainColor, fontSize: 17.0)
                  ),
                ),
              ],
            ),
          ),
          CartItemCechout(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18.0, bottom: 12.0, top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomText(text: 'total'.tr,color: Colors.grey, fontSize: 14.0),
                SizedBox(width: 8.0),
                CustomText(text: '\$ $couponNewTotal', fontWeight: FontWeight.bold, fontSize: 23.0),
              ],
            ),
            Obx(() {
              if(checkoutController.isCheckoutLoading.value) {
                return Container(
                  color: mainColor,
                  width: 140.0,
                  height: 40.0,
                  child: Center(
                    child: SizedBox(
                      width: 25.0,
                      height: 25.0,
                      child: CircularProgressIndicator(),
                    ),
                  )
                );
              } else{
                return Container(
                  width: 140.0,
                  height: 40.0,
                  // ElevatedButton
                  child: ElevatedButton(
                    onPressed: () {
                      var address = addressController.addressList.where((address) => address.check == 1).toList();
                      if(addressController.addressList.isEmpty) {
                        showErrorSnackBar('Address', 'please_add_address'.tr);
                      } else {
                        var order = {
                        "user_id": userController.userData.value.id,
                        "name": userController.userData.value.name,
                        "email": userController.userData.value.email,
                        "street": address.isEmpty ? addressController.addressList[addressController.addressList.length - 1].street : address[0].street,
                        "neighourhood": address.isEmpty ? addressController.addressList[addressController.addressList.length - 1].neighourhood : address[0].neighourhood,
                        "city": address.isEmpty ? addressController.addressList[addressController.addressList.length - 1].city : address[0].city,
                        "phone": "12456",
                        "status": "shipped",
                        "delivery_status": 0,
                        "discount": couponValue,
                        "code": couponCode,
                        "newTotal": couponNewTotal,
                        "total": cartController.total.toString(),
                      };
                      checkoutController.checkoutOrder(order);
                      }
                    },
                    child: CustomText(text: 'place_order'.tr, color: Colors.white, fontSize: 17.0),
                    style: ElevatedButton.styleFrom(
                      primary: checkoutController.isCheckoutLoading != null ? mainColor : Colors.white,
                    ),
                  ),
                );
              }
            }),
          ]
        ),
      ),
    );
  }
  
}