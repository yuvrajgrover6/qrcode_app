import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode_app/constants.dart';
import 'package:qrcode_app/modules/home/screens/home.dart';
import 'package:qrcode_app/localDBController.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;
Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: 'ca-app-pub-2232158818732423/9926859581',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('ad loader');
          openAd = ad;
          openAd!.show();
        },
        onAdFailedToLoad: (error) {
          print('ad load failer $error');
        },
      ),
      orientation: AppOpenAd.orientationPortrait);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Get.putAsync(() async {
    final controller = LocalDBController();
    await controller.intializeLocalDB();
    return controller;
  }, permanent: true);
  await loadAd();
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
        fontFamily: 'SignikaNegative',
        primarySwatch: kPrimaryColor,
        primaryColor: kPrimaryColor,
      ),
      home: const HomeScreen(),
    );
  }
}
