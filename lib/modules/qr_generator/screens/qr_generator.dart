import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_app/constants.dart';

import '../controller/qr_generator.dart';

class QrGenerator extends StatelessWidget {
  final double width;
  final double height;
  const QrGenerator({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(QrGeneratorController());
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: height * 0.015),
          Text(
            'Generate Qr Code Here',
            style: TextStyle(fontSize: width * 0.08),
          ),
          SizedBox(height: height * 0.015),
          Text(
            'With few Steps',
            style: TextStyle(fontSize: width * 0.07),
          ),
          SizedBox(height: height * 0.05),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text('Steps:', style: TextStyle(fontSize: width * 0.07))),
          SizedBox(height: height * 0.015),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text('1. Enter Text',
                  style: TextStyle(fontSize: width * 0.07))),
          SizedBox(height: height * 0.015),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text('2. Generate Qr Code',
                  style: TextStyle(fontSize: width * 0.07))),
          SizedBox(height: height * 0.015),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text('3. Scan Qr Code',
                  style: TextStyle(fontSize: width * 0.07))),
          SizedBox(height: height * 0.07),
          SizedBox(
            width: width * 0.9,
            child: GetBuilder<QrGeneratorController>(builder: (controller) {
              return TextFormField(
                controller: controller.qrController,
                decoration: InputDecoration(
                  floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                  labelText: 'Enter Text or Url',
                  labelStyle: TextStyle(fontSize: width * 0.05),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(
                      width * 0.05,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(
                      width * 0.05,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(
                      width * 0.05,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: width * 0.05),
                maxLines: 5,
              );
            }),
          ),
          SizedBox(height: height * 0.07),
          GetBuilder<QrGeneratorController>(builder: (controller) {
            return Container(
              width: width * 0.7,
              height: height * 0.06,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
                child: Text(
                  'Generate Qr',
                  style: TextStyle(fontSize: width * 0.06),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Qr Code',
                    middleText: 'Qr Code',
                    middleTextStyle: TextStyle(fontSize: width * 0.05),
                    content: QrImage(
                      data: controller.qrController.text,
                      version: QrVersions.auto,
                      size: width * 0.8,
                    ),
                    actions: [
                      ElevatedButton(
                        child: const Text('Save to Gallery'),
                        onPressed: () {
                          controller.onSubmit();
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
