import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/auth/googleSignInApi.dart';
import 'package:ecommerce/screens/widgets/custom_raised_gradient_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  GlobalKey<FormState> _login = GlobalKey<FormState>();
  final UserController userController = UserController();
  TextEditingController _emailController = TextEditingController();

  var myToken;

  login() {
    var formData = _login.currentState!;
    if(formData.validate()) {
      formData.save();
      var email = {"email": _emailController.text};
      userController.forgotPassword(email);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 6.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back)
                  ),
                  CustomText(text: 'forgot_password'.tr, fontSize: 22.0, fontWeight: FontWeight.bold,),
                ],
              ),
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 18.0, right: 18.0),
              child: Form(
                key: _login,
                child: Column(
                  children: [
                    buildTextFormField('enter_email'.tr, false, _emailController, 'email'),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 16.0),
                      child: RaisedGradientButton(
                        child: userController.userLoginLoading.value ? CircularProgressIndicator(strokeWidth: 3) : CustomText(text: 'send'.tr, color: Colors.white),
                        gradient: LinearGradient(
                          colors: userController.userLoginLoading.value ? <Color>[Color(0xFFebeef4), Color(0xFFebeef4)] : <Color>[Color(0xFFfa578e), Color(0xFFfda28e)],
                        ),
                        onPressed: userController.userLoginLoading.value ? null : () =>  login(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}