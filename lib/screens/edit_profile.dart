import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final UserController userController = Get.find();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? image;
  Future pickerCamera(source) async{
    try{
      final XFile? imageUpload = await ImagePicker().pickImage(source: source);
      setState(() {
        image = File(imageUpload!.path);
      });
    } on PlatformException catch(e) {
      print(e);
    }
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _nameController.text = userController.userData.value.name!;
    _emailController.text = userController.userData.value.email!;
    super.initState();
  }

  update() async{
    var formData = _formKey.currentState;
    if(image == null) {
      if(formData!.validate()) {
        formData.save();
        var user = {"imageBase64": null, "imageName": null, "name": _nameController.text, "email": _emailController.text, "password": _passwordController.text};
        userController.editUser(userController.userData.value.id, user);
      }
    } else {
      String base64 = base64Encode(image!.readAsBytesSync());
      String imageName = image!.path.split("/").last;
      if(formData!.validate()) {
        formData.save();
        var user = {"imageBase64": base64, "imageName": imageName, "name": _nameController.text, "email": _emailController.text, "password": _passwordController.text};
        userController.editUser(userController.userData.value.id, user);
      }
    }
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
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back),
                ),
                CustomText(text: 'edit_profile'.tr, fontSize: 22.0),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: userController.userData.value.image == null && image == null  ? Image.asset('assets/images/people/people_1.jpg', height: 100.0)
                    : image == null 
                    // ? cachedNetworkImage('$image_api/image/${userController.userData.value.image}', context, 90,width:  90)
                    ? Image.asset('assets/images/people/people_1.jpg', height: 100.0)
                    : Image.file(image!, height: 90.0)
                  ),
                  // CustomButton(
                  //   onPressed: () => pickerCamera(ImageSource.gallery),
                  //   child: CustomText(text: 'upload_image'.tr, color: Colors.white),
                  //   color: mainColor,
                  // ),
                  SizedBox(height: 18.0),
                  buildTextFormField('enter_name'.tr, false, _nameController, 'name'),
                  buildTextFormField('enter_email'.tr, false, _emailController, 'email'),
                  buildTextFormField('enter_password'.tr, true, _passwordController, 'password'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => update(),
        child: Icon(Icons.check, size: 30.0),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
    );
  }
}