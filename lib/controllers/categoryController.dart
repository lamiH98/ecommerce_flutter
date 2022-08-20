import 'package:ecommerce/services/categoryServices.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  
  var isLoading = true.obs;
  var isSubcategoryLoading = true.obs;
  var isCategoryProductLoading = true.obs;

  var categoryList = [].obs;
  var subCategoryList = [].obs;

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  void fetchCategory() async{
    try{
      isLoading(true);
      var categories = await CategoryServices.fetchCategory();
      if(categories != null) {
        categoryList.value = categories;
      }
    } finally{
      isLoading(false);
    }
  }

  void fetchSubCategory(id) async{
    try{
      isSubcategoryLoading(true);
      var subCategories = await CategoryServices.fetchSubCategory(id);
      if(subCategories != null) {
        subCategoryList.value = subCategories;
      }
    } finally{
      isSubcategoryLoading(false);
    }
  }

}