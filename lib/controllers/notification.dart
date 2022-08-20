import 'package:ecommerce/services/notificationServices.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{

  var isLoading = true.obs;
  var notificationList = [].obs;

  void fetchNotification(userId) async{
    try{
      isLoading(true);
      var notifications =  await NotificationServices.fetchNotification(userId);
      if(notifications != null) {
        notificationList.value = notifications;
      }
    } finally{
      isLoading(false);
    }
  }

}