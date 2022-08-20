import 'package:get/state_manager.dart';
import 'package:ecommerce/services/sliderServices.dart';

class SliderController extends GetxController {
  var isLoading = true.obs;
  var sliderList = [].obs;

  @override
  void onInit() {
    fetchSlider();
    super.onInit();
  }

  void fetchSlider() async {
    try {
      isLoading(true);
      var sliders = await SliderServices.fetchSlider();
      if (sliders != null) {
        sliderList.value = sliders;
      }
    } finally {
      isLoading(false);
    }
  }
  
}