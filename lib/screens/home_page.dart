import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/home_widgets/categories.dart';
import 'package:ecommerce/screens/home_widgets/products.dart';
import 'package:ecommerce/screens/home_widgets/sliders.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final UserController userController = Get.find();
  final CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async{
      final FavoriteController favoriteController = Get.put(FavoriteController());
      favoriteController.fetchFavoriteItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => showSearch(context: context, delegate: ProductSearch()),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        padding: EdgeInsets.only(left: 8.0, right: 28.0, top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3)
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 8.0),
                            CustomText(text: 'search_title'.tr, color: Colors.black.withOpacity(0.7))
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartController.fetchCartItems();
                        Get.toNamed('/cart');
                      },
                      icon: Icon(Icons.shopping_bag_outlined, color: mainColor),
                    ),
                  ],
                ),
              ),
        
              // Slider Section
              Sliders(),
        
              /** Categories Section **/
              Padding(
                padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'categories'.tr, fontSize: 17.0, fontWeight: FontWeight.bold),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/categories');
                      },
                      child: CustomText(text: 'view_all'.tr, color: Colors.grey)
                    ),
                  ],
                ),
              ),
              // Categories Widget
              Category(),
        
              // Product Section
              Padding(
                padding: const EdgeInsets.only(top: 38.0, left: 16.0, right: 16.0, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'exclusive_deals'.tr, fontSize: 17.0, fontWeight: FontWeight.bold),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/products');
                      },
                      child: CustomText(text: 'view_all'.tr, color: Colors.grey)
                    ),
                  ],
                ),
              ),
              // Product Widget
              Products(),
            ],
          ),
        ),
      ),
    );
  }
}