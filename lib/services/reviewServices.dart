import 'package:ecommerce/api.dart';
import 'package:ecommerce/models/reviews.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class ReviewServices{

  static Future<List<Review>?> fetchReview() async{
    var response = await http.get(Uri.parse('$my_api/review'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return reviewFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future addReview(review) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.post(Uri.parse('$my_api/review'), body: jsonEncode(review), headers: headers);
    if (response.statusCode == 200) {
      showSuccessSnackBar('review'.tr, 'added_successfuly'.tr);
    } else {
      showErrorSnackBar('review'.tr, 'there_are_error'.tr);
    }
  }

}