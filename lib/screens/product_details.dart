import 'package:ecommerce/api.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cartController.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/customBottomSheet.dart';
import 'package:ecommerce/screens/widgets/customHexColor.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget{
  final int? id;
  ProductDetails({this.id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with SingleTickerProviderStateMixin{

  
  TabController? tabController;
  bool isScrollControlled = false;
  int selectedImage = 0;
  final ProductController productController = Get.find();
  final UserController userController = Get.find();
  final CartController cartController = Get.find();

  get id => widget.id;
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    var productItem = productController.productList.firstWhere((element) => element.id == id);
    var rating = productItem.reviews.length == 0 ? 0 : productItem.reviews.map((review) => review['rating']).reduce((a, b) => a + b) / productItem.reviews.length;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 6.0, right: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back, color: Color(0xFF98a4b1))
                ),
                IconButton(
                  onPressed: () {
                    cartController.fetchCartItems();
                    Get.toNamed('/cart');
                  },
                  icon: Icon(Icons.shopping_bag_outlined, color: mainColor),
                  splashColor: Colors.blue,
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
          SizedBox(height: 12.0),
          SizedBox(
            height: 260.0,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: cachedNetworkImage('$image_api/image/${productItem.images[selectedImage]['path']}', context, 90,width:  90, fit: BoxFit.fitHeight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              height: 90.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productItem.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildSmallPreview(productItem, context, index);
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ...List.generate(
          //         productItem.images.length,
          //         (index) => buildSmallPreview(productItem, context, index),
          //       )
          //     ],
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: new Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextLang(text: productItem.name, textAR: productItem.nameAr, fontWeight: FontWeight.bold, fontSize: 20.0,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 14.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                productItem.quantity == 0 ? CustomText(text: 'out_stock'.tr, color: Colors.red) : productItem.quantity <= 10
                ? CustomText(text: "only".tr + " ${productItem.quantity.toString()} " + "in_stock".tr, color: Colors.red, fontWeight: FontWeight.bold)
                : SizedBox(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14.0, left: 14.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    productItem.priceOffer != null ? Row(
                      children: [
                        CustomText(text: productItem.priceOffer.toString(), fontSize: 18.0, fontWeight: FontWeight.bold, color: mainColor),
                        SizedBox(width: 10.0),
                        CustomText(text: productItem.price.toString(), decoration: TextDecoration.lineThrough, fontSize: 14.0),
                      ],
                    ) : CustomText(text: productItem.price.toString(), fontSize: 17.0, fontWeight: FontWeight.bold, color: mainColor),
                  ],
                ),
                rating == 0 ? Text('') : Row(
                  children: [
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 16.0,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(width: 6.0),
                    Text(rating.toStringAsFixed(1) ?? '', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13.0, right: 19.0, left: 19.0),
            child: Divider(thickness: 1.2, color: Colors.grey.withOpacity(0.2)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Center(
              child: TabBar(
                controller: tabController,
                indicatorColor: mainColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: mainColor, width: 3.0),
                  insets: EdgeInsets.only(bottom: 10.0),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child: Text('product'.tr, style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Tab(
                    child: Text('details'.tr, style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Tab(
                    child: Text('reviews'.tr, style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 240.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 26.0,top: 12.0,right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CustomText(text: 'colors'.tr, color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                      Container(
                        height: 30.0,
                        child: ListView.builder(
                          itemCount: productItem.colors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  color: HexColor(productItem.colors[index]['color']),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 28.0),
                        child: Text('sizes'.tr, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0)),
                      ),
                      Container(
                        height: 35.0,
                        child: ListView.builder(
                          itemCount: productItem.sizes.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                height: 30.0,
                                width: 34.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(child: Text(productItem.sizes[index]['size'], style: TextStyle(color: Colors.white))),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.0, top: 12.0, right: 16.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('brand'.tr, style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 6.0),
                                CustomTextLang(text: productItem.brand['brand'], textAR: productItem.brand['brand_ar'], fontWeight: FontWeight.bold, fontSize: 18.0),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'sku'.tr, color: Colors.grey),
                                SizedBox(height: 6.0),
                                CustomText(text: productItem.id.toString(), fontWeight: FontWeight.bold),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'category'.tr, color: Colors.grey),
                                SizedBox(height: 6.0),
                                CustomTextLang(text: productItem.category['name'], textAR: productItem.category['name_ar'], fontWeight: FontWeight.bold),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0, bottom: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'description'.tr),
                            SizedBox(height: 6.0),
                            // CustomText(text: productItem.details, fontWeight: FontWeight.bold),
                            CustomTextLang(text: productItem.details, textAR: productItem.detailsAr, fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                productItem.reviews.length == 0 ? Center(child: CustomText(text: 'no_reviews'.tr)) : ListView.builder(
                  shrinkWrap: true,
                  itemCount: productItem.reviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    var productReview = productItem.reviews[index];
                    var user = userController.userList.where((user) => user.id == productReview['user_id']).toList();
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => print(user[0].image),
                          child: Padding(
                            padding: EdgeInsets.only(left: 28.0,top: 14.0,bottom: 14.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80.0),
                              child: user[0].image == null ? Image.asset('assets/images/people/people_1.jpg', height: 60)
                              : cachedNetworkImage('$image_api/image/${user[0].image}', context, 60,width: 60),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user[0].name, style: TextStyle(fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(top: 6, bottom: 10.0),
                                child: RatingBar.builder(
                                  initialRating: productReview['rating'] / 1.0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 16.0,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                              productReview['comment'] == null ? CustomText(text: '') : Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width - 120.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                ),
                                child: Text(productReview['comment'], style: TextStyle(color: Colors.black.withOpacity(0.6))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18.0, bottom: 12.0),
        child: Container(
          width: 140.0,
          height: 40.0,
          child: OutlineButton(
            onPressed: () => productBottomSheet(productItem, context),
            child: new Text("add_to_cart".tr, style: TextStyle(color: Colors.blue, fontSize: 17.0)),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  GestureDetector buildSmallPreview(productItem, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(right: 7.0, left: 7.0),
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: selectedImage == index ? mainColor : Colors.grey),
        ),
        child: cachedNetworkImage('$image_api/image/${productItem.images[index]['path']}', context, 90,width:  90, fit: BoxFit.fitHeight),
      ),
    );
  }

}