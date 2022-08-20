import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_change/status_change.dart';

class Tracking extends StatefulWidget {

  final order;
  Tracking({this.order});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {

  int get deliveryStatus => int.parse(widget.order.deliveryStatus);

  Color getColor(int index) {
    if (index == deliveryStatus) {
      return inProgressColor;
    } else if (index < deliveryStatus) {
      return mainColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Order Status", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: Colors.black
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: CustomText(text: 'your_order_code'.tr + '${widget.order.id}'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0),
            child: Row(
              children: [
                CustomText(text: '${widget.order.products.length}' + 'items'.tr, fontSize: 15.0),
                SizedBox(width: 8.0),
                CustomText(text: '-'),
                SizedBox(width: 8.0),
                CustomText(text: '\$${widget.order.newTotal != 'no coupon' ? widget.order.newTotal : widget.order.total }', fontSize: 15.0)
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Container(
                child: StatusChange.tileBuilder(
                  theme: StatusChangeThemeData(
                    direction: Axis.vertical,
                    connectorTheme: ConnectorThemeData(space: 1.0, thickness: 1.0),
                  ),
                  builder: StatusChangeTileBuilder.connected(
                    itemWidth: (_) => MediaQuery.of(context).size.width / _processes.length,
                    // contentWidgetBuilder: (context, index) {
                    //   return Padding(
                    //     padding: const EdgeInsets.all(15.0),
                    //     child: CustomText(text: _processes[index]['subTitle'], fontSize: 13.0, color: getColor(index)),
                    //   );
                    // },
                    nameWidgetBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: _processes[index]['title'], fontWeight: FontWeight.bold, color: getColor(index)),
                              SizedBox(height: 4.0),
                              CustomText(text: _processes[index]['subTitle'], fontSize: 13.0, color: getColor(index)),
                            ],
                          ),
                      );
                    },
                    indicatorWidgetBuilder: (_, index) {
                      if (index <= deliveryStatus) {
                        return DotIndicator(
                          size: 24.0,
                          border: Border.all(color: mainColor, width: 1),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: mainColor,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return OutlinedDotIndicator(
                          size: 18,
                          borderWidth: 1.0,
                          color: todoColor,
                        );
                      }
                    },
                    lineWidgetBuilder: (index) {
                      if (index > 0) {
                        if (index == deliveryStatus) {
                          final prevColor = getColor(index - 1);
                          final color = getColor(index);
                          var gradientColors;
                          gradientColors = [
                            prevColor,
                            Color.lerp(prevColor, color, 0.5)
                          ];
                          return DecoratedLineConnector(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: gradientColors,
                              ),
                            ),
                          );
                        } else {
                          return SolidLineConnector(
                            color: getColor(index),
                          );
                        }
                      } else {
                        return null;
                      }
                    },
                    itemCount: _processes.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _processes = [
  {
    'title': 'order_placed'.tr,
    'subTitle': 'subTitle_1'.tr
  },
  {
    'title': 'confirmed'.tr,
    'subTitle': 'subTitle_2'.tr
  },
  {
    'title': 'order_shipped'.tr,
    'subTitle': ''
  },
  {
    'title': 'out_for_delivery'.tr,
    'subTitle': ''
  },
  {
    'title': 'delivery'.tr,
    'subTitle': ''
  },
];