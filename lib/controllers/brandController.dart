import 'package:ecommerce/services/brandServices.dart';
import 'package:get/get.dart';

class BrandController extends GetxController{
  
  var isLoading = true.obs;
  var brandList = [].obs;

  @override
  void onInit() {
    fetchBrand();
    super.onInit();
  }

  void fetchBrand() async{
    try{
      isLoading(true);
      var brands = await BrandServices.fetchBrand();
      if(brands != null) {
        brandList.value = brands;
      }
    } finally{
      isLoading(false);
    }
  }

}