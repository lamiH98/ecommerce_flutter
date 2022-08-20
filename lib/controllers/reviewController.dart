import 'package:ecommerce/services/reviewServices.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController{
  
  var isLoading = true.obs;
  var reviewsList = [].obs;

  @override
  void onInit() {
    fetchReview();
    super.onInit();
  }

  void fetchReview() async{
    try{
      isLoading(true);
      var reviews =  await ReviewServices.fetchReview();
      if(reviews != null) {
        reviewsList.value = reviews;
      }
    } finally{
      isLoading(false);
    }
  }

  void addReview(review) async{
    try{
      isLoading(true);
      await ReviewServices.addReview(review);
    } finally{
      isLoading(false);
    }
  }
}