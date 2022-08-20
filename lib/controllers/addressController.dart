import 'package:ecommerce/services/addressServices.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{
  
  var isLoading = true.obs;
  var isOperationLoading = false.obs;
  var addressList = [].obs;

  @override
  void onInit() {
    fetchAddress();
    super.onInit();
  }

  void fetchAddress() async{
    try{
      isLoading(true);
      var addresses = await AddressServices.fetchAddress();
      if(addresses != null) {
        addressList.value = addresses;
      }
    } finally{
      isLoading(false);
    }
  }

  void addAddress(address) async{
    try{
      isLoading(true);
      await AddressServices.addAddress(address);
      fetchAddress();
    } finally{
      isLoading(false);
    }
  }

  void editAddress(id, address) async{
    try{
      isLoading(true);
      await AddressServices.editAddress(id, address);
      fetchAddress();
    } finally{
      isLoading(false);
    }
  }

  void updateDefaultAddress(id, address) async{
    try{
      isOperationLoading(true);
      await AddressServices.updateDefaultAddress(id, address);
      fetchAddress();
    } finally{
      isOperationLoading(false);
    }
  }

  void deleteAddress(id) async{
    try{
      isOperationLoading(true);
      await AddressServices.deleteAddress(id);
      fetchAddress();
    } finally{
      isOperationLoading(false);
    }
  }

}