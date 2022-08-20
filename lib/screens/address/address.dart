import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/address/add_address.dart';
import 'package:ecommerce/screens/address/edit_address.dart';
import 'package:ecommerce/screens/widgets/custom_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AllAddress extends StatefulWidget {

  @override
  _AllAddressState createState() => _AllAddressState();
}

class _AllAddressState extends State<AllAddress> {

  final AddressController addressController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: addressController.isOperationLoading.value,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    ),
                    CustomText(text: 'address'.tr, fontSize: 24.0),
                    CustomText(text: ''),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16, top: 12.0, bottom: 14.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: CustomText(text: 'my_addresses'.tr, fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
              ),
              addressController.addressList.length > 0 ? ListView.builder(
                itemCount: addressController.addressList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int item) {
                  var address = addressController.addressList[item];
                  // var check = address.check == false ? false : true;
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF34bfa3),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(EditAddress(address));
                                  },
                                  child: Center(
                                    child: Icon(Icons.edit, color: Colors.white, size: 20.0)
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFf4516c),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    addressController.deleteAddress(address.id);
                                    addressController.fetchAddress();
                                  },
                                  child: Center(
                                    child: Icon(Icons.delete, color: Colors.white, size: 20.0)
                                  ),
                                ),
                              ),
                            ]
                          ),
                          Row(
                            children: [
                              CustomText(text: 'street'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                              SizedBox(width: 6.0),
                              CustomText(text: address.street),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            children: [
                              CustomText(text: 'neighourhood'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                              SizedBox(width: 6.0),
                              CustomText(text: address.neighourhood),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            children: [
                              CustomText(text: 'city'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                              SizedBox(width: 6.0),
                              CustomText(text: address.city),
                            ],
                          ),
                          Row(
                            children: [
                              CustomText(text: 'defualt'.tr, fontWeight: FontWeight.bold, fontSize: 17.0),
                              Switch(
                                value: address.check,
                                activeColor: mainColor,
                                onChanged: (bool changeValue) {
                                  var value = changeValue == true ? 1 : 0;
                                  var editAddress = {"default": value, "user_id": userController.userData.value.id};
                                  print(address.check);
                                  addressController.updateDefaultAddress(address.id, editAddress);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ) : Center(child: Column(
                children: [
                  CustomText(text: 'no_address'.tr, fontWeight: FontWeight.bold, fontSize: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: CustomButton(
                      onPressed: () => Get.to(AddAddress()),
                      child: CustomText(text: 'add_new_address'.tr, color: Colors.white),
                      
                    ),
                  ),
                ],
              ))
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddAddress()),
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
    );
  }
}