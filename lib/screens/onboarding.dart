import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget{

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>{

  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/onboarding/$assetName.png', width: 200.0),
      alignment: Alignment.bottomCenter,
    );
  }

  void done() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('initScreen', 0);
    String? token = prefs.getString('token');
    if(token == null) {
      Get.to(Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0,color: Colors.grey);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "",
          body: "body_1".tr,
          image: _buildImage('onborading_1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "body_2".tr,
          image: _buildImage('onborading_2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "body_3".tr,
          // bodyWidget: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text("Click on ", style: bodyStyle),
          //     Icon(Icons.edit),
          //     Text(" to edit a post", style: bodyStyle),
          //   ],
          // ),
          image: _buildImage('onborading_3'),
          decoration: pageDecoration,
        ),
      ],
      onDone: done,
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: CustomText(text: 'skip'.tr),
      next: const Icon(Icons.arrow_forward),
      done: CustomText(text: 'done'.tr, fontWeight: FontWeight.w600),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: mainColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
