import 'dart:convert';
import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final UserController userController = Get.find();

class CartServices{

  static Future<List<Cart>?> fetchCartItems() async{
    var id = userController.userData.value.id;
    var response = await http.get(Uri.parse('$my_api/cartItems/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return cartFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future getTotalPrice() async{
    var id = userController.userData.value.id;
    var response = await http.get(Uri.parse('$my_api/cartItems/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return Total.fromJson(jsonDecode(jsonString));
    } else {
      return null;
    }
  }

  static Future addItemToCart(itemCart) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.post(Uri.parse('$my_api/cart'), body: jsonEncode(itemCart), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('add_item_to_cart'.tr, 'added_successfuly'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'];
      showErrorSnackBar('add_item_to_cart'.tr, message.toString());
    }
  }

  static Future editItemFromCart(id, quantity) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.put(Uri.parse('$my_api/cart/$id'), body: jsonEncode(quantity), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // showSuccessSnackBar('update_item_cart'.tr, 'updated_successfuly'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('update_item_cart'.tr, message[0].toString());
    }
  }

  static Future deleteItemFromCart(id) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.delete(Uri.parse('$my_api/cart/$id'), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('delete_item_cart'.tr, 'deleted_successfuly'.tr);
    } else if (response.statusCode == 404){
      showErrorSnackBar('delete_item_cart'.tr, 'item_not_found'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('delete_item_cart'.tr, message[0].toString());
    }
  }
  
}