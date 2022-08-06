import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDBController extends GetxController {
  late Box qrHistoryDB;
  static LocalDBController instance = Get.find();
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> intializeLocalDB() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    qrHistoryDB = await Hive.openBox('qr_scanner_history');
  }
}
