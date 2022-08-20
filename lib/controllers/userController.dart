import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/services/userServices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  
  var isLoading = true.obs;
  var isUserOrdersLoading = true.obs;
  var userLoginLoading = false.obs;
  var userSignUpLoading= false.obs;

  var userList = [].obs;
  var userOrders = [].obs;
  var userDeliveryOrders = [].obs;
  var userData = User().obs;

  var messaging = FirebaseMessaging.instance;
  
  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async{
    try{
      isLoading(true);
      var user = await UserServices.fetchUser();
      if(user != null) {
        userList.value = user;
      }
    } finally{
      isLoading(false);
    }
  }

  void editUser(id, user) async{
    try{
      isLoading(true);
      user = await UserServices.editUser(id, user);
      userData.value = user;
    } finally{
      isLoading(false);
    }
  }

  void updateToken(id, token) async {
    try{
      isLoading(true);
      await UserServices.updateToken(id, token);
    } finally{
      isLoading(false);
    }
  }

  void login(user) async{
    try{
      userLoginLoading(true);
      await UserServices.login(user);
    } finally{
      userLoginLoading(false);
    }
  }

  void forgotPassword(email) async{
    try{
      userLoginLoading(true);
      await UserServices.forgotPassword(email);
    } finally{
      userLoginLoading(false);
    }
  }

  void signUp(user) async{
    try{
      userSignUpLoading(true);
      await UserServices.signUp(user);
    } finally{
      userSignUpLoading(false);
    }
  }

  void logout() async{
    await UserServices.logout();
  }

  void getUserOrders(id) async{
    try {
      isUserOrdersLoading(true);
      var userOrder = await UserServices.getUserOrders(id);
      if(userOrder != null) {
        userOrders.value = userOrder;
      }
    } catch (e) {
      print(e);
    } finally{
      isUserOrdersLoading(false);
    }
  }

  void getUserDeliveryOrders(id) async{
    try {
      isUserOrdersLoading(true);
      var userDeliveryOrder = await UserServices.getUserDeliveryOrders(id);
      if(userDeliveryOrder != null) {
        userDeliveryOrders.value = userDeliveryOrder;
      }
    } catch (e) {
      print(e);
    } finally{
      isUserOrdersLoading(false);
    }
  }

  Future getUser() async{
    try {
      // isUserOrdersLoading(true);
      var user = await UserServices.getUser();
      if(user != null) {
        userData.value = user;
        messaging.getToken().then((token) {
          var changeToken = {"token": token};
          userController.updateToken(user.id, changeToken);
        });
        print("User ID => ${userData.value.id}");
      }
    } catch (e) {
      print(e);
    }
  }

  void updateOrder(id) async{
    try {
      await UserServices.updateOrder(id);
    } catch (e) {
      print(e);
    }
  }

}