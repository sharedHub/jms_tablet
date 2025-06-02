import 'dart:core';
import 'dart:io';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jms_tablet/features/catalogue/bloc/catalogue_bloc.dart';
import 'package:jms_tablet/features/catalogue/models/jewellery_stock_item_data.dart';
import '../../../shared/widgets/pdf_viewer.dart';
import '../../dashboard/screens/dashboard_page.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EstimateScreen extends StatefulWidget {
  const EstimateScreen({super.key});

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  late CatalogueBloc _bloc;
  late List<String> barcode = [];

  JewelleryStockItemData? _editedItem;
  List<Map<String, dynamic>>? _editedSubItems;

  String? selectedBarcode;

  final purity1controller = TextEditingController();
  final designNoController = TextEditingController();
  final categoryController = TextEditingController();
  final itemDescriptionController = TextEditingController();
  final purity2controller = TextEditingController();
  final quantitycontroller = TextEditingController();
  final gwtcontroller = TextEditingController();
  final nwtcontroller = TextEditingController();
  final metalRatecontroller = TextEditingController();
  final mRateOncontroller = TextEditingController();
  final metalValuecontroller = TextEditingController();
  final labopurratecontroller = TextEditingController();
  final labourrateoncontroller = TextEditingController();
  final handlingChargeController = TextEditingController();
  final labourChargecontroller = TextEditingController();
  final otherChargescontroller = TextEditingController();
  final studdValuecontroller = TextEditingController();
  final gst1controller = TextEditingController();
  final gst2controller = TextEditingController();
  final totalpricecontroller = TextEditingController();
  final sellpricecontroller = TextEditingController();
  String? selectedOptionPreset;
  String? selectedOptionBarcode;
  String? selectedOptionDesignNo;
  String? selectedOptionCategory;
  String? selectedOptionItemDescription;
  JewelleryStockItemData? selectedItem;
  String? metalRateOnValue;
  String? labourRateOnValue;
  // Table Field Controllers
  final packetLotDescriptionController = TextEditingController();
  final packetrateOnController = TextEditingController();
  final packetpcsController = TextEditingController();
  final packetWeightController = TextEditingController();
  final packetRateController = TextEditingController();
  final packetAmountController = TextEditingController();

