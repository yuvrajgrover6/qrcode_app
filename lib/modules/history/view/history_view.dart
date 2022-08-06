import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrcode_app/modules/history/controller/history_controller.dart';
import 'package:qrcode_app/modules/qr_scanner/model/qr_snapshot.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.create(() => HistoryController(), permanent: false);
    return GetBuilder<HistoryController>(builder: (controller) {
      return FutureBuilder<Map<dynamic, QRSnapshot>>(
          future: controller.qrSnapshotHistory,
          builder:
              ((context, AsyncSnapshot<Map<dynamic, QRSnapshot>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data != null) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title:
                            Text(snapshot.data!.values.toList()[index].value),
                        subtitle: Text(DateFormat("dd-MM-yy HH::mm::ss").format(
                            snapshot.data!.values.toList()[index].time)),
                        trailing: IconButton(
                            onPressed: () => controller.deleteQRSnapshot(
                                snapshot.data!.keys.toList()[index]),
                            icon: Icon(Icons.delete)),
                      );
                    }));
              } else {
                return const Text("There is no previous activity");
              }
            } else {
              return const Text("There was problem fetching your history");
            }
          }));
    });
  }
}
