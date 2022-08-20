import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'package:ecommerce/screens/products.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Favorite extends StatefulWidget{

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  final FavoriteController val = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
            child: Center(child: Text('favorite'.tr, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))),
          ),
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3)
            ),
          ),
          SizedBox(height: 20.0,),
          Obx(() {
              return val.favoriteList.length == 0 ?
              Padding(
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
                        child: Image.asset('assets/images/star.png', height: 80.0),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: CustomText(text: 'no_item_found'.tr, fontSize: 19.0, fontWeight: FontWeight.bold,),
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
              ) : StaggeredGridView.countBuilder(
                itemCount: val.favoriteList.length,
                shrinkWrap: true,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  var product = val.favoriteList[index].products;
                  return InkWell(
                    onTap: () => Get.to(ProductDetails(id: val.favoriteList[index].productId)),
                    child: Card(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              // cachedNetworkImage('http://10.0.2.2:8000${product["image"]}', context, 165),
                              cachedNetworkImage('$image_api${product["image"]}', context, 165.0),
                              Positioned(
                                right: 6.0,
                                top: 6.0,
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(100.0)
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      val.deleteFavorite(val.favoriteList[index].id, val.favoriteList[index].productId);
                                    },
                                    icon: Icon(Icons.delete_outline, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 8.0),
                            child: ContainerLang(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustomTextLang(text: product["name"] ?? '', textAR: product["name_ar"] ?? '', fontSize: 16.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, maxLines: 2,)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 8.0),
                            child: product["price_offer"] == null || product["price_offer"] == 0 ?
                            Row(
                              children: [
                                CustomText(text: product["price"].toString(), fontSize: 16.0, fontWeight: FontWeight.bold, color: mainColor),
                              ],
                            )
                            : Row(
                              children: [
                                CustomText(text: product["price_offer"].toString(), fontSize: 16.0, fontWeight: FontWeight.bold, color: mainColor,),
                                SizedBox(width: 10.0),
                                CustomText(text: product["price"].toString(), fontSize: 14.0, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                          product["reviews"] == 0 || product["reviews"] == null ? CustomText(text: '') : Padding(
                            padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 6.0, bottom: 10.0),
                            child: Container(
                              width: 50.0,
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: 16.0),
                                  Text(product["reviews"].toStringAsFixed(1) ?? '', style: TextStyle(color: Colors.white, fontSize: 14.0)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
            }
          ),
        ],
      ),
    );
  }
  
}