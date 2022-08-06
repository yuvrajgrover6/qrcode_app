import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_app/localDBController.dart';
import 'package:qrcode_app/modules/qr_scanner/model/qr_snapshot.dart';

class HistoryController extends GetxController {
  Box get qrHistoryDB => LocalDBController.instance.qrHistoryDB;

  late Future<Map<int, QRSnapshot>> qrSnapshotHistory;

  HistoryController() {
    qrSnapshotHistory = getQrHistory();
  }

  updateHistory() {
    qrSnapshotHistory = getQrHistory();
    update();
  }

  Future<Map<int, QRSnapshot>> getQrHistory() async {
    return qrHistoryDB.toMap().map((key, value) =>
        MapEntry(key, QRSnapshot.fromMap(Map<String, dynamic>.from(value))));
  }

  deleteQRSnapshot(key) async {
    await qrHistoryDB.delete(key);
    updateHistory();
  }

  deleteAllQRSnapshot() async {
    await qrHistoryDB.clear();
    updateHistory();
  }
}
