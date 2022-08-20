import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

class NetworkController extends GetxController{

  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription; 

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async{
    ConnectivityResult result;
    result = await _connectivity.checkConnectivity();
    try {
      
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result){
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
      showErrorSnackBar('network_error'.tr, 'failed_to_connection'.tr);
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

}