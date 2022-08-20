import 'dart:convert';
import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/address.dart';

final UserController userController = Get.find();

class AddressServices{

  static Future<List<Address>?> fetchAddress() async{
    var id = userController.userData.value.id;
    var response = await http.get(Uri.parse('$my_api/user/userAddress/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return addressFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future addAddress(address) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.post(Uri.parse('$my_api/address'), body: jsonEncode(address), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('add_new_address'.tr, 'added_successfuly'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('add_new_address'.tr, message[0].toString());
    }
  }

  static Future editAddress(id, address) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.put(Uri.parse('$my_api/address/$id'), body: jsonEncode(address), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('update_address'.tr, 'updated_successfuly'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('update_address'.tr, message[0].toString());
    }
  }

  static Future updateDefaultAddress(id, address) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.put(Uri.parse('$my_api/address/updateDefault/$id'), body: jsonEncode(address), headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      showSuccessSnackBar('update_address'.tr, 'updated_successfuly'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('update_address'.tr, message[0].toString());
    }
  }

  static Future deleteAddress(id) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.delete(Uri.parse('$my_api/address/$id'), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('delete_address'.tr, 'deleted_successfuly'.tr);
    } else if (response.statusCode == 404){
      showErrorSnackBar('delete_address'.tr, 'address_not_found'.tr);
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('delete_address'.tr, message[0].toString());
    }
  }
  
}