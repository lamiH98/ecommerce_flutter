import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPlaced extends StatefulWidget {

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(child: Icon(Icons.check, color: mainColor, size: 40.0)),
                  ),
                  SizedBox(height: 16.0),
                  Text('order_placed!'.tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20.0)),
                  SizedBox(height: 16.0),
                  Text('order_successfully'.tr, style: TextStyle(color: Colors.white, fontSize: 17.0)),
                  Text('order_check_delivery'.tr, style: TextStyle(color: Colors.white, fontSize: 17.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}