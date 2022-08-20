import 'package:ecommerce/api.dart';
import 'package:ecommerce/models/notification.dart';
import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class NotificationServices{

  static Future fetchNotification(userId) async{
    var response = await http.get(Uri.parse('$my_api/notifications/$userId'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return notificationFromJson(jsonString);
    } else if(response.statusCode == 404) {
      var responseBody = jsonDecode(response.body);
      showErrorSnackBar('notificaiton'.tr, responseBody['message']);
    } else {
      showErrorSnackBar('notificaiton'.tr, 'there_are_error_in_notification'.tr);
    }
  }

}