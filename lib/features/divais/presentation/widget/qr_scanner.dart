import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatelessWidget {
  final void Function(String result) onDetect;
  const QrScanner({super.key, required this.onDetect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "Pindai QR Code"),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final value = capture.barcodes.firstOrNull?.rawValue;
          if (value != null && value.isNotEmpty) {
            onDetect(value);
          }
        },
      ),
    );
  }
}
