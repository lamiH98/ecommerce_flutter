import 'package:ecommerce/services/favoriteServices.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController{
  
  var isLoading = true.obs;
  var isDeleteLoading = false.obs;
  var favoriteList = [].obs;
  RxSet<int?> favorites = <int>{}.obs;

  @override
  void onInit() {
    fetchFavoriteItem();
    super.onInit();
  }

  void fetchFavoriteItem() async{
    try{
      isLoading(true);
      var favoritesItem = await FavoriteServices.fetchFavorite();
      if(favoritesItem != null) {
        favoriteList.value = favoritesItem;
        favoriteList.forEach((element) {
          favorites.add(element.productId);
        });
      }
    } finally{
      isLoading(false);
    }
  }

  void addFavorite(favorite) async{
    try{
      isLoading(true);
      await FavoriteServices.addFavorite(favorite);
      fetchFavoriteItem();
      favoriteList.forEach((element) {
        if(element.productId == favorite){
          favoriteList.forEach((element) {
            favorites.remove(favorite);
          });
        }
      });
    } finally{
      isLoading(false);
    }
  }

  void deleteFavorite(id, productId) async{
    try{
      isDeleteLoading(true);
      await FavoriteServices.deleteFavorite(id);
      fetchFavoriteItem();
      favorites.remove(productId);
    } finally{
      isDeleteLoading(false);
    }
  }

}