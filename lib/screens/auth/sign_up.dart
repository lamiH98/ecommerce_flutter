import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/widgets/custom_raised_gradient_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  GlobalKey<FormState> _signUp = GlobalKey<FormState>();
  final UserController userController = UserController();
  var myToken;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  signUp() {
    var formData = _signUp.currentState!;
    if(formData.validate()) {
      formData.save();
      var user = {"name" : _nameController.text, "email": _emailController.text, "password": _passwordController.text};
      userController.signUp(user);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 25.0, right: 25.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'sign_up_now'.tr, fontSize: 34.0, fontWeight: FontWeight.bold,),
                    SizedBox(height: 5.0),
                    CustomText(text: 'sign_up_subtitle'.tr, fontSize: 18.0, color: Colors.grey),
                  ],
                ),
              ),
              Form(
                key: _signUp,
                child: Column(
                  children: [
                    buildTextFormField('enter_fullname'.tr, false, _nameController, 'name'),
                    buildTextFormField('enter_email'.tr, false, _emailController, 'email'),
                    buildTextFormField('enter_password'.tr, true, _passwordController, 'password'),
                    buildTextFormField('enter_confirm_password'.tr, true, _confirmPasswordController, 'confirm password', passwordController: _passwordController),
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0, bottom: 16.0),
                      child: RaisedGradientButton(
                        child: userController.userSignUpLoading.value ? CircularProgressIndicator(strokeWidth: 3) : CustomText(text: 'sign_up'.tr, color: Colors.white),
                        gradient: LinearGradient(
                          colors: userController.userSignUpLoading.value ? <Color>[Color(0xFFebeef4), Color(0xFFebeef4)] : <Color>[Color(0xFFfa578e), Color(0xFFfda28e)],
                        ),
                        onPressed: userController.userSignUpLoading.value ? null : () =>  signUp()
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: 'have_account'.tr, color: Colors.grey),
                          SizedBox(width: 12.0),
                          InkWell(
                            onTap: () => Get.to(Login()),
                            child: CustomText(text: 'login'.tr, color: Colors.red)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}