import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/brandController.dart';
import 'package:ecommerce/controllers/categoryController.dart';
import 'package:ecommerce/controllers/colorController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/sizeController.dart';
import 'package:ecommerce/screens/productFilter.dart';
import 'package:ecommerce/screens/widgets/customHexColor.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isScrollControlled = false;
RangeValues values = RangeValues(0, 5000.0);
RangeLabels labels = RangeLabels('0.00','5000.00');

var categories = <int>{};
var colors = <int>{};
var sizes = <int>{};

int selectedColor = 0;
int selectedSize = 0;

final BrandController brandController = Get.find();
final SizeController sizeController = Get.find();
final ColorController colorController = Get.find();
final CategoryController categoryController = Get.find();
final ProductController productController = Get.find();

void filter(context) {
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
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.4,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        // print(isScrollControlled);
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
                    padding: EdgeInsets.only(top: 14.0,right: 8.0,left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            productController.reset();
                          },
                          child: Text('reset'.tr, style: TextStyle(fontSize: 16.0))
                        ),
                        Text('filter'.tr, style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () {
                            Get.back();
                            var filterProducts = {"low_price": labels.start, "high_price": labels.end, "categoryId": productController.categories.toList(), "brandId": productController.brands.toList(),"colorId": productController.colors.toList(), "sizeId": productController.sizes.toList()};
                            productController.filterProduct(filterProducts);
                            Get.to(ProductsFilter());
                            productController.reset();
                          },
                          child: Text('done'.tr, style: TextStyle(color: mainColor, fontSize: 16.0))
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 2.0),
        
                  // Categories
                  Obx(() {
                    if(categoryController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ExpandablePanel(
                          collapsed: CustomText(text: ''),
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('categories'.tr, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              Icon(Icons.keyboard_arrow_down, size: 30.0),
                            ],
                          ),
                          // collapsed: Text('body', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                          theme: const ExpandableThemeData(
                            hasIcon: false,
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Wrap(
                              children: [
                                ContainerLang(
                                  height: 110.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categoryController.categoryList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      var category = categoryController.categoryList[index];
                                      var categoryId = category.id;
                                      return GetX<ProductController>(
                                        init: ProductController(),
                                        builder: (val) {
                                          return InkWell(
                                            onTap: () {
                                              productController.categoryFilter(categoryId);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Flex(
                                                direction: Axis.vertical,
                                                children: [
                                                  val.categories.contains(categoryId) ? 
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 70.0,
                                                        child: cachedNetworkImage('$image_api${category.image}', context, 70.0, width: 70.0),
                                                        // child: cachedNetworkImage('https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg', context, 70.0, width: 70.0),
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Container(
                                                            width: 30.0,
                                                            height: 30.0,
                                                            decoration: BoxDecoration(
                                                              color: Colors.lightBlueAccent,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: Center(child: Icon(Icons.check, size: 22.0, color: Colors.white))
                                                          )
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  : Container(
                                                    height: 70.0,
                                                    child: cachedNetworkImage('$image_api${category.image}', context, 70.0, width: 70.0),
                                                    // child: cachedNetworkImage('https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg', context, 70.0, width: 70.0),
                                                  ),
                                                  Container(
                                                    width: 110.0,
                                                    child: CustomTextLang(text: category.name, textAR: category.nameAr, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  }),
        
                  // Brands
                  Obx(() {
                    if(brandController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ExpandablePanel(
                          collapsed: CustomText(text: ''),
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'brands'.tr, fontSize: 18.0, fontWeight: FontWeight.bold),
                              Icon(Icons.keyboard_arrow_down, size: 30.0),
                            ],
                          ),
                          // collapsed: Text('body', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                          theme: const ExpandableThemeData(
                            hasIcon: false,
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Wrap(
                              children: [
                                ContainerLang(
                                  height: 110.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: brandController.brandList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      var brand = brandController.brandList[index];
                                      var brandId = brand.id;
                                      return GetX<ProductController>(
                                        init: ProductController(),
                                        builder: (val) {
                                          return InkWell(
                                            onTap: () {
                                              productController.brandFilter(brandId);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Column(
                                                children: [
                                                  val.brands.contains(brandId) ? 
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 70.0,
                                                        child: cachedNetworkImage('$image_api${brand.image}', context, 70.0, width: 90.0, fit: BoxFit.fitWidth),
                                                        // child: cachedNetworkImage('https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg', context, 70.0, width: 70.0),
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Container(
                                                            width: 30.0,
                                                            height: 30.0,
                                                            decoration: BoxDecoration(
                                                              color: Colors.lightBlueAccent,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: Center(child: Icon(Icons.check, size: 22.0, color: Colors.white))
                                                          )
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  : Container(
                                                    height: 70.0,
                                                    child: cachedNetworkImage('$image_api${brand.image}', context, 70.0, width: 90.0, fit: BoxFit.fitWidth),
                                                    // child: cachedNetworkImage('https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg', context, 70.0, width: 70.0),
                                                  ),
                                                  CustomTextLang(text: brand.brand, textAR: brand.brandAr, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  }),
                  // Sizes
                  Obx(() {
                    if(sizeController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ExpandablePanel(
                          collapsed: CustomText(text: ''),
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'sizes'.tr, fontSize: 18.0, fontWeight: FontWeight.bold),
                              Icon(Icons.keyboard_arrow_down, size: 30.0),
                            ],
                          ),
                          // collapsed: Text('body', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                          theme: const ExpandableThemeData(
                            hasIcon: false,
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: ContainerLang(
                                    height: 70.0,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: sizeController.sizeList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var size = sizeController.sizeList[index];
                                        var sizeId = sizeController.sizeList[index].id;
                                        return GetX<ProductController>(
                                          init: ProductController(),
                                          builder: (val) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  productController.sizeFilter(sizeId);
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  width: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: val.sizes.contains(sizeId) ? Colors.blue : Colors.grey,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(child: CustomTextLang(text: size.size, textAR: size.sizeAr, color: Colors.white)),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  }
                  ),
        
                  // Colors
                  Obx(() {
                    if(colorController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ExpandablePanel(
                          collapsed: CustomText(text: ''),
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'colors'.tr, fontSize: 18.0, fontWeight: FontWeight.bold),
                              Icon(Icons.keyboard_arrow_down, size: 30.0),
                            ],
                          ),
                          // collapsed: Text('body', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                          theme: const ExpandableThemeData(
                            hasIcon: false,
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Wrap(
                              children: [
                                ContainerLang(
                                  height: 85.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: colorController.colorList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      var color = colorController.colorList[index];
                                      return GetX<ProductController>(
                                        init: ProductController(),
                                        builder: (val) {
                                          return InkWell(
                                            onTap: () {
                                              productController.colorFilter(color.id);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                      border: val.colors.contains(color.id) ? Border.all(color: HexColor(color.color)) : Border.all(width: 0.0),
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        padding: const EdgeInsets.all(4.0),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: mainColor),
                                                          color: HexColor(color.color),
                                                          borderRadius: BorderRadius.circular(50),
                                                        ),
                                                        child: val.colors.contains(color.id) ? Center(
                                                          child: Icon(Icons.check, color: Colors.white),
                                                        ) : CustomText(text: ''),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.0),
                                                  CustomTextLang(text: color.colorName, textAR: color.colorNameAr, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Text("price_range".tr, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                  ),
                  
                  StatefulBuilder(
                    builder: (context, setState){
                      return RangeSlider(
                        min: 0.0,
                        max: 5000.0,
                        labels: RangeLabels('${labels.start}', '${labels.end}'),
                        values: values,
                        activeColor: mainColor,
                        divisions: 50,
                        onChanged: (value) {
                          // print(int.parse(value.toString()));
                          values = value;
                          setState(() {
                            labels = RangeLabels(value.start.toString(), value.end.toString());
                            // labels = value;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      );
    }
  ).whenComplete(() {
    print('Hey there, I\'m calling after hide bottomSheet');
  });
}