// Focus Nodes for Table Fields
  final packetlotDescriptionFocus = FocusNode();
  final packetRateOnFocus = FocusNode();
  final packetPcsFocus = FocusNode();
  final packetWeightFocus = FocusNode();
  final packettRateFocus = FocusNode();
  final packetAmountFocus = FocusNode();

  final designNoFocus = FocusNode();
  final categoryFocus = FocusNode();
  final itemDescriptionFocus = FocusNode();
  final purity1Focus = FocusNode();
  final purity2Focus = FocusNode();
  final quantityFocus = FocusNode();
  final gwtFocus = FocusNode();
  final nwtFocus = FocusNode();
  final metalRateFocus = FocusNode();
  final mRateOnFocus = FocusNode();
  final metalValueFocus = FocusNode();
  final labopurrateFocus = FocusNode();
  final labourrateonFocus = FocusNode();
  final handlingChargeFocus = FocusNode();
  final labourChargeFocus = FocusNode();
  final otherChargesFocus = FocusNode();
  final studdValueFocus = FocusNode();
  final gst1Focus = FocusNode();
  final gst2Focus = FocusNode();
  final totalpriceFocus = FocusNode();
  final sellpriceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<CatalogueBloc>();

    metalRateOnValue = "NET";
    labourRateOnValue = "GROSS";

    // Sync text fields with dropdowns
    mRateOncontroller.text = metalRateOnValue!;
    labourrateoncontroller.text = labourRateOnValue!;

    void addListener(TextEditingController controller, Function() callback) {
      controller.addListener(callback);
    }

    void addListener2(TextEditingController controller) {
      controller.addListener(_calculateTotalPrice);
    }

    void addGSTListener(TextEditingController controller) {
      controller.addListener(_calculateGST);
    }

    addGSTListener(gst1controller);
    addGSTListener(totalpricecontroller);

    addListener2(metalValuecontroller);
    addListener2(labourChargecontroller);
    addListener2(handlingChargeController);
    addListener2(otherChargescontroller);
    addListener2(studdValuecontroller);

    // Metal Value Listeners
    addListener(metalRatecontroller, _calculateMetalValue);
    addListener(gwtcontroller, _calculateMetalValue);
    addListener(nwtcontroller, _calculateMetalValue);
    addListener(mRateOncontroller, _calculateMetalValue);

    // Labour Charge Listeners
    addListener(labopurratecontroller, _calculateLabourCharge);
    addListener(gwtcontroller, _calculateLabourCharge);
    addListener(nwtcontroller, _calculateLabourCharge);
    addListener(quantitycontroller, _calculateLabourCharge);
    addListener(labourrateoncontroller, _calculateLabourCharge);

    void addFocusListener(FocusNode node, TextEditingController controller) {
      node.addListener(() {
        _selectAllOnFocus(controller, node);
      });
    }

    addFocusListener(designNoFocus, designNoController);
    addFocusListener(categoryFocus, categoryController);
    addFocusListener(itemDescriptionFocus, itemDescriptionController);
    addFocusListener(purity1Focus, purity1controller);
    addFocusListener(purity2Focus, purity2controller);
    addFocusListener(quantityFocus, quantitycontroller);
    addFocusListener(gwtFocus, gwtcontroller);
    addFocusListener(nwtFocus, nwtcontroller);
    addFocusListener(metalRateFocus, metalRatecontroller);
    addFocusListener(mRateOnFocus, mRateOncontroller);
    addFocusListener(metalValueFocus, metalValuecontroller);
    addFocusListener(labopurrateFocus, labopurratecontroller);
    addFocusListener(labourrateonFocus, labourrateoncontroller);
    addFocusListener(handlingChargeFocus, handlingChargeController);
    addFocusListener(labourChargeFocus, labourChargecontroller);
    addFocusListener(otherChargesFocus, otherChargescontroller);
    addFocusListener(studdValueFocus, studdValuecontroller);
    addFocusListener(gst1Focus, gst1controller);
    addFocusListener(gst2Focus, gst2controller);
    addFocusListener(totalpriceFocus, totalpricecontroller);
    addFocusListener(sellpriceFocus, sellpricecontroller);
    addFocusListener(packetAmountFocus, packetAmountController);
    addFocusListener(packetlotDescriptionFocus, packetLotDescriptionController);
    addFocusListener(packetPcsFocus, packetpcsController);
    addFocusListener(packetRateOnFocus, packetrateOnController);
    addFocusListener(packettRateFocus, packetRateController);
    addFocusListener(packetWeightFocus, packetWeightController);
  }

  Future<pw.Font> loadCustomFont() async {
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> loadCustomRobotoCondensedFontBold() async {
    final fontData =
        await rootBundle.load('assets/fonts/RobotoCondensed-Bold.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> loadCustomRobotoCondensedSemiBold() async {
    final fontData =
        await rootBundle.load('assets/fonts/RobotoCondensed-SemiBold.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> loadCustomRobotoCondensedFontMedium() async {
    final fontData =
        await rootBundle.load('assets/fonts/RobotoCondensed-Medium.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> loadCustomRobotoCondensedFontlight() async {
    final fontData =
        await rootBundle.load('assets/fonts/RobotoCondensed-Light.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<Uint8List> loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  bool checkNullorZero(dynamic value) {
    if (value == null) return true;

    if (value == 0) return true;

    return false;
  }

  bool stringIsNullCheck(String? value) {
    if (checkNullorZero(value)) {
      return true;
    }
    String checkingvalue = value!.toUpperCase();
    String nullString = null.toString().toUpperCase();

    return checkingvalue == nullString;
  }

  Future<Uint8List> generatePDFTwo(JewelleryStockItemData selectedItemData,
      String image, double gst, double fprice) async {
    final pdf = pw.Document();
    // final customFontbold = await loadCustomRobotoCondensedFontBold();
    // final customLightFont = await loadCustomRobotoCondensedFontMedium();

    Uint8List itemImageBytes = Uint8List(0);

    if (image.isNotEmpty) {
      if (await File(image).exists()) {
        final imageFile = File(image);
        itemImageBytes = await imageFile.readAsBytes();
      }
    }

    final textstyle = pw.TextStyle(
      fontSize: 8,
      color: PdfColors.black,
    );

    final barcodetextstyle = pw.TextStyle(fontSize: 10, color: PdfColors.black);

    final valuetextstyle = pw.TextStyle(fontSize: 8, color: PdfColors.black);

    // final tableRowStyle =
    //     pw.TextStyle(fontSize: 7, color: PdfColors.black, font: customFont);
    List<List> dataList = [];

    for (int i = 0; i < selectedItemData.subItems!.length; i++) {
      var row = [];
      final subitem = selectedItemData.subItems![i];
      final sublot = subitem.packetInitial ?? "";
      final qty = subitem.packetQuantity != null && subitem.packetQuantity != 0
          ? subitem.packetQuantity.toString()
          : "";
      final weight = subitem.packetWeight != null && subitem.packetWeight != 0
          ? subitem.packetWeight!.toStringAsFixed(3)
          : "";
      final rate = subitem.packetSRate != null && subitem.packetSRate != 0
          ? subitem.packetSRate!.toStringAsFixed(2)
          : "";
      final value = subitem.packetSValue != null && subitem.packetSValue != 0
          ? subitem.packetSValue!.toStringAsFixed(2)
          : "";
      row.addAll([sublot, qty, weight, rate, value]);
      dataList.add(row);
    }

    pdf.addPage(pw.MultiPage(
        margin: const pw.EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
        ),
        pageFormat: PdfPageFormat.a6,
        build: (context) {
          return [
            pw.Container(
                height: 398,
                width: 300,
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 1, color: PdfColors.black),
                    borderRadius: pw.BorderRadius.circular(5)),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Text("ROUGH ESTIMATE ONLY",
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 10),
                      pw.Container(
                          // color: PdfColors.blue,
                          width: 260,
                          child: pw.Row(children: [
                            pw.Container(
                                // color: PdfColors.amber,
                                height: (398 * (1 / 4)),
                                child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                        color: PdfColors.white,
                                        border: pw.Border.all(
                                          width: 1,
                                          color: PdfColors.black,
                                        ),
                                        borderRadius:
                                            pw.BorderRadius.circular(10)),
                                    width: 100,
                                    height: (398 * (1 / 4)),
                                    child: pw.ClipRRect(
                                        horizontalRadius: 9,
                                        verticalRadius: 9,
                                        child: itemImageBytes.isNotEmpty
                                            ? pw.Image(
                                                fit: pw.BoxFit.cover,
                                                pw.MemoryImage(itemImageBytes),
                                              )
                                            : pw.Center(
                                                child: pw.Text(
                                                    "No Image".toUpperCase(),
                                                    style: pw.TextStyle(
                                                        fontSize: 8,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .bold))))),
                                width: 120),
                            pw.Container(
                                // color: PdfColors.yellow,
                                padding: const pw.EdgeInsets.only(left: 5),
                                child: pw.Column(children: [
                                  pw.SizedBox(height: 3),
                                  pw.Align(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Text(
                                          "${selectedItemData.itemTagNo} / ${selectedItemData.itemDesignNo}",
                                          style: pw.TextStyle(
                                            fontSize: 12,
                                            color: PdfColors.black,
                                          ))),
                                  pw.SizedBox(height: 3),
                                  pw.Align(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Text(
                                          "DESCRIPTION  :  ${stringIsNullCheck(selectedItemData.itemDescription) ? "" : selectedItemData.itemDescription}",
                                          style: textstyle)),
                                  pw.Container(
                                      // color: PdfColors.yellow,
                                      width: 140,
                                      child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                                // color: PdfColors.blue,
                                                // height: 10,
                                                child: pw.Column(children: [
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        width: 32,
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              pw.Text("PURITY",
                                                                  style:
                                                                      textstyle),
                                                              pw.Spacer(),
                                                              pw.Text(":",
                                                                  style:
                                                                      textstyle)
                                                            ])),
                                                    pw.Container(
                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemPurity !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemPurity !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemPurity!
                                                                    .toStringAsFixed(
                                                                        2)
                                                                : "",
                                                            style:
                                                                valuetextstyle)),
                                                  ]),
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        width: 32,
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              pw.Text("GROSS",
                                                                  style:
                                                                      textstyle),
                                                              pw.Spacer(),
                                                              pw.Text(":",
                                                                  style:
                                                                      textstyle)
                                                            ])),
                                                    pw.Container(
                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemGrossWeight !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemGrossWeight !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemGrossWeight!
                                                                    .toStringAsFixed(
                                                                        3)
                                                                : "",
                                                            style:
                                                                valuetextstyle)),
                                                  ]),
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        width: 32,
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              pw.Text("DIA PCS",
                                                                  style:
                                                                      textstyle),
                                                              pw.Spacer(),
                                                              pw.Text(":",
                                                                  style:
                                                                      textstyle)
                                                            ])),
                                                    pw.Container(
                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemDPcs !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemDPcs !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemDPcs
                                                                    .toString()
                                                                : "",
                                                            style:
                                                                valuetextstyle)),
                                                  ]),
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        width: 32,
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              pw.Text("CLS PCS",
                                                                  style:
                                                                      textstyle),
                                                              pw.Spacer(),
                                                              pw.Text(":",
                                                                  style:
                                                                      textstyle)
                                                            ])),
                                                    pw.Container(
                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemDPcs !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemCPcs !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemCPcs
                                                                    .toString()
                                                                : "",
                                                            style:
                                                                valuetextstyle)),
                                                  ])
                                                ]),
                                                width: 65),
                                            pw.Container(
                                                // color: PdfColors.green,

                                                child: pw.Column(children: [
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        // color: PdfColors.orange,
                                                        width: 35,
                                                        alignment: pw.Alignment
                                                            .centerLeft,
                                                        child:
                                                            pw.Row(children: [
                                                          pw.Text("TOUCH",
                                                              style: textstyle),
                                                          pw.Spacer(),
                                                          pw.Text(":",
                                                              style: textstyle)
                                                        ])),
                                                    pw.Container(
                                                        // color: PdfColors.blue,

                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemTouch !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemTouch !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemTouch!
                                                                    .toStringAsFixed(
                                                                        2)
                                                                : "",
                                                            style:
                                                                valuetextstyle))
                                                  ]),
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        // color: PdfColors.orange,
                                                        width: 35,
                                                        alignment: pw.Alignment
                                                            .centerLeft,
                                                        child:
                                                            pw.Row(children: [
                                                          pw.Text("NET",
                                                              style: textstyle),
                                                          pw.Spacer(),
                                                          pw.Text(":",
                                                              style: textstyle)
                                                        ])),
                                                    pw.Container(
                                                        // color: PdfColors.blue,

                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemNetWeight !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemNetWeight !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemNetWeight!
                                                                    .toStringAsFixed(
                                                                        3)
                                                                : "",
                                                            style:
                                                                valuetextstyle))
                                                  ]),
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        // color: PdfColors.orange,
                                                        width: 35,
                                                        alignment: pw.Alignment
                                                            .centerLeft,
                                                        child:
                                                            pw.Row(children: [
                                                          pw.Text("DIA WT",
                                                              style: textstyle),
                                                          pw.Spacer(),
                                                          pw.Text(":",
                                                              style: textstyle)
                                                        ])),
                                                    pw.Container(
                                                        // color: PdfColors.blue,

                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemDWeight !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemDWeight !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemDWeight!
                                                                    .toStringAsFixed(
                                                                        3)
                                                                : "",
                                                            style:
                                                                valuetextstyle))
                                                  ]),
                                                  pw.SizedBox(height: 3),
                                                  pw.Row(children: [
                                                    pw.Container(
                                                        // color: PdfColors.orange,
                                                        alignment: pw.Alignment
                                                            .centerLeft,
                                                        width: 35,
                                                        child:
                                                            pw.Row(children: [
                                                          pw.Text("CLS WT",
                                                              style: textstyle),
                                                          pw.Spacer(),
                                                          pw.Text(":",
                                                              style: textstyle)
                                                        ])),
                                                    pw.Container(
                                                        // color: PdfColors.blue,

                                                        alignment: pw.Alignment
                                                            .centerRight,
                                                        width: 30,
                                                        child: pw.Text(
                                                            selectedItemData.itemCWeight !=
                                                                        null &&
                                                                    selectedItemData
                                                                            .itemCWeight !=
                                                                        0
                                                                ? selectedItemData
                                                                    .itemCWeight!
                                                                    .toStringAsFixed(
                                                                        2)
                                                                : "",
                                                            style:
                                                                valuetextstyle))
                                                  ]),
                                                ]),
                                                width: 65)
                                          ])),
                                ]),
                                height: (398 * (1 / 4)),
                                width: 140)
                          ])),
                      pw.SizedBox(height: 10),
                      pw.Container(
                          width: 260,
                          height: 400,
                          // color: PdfColors.green,
                          child: pw.TableHelper.fromTextArray(
                              border: const pw.TableBorder(
                                  left: pw.BorderSide.none,
                                  right: pw.BorderSide.none,
                                  top: pw.BorderSide.none,
                                  bottom: pw.BorderSide.none),
                              columnWidths: {
                                1: const pw.FixedColumnWidth(30),
                                2: const pw.FixedColumnWidth(30)
                              },
                              headerAlignments: {
                                0: pw.Alignment.centerLeft,
                                3: pw.Alignment.centerRight,
                                4: pw.Alignment.centerRight
                              },
                              cellAlignments: {
                                0: pw.Alignment.centerLeft,
                                1: pw.Alignment.center,
                                2: pw.Alignment.center,
                                3: pw.Alignment.centerRight,
                                4: pw.Alignment.centerRight
                              },
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              headers: [
                                "STUDED LOT",
                                "QTY",
                                "WEIGHT",
                                "RATE",
                                "VALUE"
                              ],
                              headerStyle: pw.TextStyle(
                                fontSize: 7,
                                color: PdfColors.white,
                              ),
                              headerHeight: 5,
                              cellStyle: textstyle,
                              headerPadding: const pw.EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              headerDecoration: pw.BoxDecoration(
                                  color: PdfColor.fromHex("#2E3A59")),
                              data: dataList)),
                      pw.Spacer(),
                      pw.Container(width: 250, child: pw.Divider()),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 50,
                              height: 50,
                              padding: const pw.EdgeInsets.only(left: 10),
                            ),
                            pw.Container(
                                padding: const pw.EdgeInsets.only(right: 10),
                                child: pw.Column(children: [

                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Container(
                                            // color: PdfColors.orange,
                                            width: 80,
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.Row(children: [
                                              pw.SizedBox(width: 3),
                                              pw.Text("LABOUR CHARGES",
                                                  style: textstyle),
                                              pw.Spacer(),
                                              pw.Text(":", style: textstyle)
                                            ])),
                                        pw.Container(
                                            // color: PdfColors.blue,

                                            alignment: pw.Alignment.centerRight,
                                            width: 40,
                                            child: pw.Text(
                                                selectedItemData.itemSLabour !=
                                                            null &&
                                                        selectedItemData
                                                                .itemSLabour !=
                                                            0
                                                    ? selectedItemData
                                                        .itemSLabour!
                                                        .toStringAsFixed(2)
                                                    : "",
                                                style: valuetextstyle))
                                      ]),
                                  pw.Row(children: [
                                    pw.Container(
                                        // color: PdfColors.orange,
                                        width: 70,
                                        alignment: pw.Alignment.centerRight,
                                        child: pw.Row(children: [
                                          pw.SizedBox(width: 3),
                                          pw.Text("OTHER CHARGES",
                                              style: textstyle),
                                          pw.Spacer(),
                                          pw.Text(":", style: textstyle)
                                        ])),
                                    pw.Container(
                                        // color: PdfColors.blue,

                                        alignment: pw.Alignment.centerRight,
                                        width: 40,
                                        child: pw.Text(
                                            selectedItemData.itemSOChgs !=
                                                        null &&
                                                    selectedItemData
                                                            .itemSOChgs !=
                                                        0
                                                ? selectedItemData.itemSOChgs!
                                                    .toStringAsFixed(2)
                                                : "",
                                            style: valuetextstyle))
                                  ]),
                                  pw.Row(
                                      crossAxisAlignment:
                                      pw.CrossAxisAlignment.end,
                                      children: [
                                        pw.Container(
                                          // color: PdfColors.orange,
                                            width: 80,
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.Row(
                                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                                children: [
                                              pw.SizedBox(width: 3),
                                              pw.Text("GST",
                                                  style: textstyle),
                                              // pw.Spacer(),
                                              pw.Text(":", style: textstyle)
                                            ])),
                                        pw.Container(
                                          // color: PdfColors.blue,

                                            alignment: pw.Alignment.centerRight,
                                            width: 40,
                                            child: pw.Text(
                                                gst !=
                                                        0
                                                    ? gst!
                                                    .toStringAsFixed(2)
                                                    : "",
                                                style: valuetextstyle))
                                      ]),
                                  pw.SizedBox(height: 5),
                                  pw.Container(
                                      margin: const pw.EdgeInsets.only(left: 2),
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 2),
                                      constraints: const pw.BoxConstraints(
                                          minWidth: 110),
                                      decoration: pw.BoxDecoration(
                                          color: PdfColor.fromHex('#E4E4E4'),
                                          border: pw.Border.all(
                                            width: 1,
                                            color: PdfColors.black,
                                          ),
                                          borderRadius:
                                              pw.BorderRadius.circular(2)),
                                      child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text("SELL PRICE :",
                                                  style: pw.TextStyle(
                                                    fontSize: 10,
                                                    color: PdfColors.black,
                                                  )),
                                            ),
                                            fprice == 0
                                                ? pw.Text("",
                                                    style: pw.TextStyle(
                                                      fontSize: 15,
                                                      color: PdfColors.black,
                                                    ))
                                                : pw.Text(
                                                    fprice != null
                                                        ? fprice!
                                                            .toStringAsFixed(2)
                                                        : "",
                                                    style: valuetextstyle)
                                          ]))
                                ]))
                          ]),
                      pw.SizedBox(height: 10)
                    ]))
          ];
        }));

    // Save PDF
    return await pdf.save();
  }

  void _calculateMetalValue() {
    final String? rateOn = mRateOncontroller.text.trim().toLowerCase();
    final String metalRateText = metalRatecontroller.text.trim();
    final String grossWeightText = gwtcontroller.text.trim();
    final String netWeightText = nwtcontroller.text.trim();

    double metalRate = double.tryParse(metalRateText) ?? 0.0;
    double grossWeight = double.tryParse(grossWeightText) ?? 0.0;
    double netWeight = double.tryParse(netWeightText) ?? 0.0;

    double metalValue = 0.0;

    if (rateOn == "net") {
      metalValue = metalRate * netWeight;
    } else if (rateOn == "gross") {
      metalValue = metalRate * grossWeight;
    }

    metalValuecontroller.text = metalValue.toStringAsFixed(2);
  }

  void _calculateLabourCharge() {
    final String? rateOn = labourrateoncontroller.text.trim().toLowerCase();
    final String labourRateText = labopurratecontroller.text.trim();
    final String grossWeightText = gwtcontroller.text.trim();
    final String netWeightText = nwtcontroller.text.trim();
    final String quantityText = quantitycontroller.text.trim();

    double labourRate = double.tryParse(labourRateText) ?? 0.0;
    double grossWeight = double.tryParse(grossWeightText) ?? 0.0;
    double netWeight = double.tryParse(netWeightText) ?? 0.0;
    int quantity = int.tryParse(quantityText) ?? 0;

    double labourCharge = 0.0;

    switch (rateOn) {
      case "net":
        labourCharge = labourRate * netWeight;
        break;
      case "gross":
        labourCharge = labourRate * grossWeight;
        break;
      case "pc":
        labourCharge = labourRate;
        break;
      default:
        labourCharge = 0.0;
    }

    labourChargecontroller.text = labourCharge.toStringAsFixed(2);
  }

  void _calculateStuddValue() {
    if (selectedItem == null || selectedItem!.subItems == null) {
      studdValuecontroller.text = "0.00";
      return;
    }

    double totalAmount = 0.0;

    for (var packet in selectedItem!.subItems!) {
      final quantity = packet.packetQuantity ?? 0;
      final rate = packet.packetRate ?? 0.0;
      totalAmount += quantity * rate;
    }

    studdValuecontroller.text = totalAmount.toStringAsFixed(2);
  }

  void _calculateTotalPrice() {
    double metalValue =
        double.tryParse(metalValuecontroller.text.trim()) ?? 0.0;
    double labourCharge =
        double.tryParse(labourChargecontroller.text.trim()) ?? 0.0;
    double handlingCharges =
        double.tryParse(handlingChargeController.text.trim()) ?? 0.0;
    double otherCharges =
        double.tryParse(otherChargescontroller.text.trim()) ?? 0.0;
    double studdValue =
        double.tryParse(studdValuecontroller.text.trim()) ?? 0.0;

    double totalPrice =
        metalValue + labourCharge + handlingCharges + otherCharges + studdValue;

    totalpricecontroller.text = totalPrice.toStringAsFixed(2);
  }

  void _calculateGST() {
    // Get GST percentage
    double gstPercent = double.tryParse(gst1controller.text.trim()) ?? 3.0;

    // Get total price
    double totalPrice =
        double.tryParse(totalpricecontroller.text.trim()) ?? 0.0;

    // Calculate GST amount
    double gstAmount = totalPrice * (gstPercent / 100);

    // Update GST amount field
    gst2controller.text = gstAmount.toStringAsFixed(2);

    // Calculate sell price
    double sellPrice = totalPrice + gstAmount;
    sellpricecontroller.text = sellPrice.toStringAsFixed(2);
  }

  void _selectAllOnFocus(
      TextEditingController controller, FocusNode focusNode) {
    if (focusNode.hasFocus) {
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.text.length,
      );
    }
  }

  void _onBarcodeSelected(String? value) {
    if (value == null || value.isEmpty) return;
    final bloc = context.read<CatalogueBloc>();
    JewelleryStockItemData foundItem = JewelleryStockItemData.empty();
    if (bloc.state is CatalogueLoaded) {
      final state = bloc.state as CatalogueLoaded;
      foundItem = state.items.firstWhere(
        (item) => item.itemTagNo == value,
        orElse: () => JewelleryStockItemData.empty(),
      );

      setState(() {
        selectedBarcode = value;
        selectedItem = foundItem;
        _editedItem = foundItem;

        // Set main form fields
        designNoController.text = selectedItem!.itemDesignNo ?? "";
        categoryController.text = selectedItem!.itemCategory ?? "";
        itemDescriptionController.text = selectedItem!.itemDescription ?? "";
        purity1controller.text =
            "${selectedItem!.itemPurity?.toStringAsFixed(2) ?? "0.00"}";
        purity2controller.text =
            "${selectedItem!.itemTouch?.toStringAsFixed(2) ?? "0.00"}";
        quantitycontroller.text =
            "${selectedItem!.itemQuantity?.toString() ?? "0"}";
        gwtcontroller.text =
            "${selectedItem!.itemGrossWeight?.toStringAsFixed(3) ?? "0.000"}";
        nwtcontroller.text =
            "${selectedItem!.itemNetWeight?.toStringAsFixed(3) ?? "0.000"}";
        metalRatecontroller.text =
            "${selectedItem!.itemMRate?.toStringAsFixed(2) ?? "0.00"}";

        final mrOn = selectedItem!.itemMrOn;
        final lrOn = selectedItem!.itemLrOn;
        mRateOncontroller.text = mrOn ?? "NET";
        metalRateOnValue = mrOn == "GROSS" ? "GROSS" : "NET";
        labourrateoncontroller.text = lrOn ?? "GROSS";
        labourRateOnValue = lrOn == "NET"
            ? "NET"
            : lrOn == "PC"
                ? "PC"
                : "GROSS";
        metalValuecontroller.text =
            "${selectedItem!.itemMValue?.toStringAsFixed(2) ?? "0.00"}";
        labopurratecontroller.text =
            "${selectedItem!.itemLRate?.toStringAsFixed(2) ?? "0.00"}";
        handlingChargeController.text =
            "${selectedItem!.itemHChgs?.toStringAsFixed(2) ?? "0.00"}";
        labourChargecontroller.text =
            "${selectedItem!.itemLCharges?.toStringAsFixed(2) ?? "0.00"}";
        otherChargescontroller.text =
            "${selectedItem!.itemOCharges?.toStringAsFixed(2) ?? "0.00"}";
        studdValuecontroller.text =
            "${selectedItem!.itemStudValue?.toStringAsFixed(2) ?? "0.00"}";
        gst1controller.text =
            "${selectedItem!.itemGSTPcnt?.toStringAsFixed(3) ?? "3.000"}";
        gst2controller.text =
            "${selectedItem!.itemGSTAmt?.toStringAsFixed(2) ?? "0.00"}";
        totalpricecontroller.text =
            "${selectedItem!.itemSPrice?.toStringAsFixed(2) ?? "0.00"}";

        // Initialize _editedSubItems with controllers
        if (foundItem.subItems != null && foundItem.subItems!.isNotEmpty) {
          _editedSubItems = foundItem.subItems!.map((packet) {
            final rateCtrl = TextEditingController(
                text: "${packet.packetRate?.toStringAsFixed(2)}");
            final descCtrl =
                TextEditingController(text: packet.packetDescription ?? "");
            final rateOnCtrl =
                TextEditingController(text: packet.packetRateOn ?? "");

            return {
              "descriptionController": descCtrl,
              "rateOnController": rateOnCtrl,
              "quantity": packet.packetQuantity ?? 0,
              "weight": packet.packetWeight ?? 0.0,
              "rateController": rateCtrl,
              "amount":
                  ((packet.packetQuantity ?? 0) * (packet.packetRate ?? 0.0))
                      .toStringAsFixed(2),
              "descFocus": FocusNode(),
              "rateOnFocus": FocusNode(),
              "pcsFocus": FocusNode(),
              "weightFocus": FocusNode(),
              "rateFocus": FocusNode(),
              "amountFocus": FocusNode(),
            };
          }).toList();
        } else {
          _editedSubItems = [];
        }

        _calculateStuddValue(); // 👈 Calculate Studd Value

        if (foundItem == JewelleryStockItemData.empty()) {
          designNoController.clear();
          categoryController.clear();
          itemDescriptionController.clear();
          purity1controller.clear();
          purity2controller.clear();
          quantitycontroller.clear();
          gwtcontroller.clear();
          nwtcontroller.clear();
          metalRatecontroller.clear();
          mRateOncontroller.clear();
          metalValuecontroller.clear();
          labopurratecontroller.clear();
          labourrateoncontroller.clear();
          handlingChargeController.clear();
          labourChargecontroller.clear();
          otherChargescontroller.clear();
          studdValuecontroller.clear();
          gst1controller.clear();
          gst2controller.clear();
          totalpricecontroller.clear();
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  void _updateEditedItemFields() {
    if (_editedItem == null) return;

    double? parseDouble(String? value) =>
        value != null && value.isNotEmpty ? double.tryParse(value) : null;

    int? parseInt(String? value) =>
        value != null && value.isNotEmpty ? int.tryParse(value) : null;

    _editedItem = _editedItem!.copyWith(
      itemDescription: itemDescriptionController.text.isEmpty
          ? null
          : itemDescriptionController.text,
      itemGrossWeight: parseDouble(gwtcontroller.text),
      itemNetWeight: parseDouble(nwtcontroller.text),
      itemMRate: parseDouble(metalRatecontroller.text),
      itemMrOn: mRateOncontroller.text,
      itemLCharges: parseDouble(labourChargecontroller.text),
      itemSPrice: parseDouble(totalpricecontroller.text),
      itemGSTPcnt: parseDouble(gst1controller.text),
      subItems: _editedItem!.subItems, // ✅ Explicitly keep subItems
    );
    setState(() {
      _editedItem = _editedItem!.copyWith(
        itemDescription: itemDescriptionController.text.isEmpty
            ? null
            : itemDescriptionController.text,
        itemGrossWeight: parseDouble(gwtcontroller.text),
        itemNetWeight: parseDouble(nwtcontroller.text),
        itemMRate: parseDouble(metalRatecontroller.text),
        itemMrOn: mRateOncontroller.text,
        itemLCharges: parseDouble(labourChargecontroller.text),
        itemSPrice: parseDouble(totalpricecontroller.text),
        itemGSTPcnt: parseDouble(gst1controller.text),
        subItems: _editedItem!.subItems, // ✅ Explicitly keep subItems
      );
      selectedItem = _editedItem; // 👈 Sync selectedItem with edited one
    });
  }

  void _updateSubItemRateOnFromController(Map<String, dynamic> row) {
    final String newValue = row["rateOnController"].text;
    setState(() {
      row["rateOnController"].text = newValue;
      _calculateStuddValue();
    });
  }

  void _updateSubItemRateFromController(Map<String, dynamic> row) {
    final double newRate = double.tryParse(row["rateController"].text) ?? 0.0;
    final int quantity = row["quantity"];
    final double amount = quantity * newRate;

    setState(() {
      row["rateController"].text = newRate.toStringAsFixed(2);
      row["amount"] = amount.toStringAsFixed(2);
      _calculateStuddValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CatalogueBloc>(context);
    if (bloc.state is CatalogueLoaded) {
      final state = bloc.state as CatalogueLoaded;
      barcode = state.items
          .map((item) => item.itemTagNo ?? "")
          .where((barcode) => barcode.isNotEmpty)
          .toList();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardPage()),
                          );
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                    SizedBox(width: 15),
                    Text(
                      'JEWELLERY ESTIMATE',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.2), // Drop shadow color
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(2, 4), // Shadow position
                      ),
                    ],
                    border: Border.all(
                      color: Color(0xFF979DA3), // Stroke color
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: Image.asset(
                      'assets/images/new_image_jewellery.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                // fields
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            buildDropdown<String>(
                              label: "PRESET FILE",
                              value: selectedOptionPreset,
                              items: ["One", "Two", "Three"],
                              onChanged: (val) {
                                setState(() {
                                  selectedOptionPreset = val;
                                });
                              },
                              width: MediaQuery.of(context).size.width * 0.31,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            // Barcode Dropdown
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.31,
                              child: Row(
                                children: [
                                  BlocBuilder<CatalogueBloc, CatalogueState>(
                                    builder: (context, state) {
                                      List<String> barcodes = [];
                                      if (state is CatalogueLoaded) {
                                        barcodes = state.items
                                            .where((item) =>
                                                item.itemTagNo != null &&
                                                item.itemTagNo!.isNotEmpty)
                                            .map((item) => item.itemTagNo!)
                                            .toList();
                                      }

                                      return SearchableDropdown(
                                        label: "BARCODE",
                                        selectedValue: selectedBarcode,
                                        items: barcodes.isNotEmpty
                                            ? barcodes
                                            : ["No barcode found"],
                                        onChanged: (val) =>
                                            _onBarcodeSelected(val),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.300,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: designNoController,
                                focusNode: designNoFocus,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'DESIGN NO',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: categoryController,
                                focusNode: categoryFocus,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'CATEGORY',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: TextFormField(
                                controller: itemDescriptionController,
                                focusNode: itemDescriptionFocus,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ITEM DESCRIPTION',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: purity1controller,
                                textAlign: TextAlign.right,
                                focusNode: purity1Focus,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'PURITY',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: purity2controller,
                                textAlign: TextAlign.right,
                                focusNode: purity2Focus,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: quantitycontroller,
                                textAlign: TextAlign.right,
                                focusNode: quantityFocus,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'QUANTITY',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: gwtcontroller,
                                focusNode: gwtFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'GROSS WT',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: nwtcontroller,
                                focusNode: nwtFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'NET WT',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: metalRatecontroller,
                                focusNode: metalRateFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'METAL RATE',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height:
                                  MediaQuery.of(context).size.height * 0.046,
                              child: buildDropdown<String>(
                                label: "METAL RATE-ON",
                                value: metalRateOnValue,
                                items: ["NET", "GROSS"],
                                onChanged: (val) {
                                  setState(() {
                                    metalRateOnValue = val;
                                    mRateOncontroller.text = val ?? "NET";
                                    _calculateMetalValue();
                                  });
                                },
                                width: MediaQuery.of(context).size.width * 0.31,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: metalValuecontroller,
                                textAlign: TextAlign.right,
                                focusNode: metalValueFocus,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'METAL VALUE',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: labopurratecontroller,
                                focusNode: labopurrateFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'LABOUR RATE',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height:
                                  MediaQuery.of(context).size.height * 0.047,
                              child: buildDropdown<String>(
                                label: "LABOUR RATE-ON",
                                value: labourRateOnValue,
                                items: ["NET", "GROSS", "PC"],
                                onChanged: (val) {
                                  setState(() {
                                    labourRateOnValue = val;
                                    labourrateoncontroller.text =
                                        val ?? "GROSS";
                                    _calculateLabourCharge(); // 🔥 Trigger recalculate
                                  });
                                },
                                width: MediaQuery.of(context).size.width * 0.31,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: labourChargecontroller,
                                focusNode: labourChargeFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'LABOUR CHARGES',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: handlingChargeController,
                                focusNode: handlingChargeFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'HANDLING CHARGES',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: otherChargescontroller,
                                focusNode: otherChargesFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'OTHER CHARGES',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: studdValuecontroller,
                                focusNode: studdValueFocus,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  labelText: 'STUDD VALUE',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: totalpricecontroller,
                                focusNode: totalpriceFocus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'TOTAL PRICE',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                controller: gst1controller,
                                focusNode: gst1Focus,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'GST',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller: gst2controller,
                                focusNode: gst2Focus,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller: sellpricecontroller,
                                focusNode: sellpriceFocus,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'SELL PRICE',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                // table
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF7FF), // Fill color
                    border: Border.all(
                      color: const Color(0xFF9AAFC2), // Stroke color
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8), // Circular radius
                  ),
                  padding: EdgeInsets.all(8),
                  child: DataTable2(
                    headingRowColor:
                        MaterialStateProperty.all(const Color(0xFF366BAF)),
                    headingTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    columnSpacing: 8,
                    horizontalMargin: 12,
                    dividerThickness: 1,
                    dataRowColor: MaterialStateProperty.all(Colors.white),
                    dataTextStyle: const TextStyle(color: Colors.black),
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    columns: [
                      DataColumn2(
                        label: Text('LOT DESCRIPTION'),
                      ),
                      DataColumn2(
                        label: Text('RATE-ON'),
                        fixedWidth: MediaQuery.of(context).size.width * 0.12,
                      ),
                      DataColumn2(
                        label: Text('PCS'),
                        numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.12,
                      ),
                      DataColumn2(
                        label: Text('WEIGHT'),
                        numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.15,
                      ),
                      DataColumn2(
                        label: Text('RATE'),
                        numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.15,
                      ),
                      DataColumn2(
                        label: Text('AMOUNT'),
                        numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ],

                    rows: (_editedSubItems != null &&
                            _editedSubItems!.isNotEmpty)
                        ? _editedSubItems!.map((row) {
                            return DataRow(cells: [
                              DataCell(
                                TextFormField(
                                  readOnly: true,
                                  controller: row["descriptionController"]
                                      as TextEditingController?,
                                  focusNode: row["descFocus"] as FocusNode?,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              DataCell(
                                TextFormField(
                                  controller: row["rateOnController"]
                                      as TextEditingController?,
                                  focusNode: row["rateOnFocus"] as FocusNode?,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  onChanged: (_) =>
                                      _updateSubItemRateOnFromController(row),
                                ),
                              ),
                              DataCell(Text("${row['quantity']}")),
                              DataCell(Text(
                                  "${double.tryParse(row['weight'].toString())?.toStringAsFixed(3) ?? '0.000'}")),
                              DataCell(
                                TextFormField(
                                  controller: row["rateController"]
                                      as TextEditingController?,
                                  focusNode: row["rateFocus"] as FocusNode?,
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  onChanged: (_) =>
                                      _updateSubItemRateFromController(row),
                                ),
                              ),
                              DataCell(Text("${row['amount']}")),
                            ]);
                          }).toList()
                        : [
                            DataRow(cells: [
                              DataCell(Text("No sub-items found",
                                  style: TextStyle(color: Colors.grey))),
                              DataCell(Text("")),
                              DataCell(Text("")),
                              DataCell(Text("")),
                              DataCell(Text("")),
                              DataCell(Text("")),
                            ]),
                          ],
                    // rows: (selectedItem?.subItems != null && selectedItem!.subItems!.isNotEmpty)
                    //     ? selectedItem!.subItems!.map((packet) {
                    //         final amount = (packet.packetQuantity ?? 0) *
                    //             (packet.packetRate ?? 0.0);
                    //         return DataRow(cells: [
                    //           DataCell(Text(packet.packetDescription ??
                    //               packet.packetType ??
                    //               'N/A')),
                    //           DataCell(Text(packet.packetRateOn ?? 'N/A')),
                    //           DataCell(Text('${packet.packetQuantity}')),
                    //           DataCell(Text(
                    //               packet.packetWeight?.toStringAsFixed(3) ??
                    //                   '0.000')),
                    //           DataCell(Text(
                    //               packet.packetRate?.toStringAsFixed(2) ??
                    //                   '0.00')),
                    //           DataCell(Text(amount.toStringAsFixed(2))),
                    //         ]);
                    //       }).toList()
                    //     : [
                    //         DataRow(cells: [
                    //           DataCell(Text("No sub-items found",
                    //               style: TextStyle(color: Colors.grey))),
                    //           DataCell(Text("")),
                    //           DataCell(Text("")),
                    //           DataCell(Text("")),
                    //           DataCell(Text("")),
                    //           DataCell(Text("")),
                    //         ]),
                    //
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                // bottom buttons
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          _updateEditedItemFields();

                          if (_editedItem != null) {
                            final pdfData = await generatePDFTwo(
                                _editedItem!,
                                "",
                                double.tryParse(gst2controller.text) ?? 0.0,
                                double.tryParse(sellpricecontroller.text) ??
                                    0.0);

                            debugPrint("item data: ${_editedItem?.toJson()}");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFMemoryViewer(pdfData: pdfData),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0F2128), Color(0xFF2445B1)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(
                                color: const Color(0xFF7497E5), width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'PRINT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Color(0xff0F2128),
                            border: Border.all(
                                color: const Color(0xFF5174CF), width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: MediaQuery.of(context).size.height * 0.04,
      child: DropdownButtonFormField<T>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
      ),
    );
  }
}

class SearchableDropdown extends StatefulWidget {
  final String? label;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final double? width;

  const SearchableDropdown({
    Key? key,
    this.label,
    this.selectedValue,
    required this.items,
    this.onChanged,
    this.width,
  }) : super(key: key);

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredItems = [];
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    if (widget.selectedValue != null) {
      _controller.text = widget.selectedValue!;
    }

    // Remove auto-open on focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _closeDropdown();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _closeDropdown();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    _updateOverlay();
  }

  void _openDropdown() {
    if (_isOpen) return;
    _isOpen = true;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    if (!_isOpen) return;
    _isOpen = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    if (_isOpen) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _filteredItems.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No items found'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return InkWell(
                          onTap: () {
                            _controller.text = item;
                            widget.onChanged?.call(item);
                            _closeDropdown();
                            _focusNode.unfocus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(item),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: widget.width,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {
                if (_isOpen) {
                  _closeDropdown();
                } else {
                  _openDropdown();
                }
              },
            ),
          ),
          onChanged: _filterItems,
          // Remove onTap to prevent auto-opening
        ),
      ),
    );
  }
}
