import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/categoryController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/screens/categoryProducts.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {

  final CategoryController categoryController = Get.find();
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value)
        return Center(child: CircularProgressIndicator());
      else
        return Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryController.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                var category = categoryController.categoryList[index];
                return InkWell(
                  onTap: () {
                    productController.fetchCategoryProducts(category.id);
                    Get.to(CategoryProducts());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3.7,
                      height: 150.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                width: 2.0,
                                color: Color(0xFFE9E9E9)
                              )
                            ),
                            child: cachedNetworkImage('$image_api${category.image}', context, 85.0, width:  80.0),
                          ),
                          SizedBox(height: 14.0),
                          CustomTextLang(
                            text: category.name, textAR: category.nameAr, color: Colors.black, fontSize: 15.0, overflow: TextOverflow.ellipsis, maxLines: 1
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
    });
  }
}