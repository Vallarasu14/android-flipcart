import 'package:flutter/material.dart';

class Payment_Page extends StatefulWidget {
  const Payment_Page({Key? key}) : super(key: key);

  @override
  _Payment_PageState createState() => _Payment_PageState();
}

class _Payment_PageState extends State<Payment_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
      ),
    );
  }
}
