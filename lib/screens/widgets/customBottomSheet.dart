import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/customHexColor.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void productBottomSheet(product, context) {
  
  int selectedColor = 0;
  int selectedSize = 0;
  int quantity = 1;
  final CartController cartController = Get.find();
  final UserController userController = Get.find();
  final CouponController couponController = Get.put(CouponController());

  void addToCart(product){
    var cartItem = {"product_id": product.id, "user_id": userController.userData.value.id, "size_id": product.sizes[selectedSize]['id'], "color_id": product.colors[selectedColor]['id'], "quantity": quantity};
    cartController.addItemToCart(cartItem);
    cartController.fetchCartItems();
    couponController.deleteCoupon();
  }

  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0)
      ),
    ),
    useRootNavigator: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      var rating = product.reviews.length == 0 ? 0 : product.reviews.map((review) => review['rating']).reduce((a, b) => a + b) / product.reviews.length;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.4,
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 12.0, right: 12.0, bottom: 8.0, left: 16.0),
              child: ListView(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        // print(isScrollControlled);
                        setState(() {
                          // isScrollControlled = true;
                        });
                      },
                      child: Container(
                        width: 50.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: cachedNetworkImage('$image_api${product.image}', context, 120.0, width: 120.0),
                            // child: cachedNetworkImage('http://10.0.2.2:8000${product.image}', context, 120.0, width: 120.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0, top: 8.0),
                                child: ContainerLang(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: CustomTextLang(text: product.name ?? '', textAR: product.nameAr, fontSize: 16.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, maxLines: 3,)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0, top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    product.priceOffer != null ? Row(
                                      children: [
                                        CustomText(text: product.priceOffer.toString(), fontSize: 18.0, fontWeight: FontWeight.bold, color: mainColor),
                                        SizedBox(width: 10.0),
                                        CustomText(text: product.price.toString(), decoration: TextDecoration.lineThrough, fontSize: 14.0),
                                      ],
                                    ) : CustomText(text: product.price.toString(), fontSize: 17.0, fontWeight: FontWeight.bold, color: mainColor),
                                  ],
                                ),
                              ),
                              rating == 0 ? SizedBox() : Padding(
                                padding: const EdgeInsets.only(right: 12.0, top: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.white, size: 16.0),
                                      CustomText(text: rating.toStringAsFixed(1) ?? '', color: Colors.white, fontSize: 14.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Divider(thickness: 1.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
                    child: ContainerLang(
                      child: CustomText(text: 'select_color'.tr, color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0)
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: ListView.builder(
                      itemCount: product.colors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: mainColor),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: HexColor(product.colors[index]['color']),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: selectedColor == index ? Center(
                                    child: Icon(Icons.check, color: Colors.white),
                                  ) : CustomText(text: ''),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                    child: ContainerLang(
                      child: CustomText(text: 'select_size'.tr, color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0)
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: ListView.builder(
                      itemCount: product.sizes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedSize = index;
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: selectedSize == index ? Colors.blue : Colors.grey,
                                // borderRadius: BorderRadius.circular(50),
                                shape: BoxShape.circle,
                              ),
                              child: Center(child: CustomTextLang(text: product.sizes[index]['size'], textAR: product.sizes[index]['size_ar'], color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Divider(thickness: 1.0),
                  ),
                  product.quantity == 0 ? CustomText(text: '') : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
                    child: ContainerLang(
                      child: CustomText(text: 'quantity'.tr, color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0)
                    ),
                  ),
                  product.quantity == 0 ? CustomText(text: '') : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      product.quantity <= 10 && product.quantity != 0 ? CustomText(text: 'only'.tr + '${product.quantity}' + 'items_left'.tr) : SizedBox(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: quantity == 1 ? null : ()  {
                              setState(() {
                                quantity--;
                              });
                            },
                            icon: Icon(Icons.remove),
                            color: Colors.grey,
                          ),
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: CustomText(text: quantity.toString(), color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          IconButton(
                            onPressed: product.quantity == quantity ? null : () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  product.quantity < 1
                  ? Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Center(child: CustomText(text: 'currently_unavailable'.tr, color: Colors.red, fontSize: 18.0)),
                  )
                  : Container(
                    width: 160.0,
                    height: 40.0,
                    child: CustomButton(
                      onPressed: cartController.isCartLoading.value ? null : () => addToCart(product),
                      child: cartController.isCartLoading.value ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: 'continue'.tr, color: mainColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                          SizedBox(width: 18.0,),
                          Container(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(strokeWidth: 3.0)
                          ),
                        ],
                      ) : CustomText(text: 'continue'.tr, color: Colors.white, fontSize: 17.0),
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  ).whenComplete(() {
    print('Hey there, I\'m calling after hide bottomSheet');
  });
}