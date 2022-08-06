import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode_app/modules/history/controller/history_controller.dart';
import 'package:qrcode_app/modules/qr_scanner/model/qr_snapshot.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HistoryController>(
        init: Get.put(HistoryController()),
        builder: (controller) {
          return FutureBuilder<List<QRSnapshot>>(
              future: controller.qrSnapshotHistory,
              builder: ((context, AsyncSnapshot<List<QRSnapshot>> snapshot) {
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
                            title: Text(snapshot.data![index].value),
                            subtitle:
                                Text(snapshot.data![index].time.toString()),
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
