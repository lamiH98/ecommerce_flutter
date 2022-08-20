import 'package:ecommerce/services/colorServices.dart';
import 'package:get/get.dart';

class ColorController extends GetxController{
  
  var isLoading = true.obs;
  var colorList = [].obs;

  @override
  void onInit() {
    fetchColor();
    super.onInit();
  }

  void fetchColor() async{
    try{
      isLoading(true);
      var colors = await ColorServices.fetchColor();
      if(colors != null) {
        colorList.value = colors;
      }
    } finally{
      isLoading(false);
    }
  }

}