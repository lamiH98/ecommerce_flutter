import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/reviewController.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'package:ecommerce/screens/widgets/customBottomSheet.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products extends StatefulWidget {

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  final ProductController productController = Get.find();
  final CartController cartController = Get.find();
  final FavoriteController favoriteController = Get.find();
  final ReviewController reviewController = Get.find();

  Set<String> saveProduct = Set<String>();
  
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value)
        return Center(child: CircularProgressIndicator());
      else
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  productController.productList.length,
                  (index) {
                    var product = productController.productList[index];
                    var rating = product.reviews.length == 0 ? 0 : product.reviews.map((review) => review['rating']).reduce((a, b) => a + b) / product.reviews.length;
                    if (productController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          color: Colors.grey[100],
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: InkWell(
                            onTap: () => Get.to(() => ProductDetails(id: product.id)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width / 1.7,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: cachedNetworkImage('$image_api${product.image}', context, 85.0, width:  80.0),
                                      ),
                                    ),
                                    GetX<FavoriteController>(
                                      init: FavoriteController(),
                                      builder: (val) {
                                        return Positioned(
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {
                                              favoriteController.addFavorite(product.id);
                                              // val.fetchFavoriteItem();
                                            },
                                            icon: Icon(val.favorites.contains(product.id) ? Icons.favorite
                                              : Icons.favorite_border, color: Colors.red, size: 28.0),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      left: 12.0,
                                      top: 10.0,
                                      child: product.productNew == 1 ? Container(
                                        width: 40.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Center(child: CustomText(text:'new'.tr, color: Colors.white, fontSize: 12)),
                                      ) : Text(''),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 8.0),
                                  child: ContainerLang(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: CustomTextLang(text: product.name ?? '', textAR: product.nameAr, fontSize: 15.0, overflow: TextOverflow.ellipsis, maxLines: 2,)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
                                        Text(rating.toStringAsFixed(1) ?? '', style: TextStyle(color: Colors.white, fontSize: 14.0)),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.7,
                                    child: CustomButton(
                                      onPressed: () {
                                        productBottomSheet(product, context);
                                      },
                                      child: Text('add_to_cart'.tr, style: TextStyle(color: Colors.white)),
                                      color: mainColor,
                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  },
                ),
                SizedBox(width: 20.0),
              ],
            ),
        );
    });
  }
}