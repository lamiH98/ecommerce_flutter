import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/auth/googleSignInApi.dart';
import 'package:ecommerce/screens/auth/sign_up.dart';
import 'package:ecommerce/screens/widgets/custom_raised_gradient_button.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> _login = GlobalKey<FormState>();
  final UserController userController = UserController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var myToken;

  login() {
    var formData = _login.currentState!;
    if(formData.validate()) {
      formData.save();
      var user = {"email": _emailController.text, "password": _passwordController.text};
      userController.login(user);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 28.0, left: 25.0, right: 25.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'welcome'.tr, fontSize: 34.0, fontWeight: FontWeight.bold,),
                    CustomText(text: 'sign_in_title'.tr, fontSize: 24.0, color: Colors.grey),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Form(
                    key: _login,
                    child: Column(
                      children: [
                        buildTextFormField('enter_email'.tr, false, _emailController, 'email'),
                        buildTextFormField('enter_password'.tr, true, _passwordController, 'password'),
                        InkWell(
                          onTap: () => Get.toNamed('/forgotPassword'),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: CustomText(text: 'forgot_password'.tr, fontSize: 14.0)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                          child: RaisedGradientButton(
                            child: userController.userLoginLoading.value ? CircularProgressIndicator(strokeWidth: 3) : CustomText(text: 'login'.tr, color: Colors.white),
                            gradient: LinearGradient(
                              colors: userController.userLoginLoading.value ? <Color>[Color(0xFFebeef4), Color(0xFFebeef4)] : <Color>[Color(0xFFfa578e), Color(0xFFfda28e)],
                            ),
                            onPressed: userController.userLoginLoading.value ? null : () =>  login(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(text: 'new_account'.tr, color: Colors.grey),
                              SizedBox(width: 12.0),
                              InkWell(
                                onTap: () => Get.to(SignUp()),
                                child: CustomText(text: 'sign_up'.tr, color: Colors.red)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          );
      }),
    );
  }
}