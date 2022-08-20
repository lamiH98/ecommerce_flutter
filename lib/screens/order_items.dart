import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/reviewController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class OrderItems extends StatefulWidget {

  final order;
  OrderItems({this.order});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {

  final ProductController productController = Get.find();
  final ReviewController reviewController = Get.find();
  final UserController userController = Get.find();

  var productRating = 5.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final order = widget.order;

    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back)
              ),
              CustomText(text: 'order_products'.tr, fontWeight: FontWeight.bold, fontSize: 20.0,),
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
            child: Row(
              children: [
                CustomText(text: 'total'.tr, fontSize: 19.0),
                SizedBox(width: 8.0,),
                CustomText(text: '\$${order.newTotal != 'no coupon' ? order.newTotal : order.total }', fontSize: 17.0, overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Obx(() {
              if(productController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return StaggeredGridView.countBuilder(
                itemCount: productController.orderProducts.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  var orderProduct =  productController.orderProducts[index];
                  var product = orderProduct.product;
                  // var product = productController.productList.where((product) => product.id == orderProduct.productId).first;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                    child: InkWell(
                      onTap: () => Get.to(ProductDetails(id:  product['id'])),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                cachedNetworkImage('$image_api${product['image']}', context, 165),
                                // cachedNetworkImage('https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg', context, 160, width:  MediaQuery.of(context).size.width / 2),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.7,
                                alignment: Alignment.bottomRight,
                                child: CustomTextLang(text: product['name'] ?? '', textAR: product['name_ar'] ?? '', fontSize: 16.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, maxLines: 2,)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  product['price_offer'] != null ? Row(
                                    children: [
                                      CustomText(text: product['price_offer'].toString(), fontSize: 18.0, fontWeight: FontWeight.bold, color: mainColor),
                                      SizedBox(width: 10.0),
                                      CustomText(text: product['price'].toString(), decoration: TextDecoration.lineThrough, fontSize: 14.0),
                                    ],
                                  ) : CustomText(text: product['price'].toString(), fontSize: 17.0, fontWeight: FontWeight.bold, color: mainColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 6.0),
                              child: Row(
                                children: [
                                  CustomText(text: 'color'.tr, fontSize: 16.0, fontWeight: FontWeight.bold),
                                  CustomText(text: orderProduct.color),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 6.0),
                              child: Row(
                                children: [
                                  CustomText(text: 'size'.tr, fontSize: 16.0, fontWeight: FontWeight.bold),
                                  CustomText(text: orderProduct.size),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => print(orderProduct.rating == 0 ? '0' : '1'),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 6.0),
                                child: Row(
                                  children: [
                                    CustomText(text: 'quantity'.tr, fontSize: 16.0, fontWeight: FontWeight.bold),
                                    CustomText(text: orderProduct.quantity.toString()),
                                  ],
                                ),
                              ),
                            ),
                            order.status == 'delivered' && orderProduct.rating == false ? CustomButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'rating_product'.tr,
                                  titleStyle: TextStyle(fontSize: 20.0),
                                  content: Column(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            productRating = rating;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0, right: 14.0, left: 14.0, bottom: 10.0),
                                        child: TextFormField(
                                          controller: _reviewController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(8.0),
                                            hintText: 'write_comment'.tr,
                                            hintStyle: TextStyle(color: Colors.blue),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid),
                                            ),
                                          ),
                                          maxLines: 3,
                                        ),
                                      ),
                                      CustomButton(
                                        onPressed: () {
                                          var review = {"product_id": orderProduct.productId, "user_id": userController.userData.value.id, "order_id": order.id,"rating": productRating, "comment": _reviewController.text};
                                          reviewController.addReview(review);
                                          Get.back();
                                          Get.back();
                                          setState(() {
                                            productRating = 5.0;
                                          });
                                          productController.fetchProduct();
                                        },
                                        child: CustomText(text: 'send'.tr, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: CustomText(text: 'rating_product'.tr, color: Colors.white),
                            ) : CustomText(text: ''),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
            }
              
            ),
          ),
        ],
      ),
    );
  }
}