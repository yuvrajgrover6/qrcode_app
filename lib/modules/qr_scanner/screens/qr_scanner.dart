import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_app/constants.dart';

class QrScanner extends StatelessWidget {
  const QrScanner({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController =
        MobileScannerController(facing: CameraFacing.back);

    return Stack(
      children: [
        MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                Get.defaultDialog(title: 'Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                Get.defaultDialog(title: 'Barcode', content: Text(code));
              }
            }),
        Positioned(
          left: width * 0.5 - 100,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            width: width * 0.5,
            height: height * 0.075,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Color.fromARGB(59, 76, 175, 79),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state as CameraFacing) {
                        case CameraFacing.front:
                          return const Icon(
                            Icons.camera_front,
                            color: kIconColor,
                          );
                        case CameraFacing.back:
                          return const Icon(
                            Icons.camera_rear,
                            color: kIconColor,
                          );
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.switchCamera(),
                ),
                IconButton(
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state as TorchState) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off, color: kIconColor);
                        case TorchState.on:
                          return const Icon(Icons.flash_on,
                              color: Colors.yellow);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.toggleTorch(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
