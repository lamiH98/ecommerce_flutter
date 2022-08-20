import 'package:ecommerce/screens/auth/widgets/validInput.dart';
import 'package:ecommerce/screens/widgets/decoration_functions.dart';
import 'package:flutter/material.dart';

buildTextFormField(String labelText, bool password, TextEditingController controller, String type, {passwordController}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextFormField(
      controller: controller,
      decoration: authInputDecoration(labelText: labelText),
      obscureText: password,
      autocorrect: false,
      keyboardType: type == 'email' ? TextInputType.emailAddress : TextInputType.text,
      validator: (value) {
        if(type == 'name') {
          return validInput(value!, 32, 4, type); 
        } else if(type == 'email') {
          return validInput(value!, 32, 4, type); 
        } else if(type == 'password') {
          return validInput(value!, 32, 6, type); 
        } else if(type == 'confirm password') {
          return validInput(value!, 32, 6, type, passwordController: passwordController); 
        } else if(type == 'city') {
          return validInput(value!, 32, 2, type);
        } else if(type == 'neighourhood') {
          return validInput(value!, 32, 2, type); 
        } else if(type == 'street') {
          return validInput(value!, 32, 2, type); 
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    ),
  );
}