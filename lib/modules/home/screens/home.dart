import 'package:flutter/material.dart';
import 'package:qrcode_app/constants.dart';
import 'package:qrcode_app/modules/qr_scanner/screens/qr_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: const TabBar(indicatorWeight: 0.01, tabs: [
            Tab(text: 'Qr Scanner'),
            Tab(text: 'Qr Generator'),
          ]),
        ),
        body: TabBarView(children: [
          QrScanner(width: width, height: height),
          const Center(
            child: Text('Qr Generator'),
          ),
        ]),
      ),
    );
  }
}
