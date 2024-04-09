import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrscanner = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(alignment: Alignment.center, children: <Widget>[
        QRView(
          key: qrscanner,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(),
        ),
        // Positioned(bottom: 10, child: Text(barcode !=null ? 'Result : ${barcode!.code}' :'scan a code',maxLines: 3,))
      ]),
    ));
  }
}

void onQRViewCreated(QRViewController controller) {}
