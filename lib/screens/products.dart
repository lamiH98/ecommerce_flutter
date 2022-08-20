import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/screens/home_widgets/filter.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'package:ecommerce/screens/widgets/customBottomSheet.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:ecommerce/screens/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Products extends StatefulWidget {

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  
  final ProductController productController = Get.find();
  final CartController cartController = Get.find();
  final FavoriteController favoriteController = Get.find();

  var gridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 6.0, right: 6.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back, color: Color(0xFF98a4b1))
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showSearch(context: context, delegate: ProductSearch());
                        },
                        icon: Icon(Icons.search, color: Color(0xFF98a4b1))
                      ),
                      IconButton(
                        onPressed: () {
                          cartController.fetchCartItems();
                          Get.toNamed('/cart');
                        },
                        icon: Icon(Icons.shopping_bag_outlined, color: mainColor, size: 28.0),
                      ),
                    ]
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0, top: 18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xADF0F0F0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => filter(context),
                            child: Row(
                              children: [
                                Icon(Icons.filter_alt_outlined, color: Color(0xFF98a4b1)),
                                SizedBox(width: 4.0),
                                CustomText(text: 'filter'.tr),
                              ],
                            ),
                          ),
                          SizedBox(width: 18.0),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'sort_products'.tr,
                                titleStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                titlePadding: const EdgeInsets.only(top: 22.0),
                                content: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        productController.productList.sort((a, b) {
                                          return b.price.compareTo(a.price);
                                        });
                                        Get.back();
                                      },
                                      child: CustomText(text: 'price_more_less'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        productController.productList.sort((a, b) {
                                          return a.price.compareTo(b.price);
                                        });
                                        Get.back();
                                      },
                                      child: CustomText(text: 'price_less_more'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        productController.productList.sort((a, b) {
                                          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                                        });
                                        Get.back();
                                      },
                                      child: CustomText(text: 'name_a_z'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        productController.productList.sort((a, b) {
                                          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
                                        });
                                        Get.back();
                                      },
                                      child: CustomText(text: 'name_z_a'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        productController.productList.sort((a, b) {
                                          return b.createdAt.compareTo(a.createdAt);
                                        });
                                        Get.back();
                                      },
                                      child: CustomText(text: 'created_latest_oldest'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        productController.productList.sort((a, b) {
                                          return a.createdAt.compareTo(b.createdAt);
                                        });
                                        Get.back();
                                      },
                                      child: CustomText(text: 'created_oldest_latest'.tr),
                                    ),
                                  ]
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.sort, color: Color(0xFF98a4b1)),
                                SizedBox(width: 6.0),
                                CustomText(text: 'sort_by'.tr)
                              ],
                            ),
                          ),
                        ]
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gridView = false;
                              });
                              // productController.viewList();
                            },
                            icon: Icon(Icons.view_list, color: Color(0xFF98a4b1)),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gridView = true;
                              });
                              // productController.gridView();
                            },
                            icon: Icon(Icons.grid_view, color: Color(0xFF98a4b1)),
                          ),
                        ]
                      ),
                    ]
                  ),
                ),
              ),
            ),
            Obx(() {
              if(productController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return StaggeredGridView.countBuilder(
                  itemCount: productController.productList.length,
                  // controller: new ScrollController(keepScrollOffset: false),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  // staggeredTileBuilder: (index) => StaggeredTile.extent(gridView == true ? 2 : 18, 320),
                  staggeredTileBuilder: (index) => StaggeredTile.fit(gridView == true ? 1 : 18),
                  mainAxisSpacing: 8.0,
                  crossAxisCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    var product = productController.productList[index];
                    var rating = product.reviews.length == 0 ? 0 : product.reviews.map((review) => review['rating']).reduce((a, b) => a + b) / product.reviews.length;
                    return InkWell(
                      onTap: () => Get.to(ProductDetails(id: product.id)),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                cachedNetworkImage('$image_api${product.image}', context, gridView == true ? 165.0 : 185.0, width: MediaQuery.of(context).size.width),
                                // cachedNetworkImage('https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg', context, 165, width: MediaQuery.of(context).size.width),
                                // cachedNetworkImage('http://10.0.2.2:8000${product.image}', context, 165, width: MediaQuery.of(context).size.width),
                                GetX<FavoriteController>(
                                  init: FavoriteController(),
                                  builder: (val) {
                                    return Positioned(
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () async{
                                          favoriteController.addFavorite(product.id);
                                          val.fetchFavoriteItem();
                                        },
                                        icon: Icon(val.favorites.contains(product.id) ? Icons.favorite
                                          : Icons.favorite_border, color: Colors.red, size: 28.0),
                                        // icon: Icon(Icons.favorite_border, color: Colors.red),
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
                                    child: Center(child: CustomText(text:'New', color: Colors.white, fontSize: 12)),
                                  ) : CustomText(text: ''),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 10.0, top: 8.0),
                              child: ContainerLang(
                                width: MediaQuery.of(context).size.width,
                                child: CustomTextLang(text: product.name ?? '', textAR: product.nameAr, fontSize: 16.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, maxLines: 2,)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 8.0),
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
                            rating == 0 ? SizedBox()
                              : Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 12.0, top: 8.0),
                                child: Container(
                                    width: 55.0,
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
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
                                width: MediaQuery.of(context).size.width,
                                child: CustomButton(
                                  onPressed: () async{
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
                    );
                  }
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}