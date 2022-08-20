import 'package:ecommerce/controllers/languageController.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/favorite.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/notifications.dart';
import 'package:ecommerce/screens/profile.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/controllers/networkController.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectIndex = 0;
  List<Widget> widgetList = <Widget>[
    HomePage(),
    Favorite(),
    Notifications(),
    Profile(),
  ];

  final UserController userController = Get.find();
  final AppLanguage appLanguage = Get.put(AppLanguage());
  
  var messaging = FirebaseMessaging.instance;

  // If the application is opened from a terminated state (closed)
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Get.to(Home());
    }
  }

  requestPermssion() async {
    
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    requestPermssion();
    
    // If the application is opened from a terminated state
    setupInteractedMessage();

    // When the app is open
    FirebaseMessaging.onMessage.listen((event) {
      Get.snackbar(appLanguage.appLocale == 'ar' ? event.data['title_ar'] : event.notification!.title!, appLanguage.appLocale == 'ar' ? event.data['body_ar'] : event.notification!.body!, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(bottom: 14.0, right: 12, left: 12));
    });

    // If the application is opened from a background state.
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Get.to(Notifications());
    });

    super.initState();
  }

  final NetworkController networkController = Get.find();

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: widgetList.elementAt(_selectIndex),
      body: Obx(() {
        return networkController.connectionStatus.value == 1
        || networkController.connectionStatus.value == 2
        ? widgetList.elementAt(_selectIndex)
        : Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/signal_searching.png'),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: CustomText(text: 'no_connection'.tr, fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ],
        ));
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'favorite'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_rounded),
            label: 'notifications'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'account'.tr,
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectIndex,
        onTap: _onItemTap,
      ),
    );
  }
  
}