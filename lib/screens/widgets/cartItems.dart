import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/couponController.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartItems extends StatelessWidget {
  
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
            return InkWell(
              onTap: () => Get.to(ProductDetails(id: product['id'])),
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0),
                child: Slidable(
                  // key: Key("${title}"),
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: const [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: const [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: doNothing,
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.archive,
                        label: 'Archive',
                      ),
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Save',
                      ),
                    ],
                  ),
                  // secondaryActions: <Widget>[
                  //   IconSlideAction(
                  //     caption: 'delete'.tr,
                  //     color: Colors.red,
                  //     icon: Icons.delete_outline,
                  //     onTap: () {
                  //       cartController.deleteItemFromCart(cartItem.id);
                  //       cartController.fetchCartItems();
                  //       couponController.deleteCoupon();
                  //     },
                  //   ),
                  // ],
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
                              cachedNetworkImage('$image_api${product["image"]}', context, 120, width: 90),
                              // cachedNetworkImage('http://10.0.2.2:8000${product['image']}', context, 110, width: 90),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ContainerLang(
                                      // padding: const EdgeInsets.only(top: 16.0),
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: CustomTextLang(text: product['name'], textAR: product['name_ar'], fontWeight: FontWeight.bold, fontSize: 16.0, maxLines: 2, overflow: TextOverflow.ellipsis)
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
                          GetX<CartController>(
                            init: CartController(),
                            builder: (val) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        var quantity = {"quantity": cartItem.quantity + 1};
                                        if(product['quantity'] < cartItem.quantity + 1) {
                                          showErrorSnackBar('update_item_cart'.tr, 'currently_not_enough'.tr);
                                        } else {
                                          cartController.editItemFromCart(cartItem.id, quantity);
                                          couponController.deleteCoupon();
                                        }
                                      },
                                      icon: Icon(Icons.add, color: Colors.blueGrey),
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
                                        child: CustomText(text: val.cartItemsList[index].quantity.toString(), color: Colors.black.withOpacity(0.7)),
                                      )
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        var quantity = {"quantity": cartItem.quantity - 1};
                                        cartController.editItemFromCart(cartItem.id, quantity);
                                        couponController.deleteCoupon();
                                      },
                                      icon: Icon(Icons.remove, color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                  )
                ),
              ),
            );
          },
        );
    });
  }
}

void doNothing(BuildContext context) {}