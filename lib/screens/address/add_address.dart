import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddress extends StatefulWidget {

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _neighourhoodController = TextEditingController();
  TextEditingController _streetController = TextEditingController();

  final AddressController addressController = Get.find();
  final UserController userController = Get.find();

  addAddress() async{
    var formData = _formKey.currentState!;
    if(formData.validate()) {
      formData.save();
      var address = {"city": _cityController.text, "neighourhood": _neighourhoodController.text, "street": _streetController.text, "default": 0, "user_id": userController.userData.value.id};
      addressController.addAddress(address);
    }
    formData.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                CustomText(text: 'add_new_address'.tr, fontSize: 24.0),
                CustomText(text: ''),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextFormField('city'.tr, false, _cityController, 'city'),
                  buildTextFormField('neighourhood'.tr, false, _neighourhoodController, 'neighourhood'),
                  buildTextFormField('street'.tr, false, _streetController, 'street'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addAddress();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
    );
  }
}