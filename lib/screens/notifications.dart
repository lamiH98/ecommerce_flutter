import 'package:ecommerce/api.dart';
import 'package:ecommerce/controllers/notification.dart';
import 'package:ecommerce/controllers/userController.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_image.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notifications extends StatefulWidget{

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final UserController userController = Get.find();
  final NotificationController notificationController = Get.put(NotificationController());

  @override
  void initState() {
    print("===================> ${userController.userData.value.email} <===================");
    notificationController.fetchNotification(userController.userData.value.id);
    super.initState();
  }

  final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 26.0, bottom: 8.0),
            child: Row(
              children: [
                Text('notifications'.tr, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                SizedBox(width: 6.0),
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Obx(() {
                      return Text(notificationController.notificationList.length.toString(), style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
                    })
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   height: 1.0,
          //   decoration: BoxDecoration(
          //     color: Colors.grey.withOpacity(0.3)
          //   ),
          // ),
          SizedBox(height: 8.0,),
          Obx(() {
            if(notificationController.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: notificationController.notificationList.length,
              itemBuilder: (BuildContext context, int item) {
                var notification = notificationController.notificationList[item];
                var createdAt = DateTime.parse(notification.createdAt.toString());
                return Column(
                  children: [
                    ListTile(
                      leading: cachedNetworkImage('$image_api${notification.image}', context, 80.0, width: 80.0),
                      // leading: CustomText(text: 'Image'),
                      trailing: CustomText(text: timeago.format(createdAt, locale: 'en_short'), fontSize: 15.0, color: Colors.grey),
                      title: ContainerLang(
                        child: CustomTextLang(text: notification.title, textAR: notification.titleAr,)
                      ),
                    ),
                    Container(
                      height: 1.0,
                      margin: const EdgeInsets.only(left: 14.0, right: 14.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2)
                      ),
                    ),
                  ],
                );
              }
            );
          }),
        ]
      ),
    );
  }
}