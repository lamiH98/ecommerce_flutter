import 'package:ecommerce/api.dart';
import 'package:ecommerce/models/order_product.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/product.dart';
import 'dart:convert';
import 'package:get/get.dart';

class ProductServices{

  static Future<List<Product>?> fetchProduct() async{
    var response = await http.get(Uri.parse('$my_api/products'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future orderProducts(orderId) async{
    var response = await http.get(Uri.parse('$my_api/getOrderProducts/$orderId'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return orderProductFromJson(jsonString);
    } else if(response.statusCode == 404) {
      var responseBody = jsonDecode(response.body);
      showErrorSnackBar('order_product'.tr, responseBody['message']);
    } else {
      showErrorSnackBar('order_product', 'there_are_error'.tr);
    }
  }

  static Future<List<Product>?> fetchCategoryProducts(id) async{
    var response = await http.get(Uri.parse('$my_api/getProductCategory/$id'));
    print(id);
    print(response.statusCode);
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Product>?> filterProduct(filterProducts) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.post(Uri.parse('$my_api/filter/products'), body: jsonEncode(filterProducts), headers: headers);
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

}