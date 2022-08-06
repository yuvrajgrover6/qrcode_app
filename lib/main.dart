import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode_app/modules/home/screens/home.dart';
import 'package:qrcode_app/localDBController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async {
    final controller = LocalDBController();
    await controller.intializeLocalDB();
    return controller;
  }, permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
