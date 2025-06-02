import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BarcodeView extends StatelessWidget {
  final String tagNo;

  const BarcodeView({Key? key, required this.tagNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: tagNo,
      width: 200,
      height: 50,
    );
  }
}
