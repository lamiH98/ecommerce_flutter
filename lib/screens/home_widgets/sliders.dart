import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/productController.dart';
import 'package:ecommerce/controllers/sliderController.dart';
import 'package:ecommerce/controllers/reviewController.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class Sliders extends StatelessWidget {
  final SliderController sliderController = Get.find();
  final ReviewController reviewController = Get.find();
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (sliderController.isLoading.value)
        return Center(child: CircularProgressIndicator());
      else
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
          child: Container(
            height: 180,
            child: Swiper(
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: () => print(sliderController.sliderList[index].image),
                  child: Container(
                    height: 100.0,
                    // child: cachedNetworkImage('http://ecommerce-lami.herokuapp.com${sliderController.sliderList[index].image}', context, 160, width: 260),
                    child: cachedNetworkImage('$image_api${sliderController.sliderList[index].image}', context, 160, width: 260),
                  ),
                );
              },
              itemCount: sliderController.sliderList.length,
              pagination: new SwiperPagination(),
            ),
          ),
        );
    });
  }
}