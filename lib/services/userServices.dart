import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/user.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final UserController userController = Get.find();

class UserServices{

  // static final _googleSignIn = GoogleSignIn();

  static Future<List<User>?> fetchUser() async{
    var response = await http.get(Uri.parse('$my_api/user/users'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return userFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future editUser(id, user) async{
   Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.put(Uri.parse('$my_api/user/$id'), body: jsonEncode(user), headers: headers);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var user =  User.fromJson(responseBody['user']);
      Get.back();
      showSuccessSnackBar('update_user'.tr, 'updated_successfuly'.tr);
      return user;
    } else {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('update_user'.tr, message[0].toString());
    }
  }

  static Future updateToken(id, token) async{
   Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    await http.put(Uri.parse('$my_api/update/token/$id'), body: jsonEncode(token), headers: headers);
  }

  static Future<List<Order>?> getUserOrders(id) async{
    var response = await http.get(Uri.parse('$my_api/userOrders/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return orderFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Order>?> getUserDeliveryOrders(id) async{
    var response = await http.get(Uri.parse('$my_api/userDeliveryOrders/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return orderFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future login(user) async{
    var response = await http.post(Uri.parse('$my_api/user/login'), body: user);
    if (response.statusCode == 200) {
      SharedPreferences userPref = await SharedPreferences.getInstance();
      userPref.setString('token', response.body);
      userController.getUser();
      Get.to(Home());
    } else {
      var responseBody = json.decode(response.body);
      showErrorSnackBar('login'.tr, responseBody['message']);
    }
  }

  static Future signUp(user) async{
    var response = await http.post(Uri.parse('$my_api/user/register'), body: user);
    if (response.statusCode == 200) {
      SharedPreferences userPref = await SharedPreferences.getInstance();
      userPref.setString('token', response.body);
      userController.getUser();
      Get.to(Home());
    } else {
      var responseBody = json.decode(response.body);
      var message = responseBody['message'].values.toList();
      showErrorSnackBar('sign_up'.tr, message[0].toString());
    }
  }

  static Future forgotPassword(email) async{
    var response = await http.post(Uri.parse('$my_api/password/email'), body: email);
    if (response.statusCode == 200) {
      Get.back();
      showSuccessSnackBar('reset_password'.tr, 'check_your_email'.tr);
    } else {
      showErrorSnackBar('reset_password'.tr, 'there_are_error'.tr);
    }
  }

  static Future logout() async{
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? token = userPref.getString('token');
    var response = await http.get(Uri.parse('$my_api/user/logout'), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      userPref.remove('token');
      Get.to(Login());
    } else {
      showErrorSnackBar('logout'.tr, 'there_are_error'.tr);
    }
  }

  static Future getUser() async{
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? token = userPref.getString('token');
    var response = await http.get(Uri.parse('$my_api/user'), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var user =  User.fromJson(responseBody['user']);
      return user;
    } else {
      showErrorSnackBar('user_auth'.tr, 'there_are_error'.tr);
    }
  }

  static Future updateOrder(id) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var status = {"status": 'cancel'};
    var response = await http.put(Uri.parse('$my_api/orders/$id'), body: jsonEncode(status), headers: headers);
    if (response.statusCode == 200) {
      userController.getUserDeliveryOrders(userController.userData.value.id);
    }
  }
  
}