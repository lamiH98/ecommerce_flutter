import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/favoriteController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controllers/languageController.dart';

class ProductSearch extends SearchDelegate{

  final ProductController productController = Get.find();
  final FavoriteController favoriteController = Get.find();
  final AppLanguage languageController = Get.put(AppLanguage());

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: Icon(Icons.clear),
      ),
    ];
  }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {

      var searchList = query.isEmpty ?
        productController.productList :
        productController.productList.where((product) => product.name.startsWith(query)).toList();

      return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              onTap: () => Get.to(ProductDetails(id: searchList[index].id)),
              leading: cachedNetworkImage('http://ecommerce-lami.herokuapp.com${searchList[index].image}', context, 100, width: 100.0),
              title: Text(searchList[index].name),
              trailing: Text(searchList[index].priceOffer != null ? searchList[index].priceOffer.toString() : searchList[index].price.toString()),
            ),
          );
        },
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {

      var searchList = query.isEmpty ?
        productController.productList :
        productController.productList.where((product) {
          return languageController.appLocale == 'en' ? 
          product.name.startsWith(query)
          : product.nameAr.startsWith(query);
        }).toList();

      return query.isEmpty ? 
      Obx(() {
        if(productController.isLoading.value)
          return Center(child: CircularProgressIndicator());
        else
          return Center(            
            child: SvgPicture.asset(
              'assets/images/searching_2.svg'
            ),
          );
        }
      ) : ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (BuildContext context, int index) {
          var item = searchList[index];
          return searchList.length > 0 ? Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: InkWell(
              onTap: () => Get.to(ProductDetails(id: item.id)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 110.0,
                        height: 110.0,
                        child: cachedNetworkImage('$image_api${searchList[index].image}', context, 110),
                      ),
                      SizedBox(width: 15.0),
                      ContainerLang(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CustomTextLang(text: item.name, textAR: item.nameAr, maxLines: 3, overflow: TextOverflow.ellipsis,)
                      ),
                    ],
                  ),
                  CustomText(text: item.priceOffer != null ? item.priceOffer.toString() : item.price.toString()),
                ],
              ),
            ),
          )
          : Center(child: CustomText(text: 'No Product'));
        },
      );
    }
    
}