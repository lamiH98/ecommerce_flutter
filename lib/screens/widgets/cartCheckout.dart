import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCechout extends StatelessWidget {
  
  final CartController cartController = Get.find();
  final CouponController couponController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (cartController.isLoading.value)
      //   return Center(child: CircularProgressIndicator());
      // else
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cartController.cartItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            var cartItem = cartController.cartItemsList[index];
            var product = cartItem.product;
            return Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // cachedNetworkImage('http://ecommerce-lami.herokuapp.com${cartItem.image}', context, 130, width: 140),
                          cachedNetworkImage('$image_api${product['image']}', context, 120, width: 90),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: new Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomTextLang(text: product['name'], textAR: product['name_ar'], fontWeight: FontWeight.bold, fontSize: 16.0, maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                // Text(cartItem.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 6.0),
                                Row(
                                  children: [
                                    CustomText(text: "size".tr),
                                    SizedBox(width: 4.0),
                                    CustomTextLang(text: cartItem.size['size'], textAR: cartItem.size['size_ar'],),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                CustomText(text: product['price_offer'] == null ? (cartController.cartItemsList[index].quantity * double.parse(product['price'])).toString() : (cartController.cartItemsList[index].quantity * double.parse(product['price_offer'])).toString(), color: mainColor, fontSize: 18.0, fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              )
            );
          },
        );
    });
  }
}