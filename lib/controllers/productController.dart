import 'package:ecommerce/services/productServices.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var isLoading = true.obs;
  var isCategoryProductLoading = true.obs;

  var isGrid = true.obs;
  var productList = [].obs;
  var orderProducts = [].obs;
  var filterProductList = [].obs;
  var categoryProductList = [].obs;

  RxSet<int?> categories = <int>{}.obs;
  RxSet<int?> brands = <int>{}.obs;
  RxSet<int?> colors = <int>{}.obs;
  RxSet<int?> sizes = <int>{}.obs;

  var counter = 0.obs;

  void increment() {
    counter.value++;
  }

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  void viewList() {
    isGrid.value = false;
  }

  void gridView() {
    isGrid.value = true;
  }

  void categoryFilter(int? categoryId) {
    bool isSaved = categories.contains(categoryId);
    if(isSaved) {
      categories.remove(categoryId);
    } else {
      categories.add(categoryId);
    }
  }

  void brandFilter(int? brandId) {
    bool isSaved = brands.contains(brandId);
    if(isSaved) {
      brands.remove(brandId);
    } else {
      brands.add(brandId);
    }
  }

  void colorFilter(int? colorId) {
    bool isSaved = colors.contains(colorId);
    if(isSaved) {
      colors.remove(colorId);
    } else {
      colors.add(colorId);
    }
  }

  void sizeFilter(int? sizeId) {
    bool isSaved = sizes.contains(sizeId);
    if(isSaved) {
      sizes.remove(sizeId);
    } else {
      sizes.add(sizeId);
    }
  }

  void reset() {
    categories.clear();
    brands.clear();
    colors.clear();
    sizes.clear();
  }

  void fetchProduct() async{
    try{
      isLoading(true);
      var products =  await ProductServices.fetchProduct();
      if(products != null) {
        productList.value = products;
      }
    } finally{
      isLoading(false);
    }
  }

  void fetchCategoryProducts(id) async{
    try{
      isCategoryProductLoading(true);
      var categoryProducts = await ProductServices.fetchCategoryProducts(id);
      if(categoryProducts != null) {
        categoryProductList.value = categoryProducts;
      }
    } finally{
      isCategoryProductLoading(false);
    }
  }

  void getOrderProducts(orderId) async{
    try{
      isLoading(true);
      var orderProduct =  await ProductServices.orderProducts(orderId);
      if(orderProduct != null) {
        orderProducts.value = orderProduct;
      }
    } finally{
      isLoading(false);
    }
  }

  void filterProduct(filterProducts) async{
    try{
      isLoading(true);
      var products =  await ProductServices.filterProduct(filterProducts);
      if(products != null) {
        filterProductList.value = products;
      }
    } finally{
      isLoading(false);
    }
  }

}