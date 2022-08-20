import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/categoryController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/screens/subCategory.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';

class Categories extends StatefulWidget{

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  final CategoryController categoryController = Get.find();
  final ProductController productController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back)
                ),
                CustomText(text: 'all_categories'.tr, fontWeight: FontWeight.bold, fontSize: 18.0,),
                IconButton(
                  onPressed: () {
                    cartController.fetchCartItems();
                    Get.toNamed('/cart');
                  },
                  icon: Icon(Icons.shopping_bag_outlined, color: mainColor, size: 28.0),
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
          Obx(() {
            if (categoryController.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var category = categoryController.categoryList[index];
                    return InkWell(
                      onTap: () {
                        categoryController.fetchSubCategory(category.id);
                        Get.to(SubCategories(category: category));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 65.0,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  // child: cachedNetworkImage('http://ecommerce-lami.herokuapp.com${category.image}', context, 90,width:  90, borderRadius: 150.0),
                                  child: cachedNetworkImage('$image_api${category.image}', context, 90,width:  90,),
                                ),
                                SizedBox(width: 12.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: CustomTextLang(text: category.name, textAR: category.nameAr)
                                ),
                              ]
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios),
                              iconSize: 18.0,
                            ),
                          ]
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}