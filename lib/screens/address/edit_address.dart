import 'package:ecommerce/controllers/addressController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddress extends StatefulWidget {
  
  final address;
  EditAddress(this.address);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddressController addressController = Get.find();
  final UserController userController = Get.find();

  get address => widget.address;

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController _cityController = TextEditingController(text: widget.address.city);
    final TextEditingController _neighourhoodController = TextEditingController(text: widget.address.neighourhood);
    final TextEditingController _streetController = TextEditingController(text: widget.address.street);

    editAddress() async{
      var formData = _formKey.currentState!;
      if(formData.validate()) {
        formData.save();
        var editAddress = {"city": _cityController.text, "neighourhood": _neighourhoodController.text, "street": _streetController.text, "defult": 0, "user_id": userController.userData.value.id};
        addressController.editAddress(widget.address.id, editAddress);
      }
      formData.reset();
    }

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
                CustomText(text: 'edit_address'.tr, fontSize: 24.0),
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
          editAddress();
          Get.back();
        },
        child: Icon(Icons.check, size: 28.0),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
    );
  }
}