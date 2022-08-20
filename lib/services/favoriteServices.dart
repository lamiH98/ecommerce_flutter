import 'dart:convert';
import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/Favorite.dart';

final UserController userController = Get.find();

class FavoriteServices{

  static Future<List<Favorite>?> fetchFavorite() async{
    var id = userController.userData.value.id;
    var response = await http.get(Uri.parse('$my_api/userFavorite/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return favoriteFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future addFavorite(productId) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var favorite = {"user_id": userController.userData.value.id, "product_id": productId};
    var response = await http.post(Uri.parse('$my_api/userFavorite'), body: jsonEncode(favorite), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('favorite'.tr, 'added_successfuly'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('favorite'.tr, message[0].toString());
    }
  }

  static Future deleteFavorite(id) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.delete(Uri.parse('$my_api/userFavorite/$id'), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('favorite'.tr, 'deleted_successfuly'.tr);
    } else if (response.statusCode == 404){
      showErrorSnackBar('favorite'.tr, 'address_not_found'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('favorite'.tr, message[0].toString());
    }
  }
  
}