import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_app/localDBController.dart';
import 'package:qrcode_app/modules/qr_scanner/model/qr_snapshot.dart';

class QRController extends GetxController {
  Box get qrHistoryDB => LocalDBController.instance.qrHistoryDB;
  onResult(String value, String caption) async {
    await qrHistoryDB.add(QRSnapshot(DateTime.now(), value, caption).toMap());
  }
}
