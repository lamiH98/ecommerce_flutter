import 'package:ecommerce/services/cartService.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  
  var isLoading = true.obs;
  var isCartLoading = false.obs;
  var cartItemsList = [].obs;
  var total = 0.0.obs;

  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  void fetchCartItems() async{
    getTotalPrice();
    try{
      isCartLoading(true);
      var cartItems = await CartServices.fetchCartItems();
      if(cartItems != null) {
        cartItemsList.value = cartItems;
      }
      print(cartItemsList.length);
    } finally{
      isCartLoading(false);
    }
  }

  void addItemToCart(cartItem) async{
    try{
      isCartLoading(true);
      await CartServices.addItemToCart(cartItem);
    } finally{
      isCartLoading(false);
    }
  }

  void editItemFromCart(id, quantity) async{
    try{
      isCartLoading(true);
      await CartServices.editItemFromCart(id, quantity);
      fetchCartItems();
    } finally{
      isCartLoading(false);
    }
  }

  void deleteItemFromCart(id) async{
    try{
      isLoading(true);
      await CartServices.deleteItemFromCart(id);
    } finally{
      isLoading(false);
    }
  }

  void getTotalPrice() async{
    try{
      isLoading(true);
      var totalCartItems = await CartServices.getTotalPrice();
      if(totalCartItems != null) {
        total.value = totalCartItems.total;
      }
    } finally{
      isLoading(false);
    }
  }

}