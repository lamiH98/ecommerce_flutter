import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/order_items.dart';
import 'package:ecommerce/screens/products.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class OrderHistory extends StatelessWidget {

  final UserController userController = Get.find();
  final ProductController productController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back)
              ),
              CustomText(text: 'my_orders'.tr, fontWeight: FontWeight.bold,),
              CustomText(text: ''),
            ],
          ),
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 12.0, left: 12.0),
            child: Obx(() {
              if(userController.isUserOrdersLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return userController.userOrders.length > 0 ? ListView.builder(
                  shrinkWrap: true,
                  // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  physics: const BouncingScrollPhysics(),
                  itemCount: userController.userOrders.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int item) {
                    var userOrder = userController.userOrders[item];
                    var createdAt = DateTime.parse(userOrder.createdAt.toString()).toString();
                    var orderTime = createdAt.substring(0, 19);
                    return InkWell(
                      onTap: () {
                        // Get.to(Tracking(order: userOrder));
                        productController.getOrderProducts(userOrder.id);
                        Get.to(OrderItems(order: userOrder));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 45.0,
                                        height: 45.0,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: mainColor.withOpacity(0.18),
                                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                        ),
                                        child: userOrder.status == 'shipped' ? Image.asset('assets/images/icons/delivery.png', height: 40.0,)
                                        : userOrder.status == 'delivered' ? Icon(Icons.check) : Icon(Icons.cancel_outlined),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                                              child: CustomText(text: orderTime, fontSize: 14.0),
                                            ),
                                            SizedBox(width: 6.0),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 70.0,
                                                  child: Row(
                                                    children: [
                                                      CustomText(text: '${userOrder.products.length}', overflow: TextOverflow.ellipsis),
                                                      SizedBox(width: 2.0),
                                                      CustomText(text: 'items'.tr, overflow: TextOverflow.ellipsis),
                                                    ],
                                                  )
                                                ),
                                                SizedBox(width: 4.0),
                                                CustomText(text: '-'),
                                                SizedBox(width: 4.0),
                                                Container(
                                                  width: 70.0,
                                                  child: CustomText(text: '\$${userOrder.newTotal != 'no coupon' ? userOrder.newTotal : userOrder.total }', fontSize: 17.0, overflow: TextOverflow.ellipsis)
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: userOrder.status == 'shipped' ? Colors.blue.withOpacity(0.18) : userOrder.status == 'delivered' ? mainColor.withOpacity(0.12) : Colors.red.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(6.0)
                                    ),
                                    child: CustomText(text: userOrder.status == 'shipped' ? 'shipped'.tr : userOrder.status == 'delivered' ? 'delivered'.tr : 'cancel'.tr,
                                      color: userOrder.status == 'shipped' ? Colors.blue : userOrder.status == 'delivered' ? mainColor : Colors.red)
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3)
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ) : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Column(
                      children: [
                        Container(
                          height: 120.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(color: Color(0xFFDBDBDB),)
                          ),
                          child: CircleAvatar(
                            radius: 30.0,
                            child: Image.asset('assets/images/cancel.png', height: 80.0),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 22.0),
                          child: CustomText(text: 'no_order'.tr, fontSize: 19.0, fontWeight: FontWeight.bold,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: CustomButton(
                            onPressed: () => Get.to(Products()),
                            child: CustomText(text: 'continue_shopping'.tr, color: Colors.white),
                            
                          ),
                        ),
                      ],
                    ),
                  )
                );
            }),
          ),
        ],
      ),
    );
  }
}