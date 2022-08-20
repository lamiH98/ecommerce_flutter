import 'package:ecommerce/services/sizeServices.dart';
import 'package:get/get.dart';

class SizeController extends GetxController{
  
  var isLoading = true.obs;

  var sizeList = [].obs;

  @override
  void onInit() {
    fetchSize();
    super.onInit();
  }

  void fetchSize() async{
    try{
      isLoading(true);
      var size = await SizeServices.fetchSize();
      if(size != null) {
        sizeList.value = size;
      }
    } finally{
      isLoading(false);
    }
  }

}