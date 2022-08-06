import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_app/localDBController.dart';
import 'package:qrcode_app/modules/qr_scanner/model/qr_snapshot.dart';

class HistoryController extends GetxController {
  Box get qrHistoryDB => LocalDBController.instance.qrHistoryDB;

  late Future<List<QRSnapshot>> qrSnapshotHistory;

  HistoryController() {
    qrSnapshotHistory = getQrHistory();
  }

  Future<List<QRSnapshot>> getQrHistory() async {
    return qrHistoryDB.toMap().values.map((element) {
      return QRSnapshot.fromMap(element);
    }).toList();
  }
}
