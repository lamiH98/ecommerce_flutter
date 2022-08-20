import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/screens/widgets/cartItems.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Cart extends StatefulWidget{

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  final CartController cartController = Get.find();
  final CouponController couponController = Get.put(CouponController());
  final UserController userController = Get.find();
  final AddressController addressController = Get.put(AddressController());

  GlobalKey<FormState> _couponForm = GlobalKey<FormState>();
  TextEditingController _couponController = TextEditingController();

  applyCoupon() {
    var formData = _couponForm.currentState!;
    if(formData.validate()) {
      formData.save();
      // couponController.getCoupon(_couponController.text, 250, userController.userData.value.id);
      couponController.getCoupon(_couponController.text, cartController.total.value, userController.userData.value.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cartController.cartItemsList.isEmpty)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty_cart.png'),
              SizedBox(height: 38.0),
              CustomText(text: 'empty_cart'.tr, fontSize: 28.0, color: mainColor, fontWeight: FontWeight.bold,),
            ],
          );
        else {
          return ModalProgressHUD(
            inAsyncCall: cartController.isCartLoading.value,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back)
                    ),
                    CustomText(text: 'cart'.tr, fontWeight: FontWeight.bold, fontSize: 18.0,),
                    CustomText(text: ''),
                  ],
                ),
                Container(
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3)
                  ),
                ),
          
                /** 
                 * Cart Items
                 * */
                CartItems(),
          
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0, bottom: 22.0),
                  child: Form(
                    key: _couponForm,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _couponController,
                            onEditingComplete: () => applyCoupon(),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'enter_code'.tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              suffix: InkWell(
                                onTap: () => applyCoupon(),
                                child: Icon(Icons.arrow_forward)
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide()
                              ),
                              labelText: 'promo_code'.tr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'subtotal'.tr),
                            GetX<CartController>(
                              builder: (val) {
                                // return CustomText(text: '\$ 250');
                                return CustomText(text: '\$ ${val.total.value.toString()}');
                              }
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'shipping'.tr),
                            Text('\$ 00.00'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'total'.tr, fontSize: 18.0,fontWeight: FontWeight.bold),
                            GetX<CartController>(
                              builder: (val) {
                                // return CustomText(text: '\$ 250', fontSize: 18.0, fontWeight: FontWeight.bold);
                                return CustomText(text: '\$${val.total.value.toString()}', fontSize: 18.0, fontWeight: FontWeight.bold);
                              }
                            ),
                          ],
                        ),
                        couponController.coupon.value != null ?  Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'coupon_code'.tr),
                              CustomText(text: couponController.coupon.value!.code == null ? '' : couponController.coupon.value!.code),
                            ],
                          ),
                        ) : SizedBox(),
                        couponController.coupon.value != null ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'coupon_value'.tr),
                              CustomText(text: couponController.coupon.value!.discount == null ? '' : couponController.coupon.value!.discount.toString()),
                            ],
                          ),
                        ) : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
                          child: Divider(),
                        ),
                        couponController.coupon.value != null ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'new_total'.tr, fontSize: 18.0, fontWeight: FontWeight.bold),
                              CustomText(text: '\$${couponController.coupon.value!.newTotal == null ? '' : couponController.coupon.value!.newTotal.toString()}', fontSize: 18.0, fontWeight: FontWeight.bold),
                            ],
                          ),
                        ) : SizedBox(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                  child: CustomButton(
                    onPressed: () {
                      Get.to(Checkout(coupon: couponController.coupon.value));
                      addressController.fetchAddress();
                    },
                    color: mainColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: 'checkout'.tr, color: Colors.white, fontSize: 18.0),
                        SizedBox(width: 6.0),
                        Icon(Icons.arrow_forward, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }), 
    );
  }
}