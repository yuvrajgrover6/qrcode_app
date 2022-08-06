import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrcode_app/constants.dart';
import 'package:qrcode_app/modules/history/controller/history_controller.dart';
import 'package:qrcode_app/modules/qr_scanner/model/qr_snapshot.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.create(() => HistoryController(), permanent: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<HistoryController>(builder: (controller) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: controller.deleteAllQRSnapshot,
            child: Icon(Icons.delete_sweep),
            backgroundColor: kPrimaryColor,
          ),
          body: FutureBuilder<Map<dynamic, QRSnapshot>>(
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
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          final qrSnapshot =
                              snapshot.data!.values.toList()[index];
                          return ExpansionTile(
                            title: Text(qrSnapshot.value),
                            subtitle: Text(DateFormat("dd-MM-yy HH::mm::ss")
                                .format(qrSnapshot.time)),
                            trailing: IconButton(
                                onPressed: () => controller.deleteQRSnapshot(
                                    snapshot.data!.keys.toList()[index]),
                                icon: Icon(Icons.delete)),
                            children: [
                              ListTile(
                                title: Text(qrSnapshot.value),
                                horizontalTitleGap: 0,
                              )
                            ],
                          );
                        }));
                  } else {
                    return const Center(
                        child: Text(
                      "There is no previous activity",
                      style: TextStyle(fontSize: 20),
                    ));
                  }
                } else {
                  return const Center(
                      child: Text(
                    "There was problem fetching your history",
                    style: TextStyle(fontSize: 20),
                  ));
                }
              })));
    });
  }
}
