import 'dart:core';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jms_tablet/features/catalogue/bloc/catalogue_bloc.dart';
import 'package:jms_tablet/features/catalogue/models/jewellery_stock_item_data.dart';
import '../../dashboard/screens/dashboard_page.dart';

class EstimateScreen extends StatefulWidget {
  const EstimateScreen({super.key});

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {

  late CatalogueBloc _bloc;
  late List<String> barcode = [];


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
        labourCharge = labourRate ;
        break;
      default:
        labourCharge = 0.0;
    }

    labourChargecontroller.text = labourCharge.toStringAsFixed(2);
  }

  void _calculateTotalPrice() {
    double metalValue = double.tryParse(metalValuecontroller.text.trim()) ?? 0.0;
    double labourCharge = double.tryParse(labourChargecontroller.text.trim()) ?? 0.0;
    double handlingCharges = double.tryParse(handlingChargeController.text.trim()) ?? 0.0;
    double otherCharges = double.tryParse(otherChargescontroller.text.trim()) ?? 0.0;
    double studdValue = double.tryParse(studdValuecontroller.text.trim()) ?? 0.0;

    double totalPrice = metalValue + labourCharge + handlingCharges + otherCharges + studdValue;

    totalpricecontroller.text = totalPrice.toStringAsFixed(2);
  }

  void _calculateGST() {
    // Get GST percentage
    double gstPercent = double.tryParse(gst1controller.text.trim()) ?? 3.0;

    // Get total price
    double totalPrice = double.tryParse(totalpricecontroller.text.trim()) ?? 0.0;

    // Calculate GST amount
    double gstAmount = totalPrice * (gstPercent / 100);

    // Update GST amount field
    gst2controller.text = gstAmount.toStringAsFixed(2);

    // Calculate sell price
    double sellPrice = totalPrice + gstAmount;
    sellpricecontroller.text = sellPrice.toStringAsFixed(2);
  }

  void _selectAllOnFocus(TextEditingController controller, FocusNode focusNode) {
    if (focusNode.hasFocus) {
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.text.length,
      );
    }
  }

  void _onBarcodeSelected(String? value){
    if (value == null || value.isEmpty) return;

    final bloc = context.read<CatalogueBloc>();
    JewelleryStockItemData foundItem = JewelleryStockItemData.empty();

    if (bloc.state is CatalogueLoaded) {
      final state = bloc.state as CatalogueLoaded;
      foundItem = state.items.firstWhere(
            (item) => item.itemTagNo == value,
        orElse: () => JewelleryStockItemData.empty(),
      );
      var selectedItem = state.items.firstWhere(
              (item) => item.itemTagNo == value,
          orElse: () => JewelleryStockItemData.empty()
      );
      setState(() {
        selectedBarcode = value;
        selectedItem = foundItem;
        designNoController.text = selectedItem.itemDesignNo ?? "";
        categoryController.text = selectedItem.itemCategory ?? "";
        itemDescriptionController.text = selectedItem.itemDescription ?? "";
        purity1controller.text = "${selectedItem.itemPurity?.toStringAsFixed(2) ?? "0.00"}";
        purity2controller.text ="${selectedItem.itemTouch?.toStringAsFixed(2) ?? "0.00"}";
        quantitycontroller.text = "${selectedItem.itemQuantity?.toString() ?? "0"}";
        gwtcontroller.text = "${selectedItem.itemGrossWeight?.toStringAsFixed(3) ?? "0.000"}";
        nwtcontroller.text = "${selectedItem.itemNetWeight?.toStringAsFixed(3) ?? "0.000"}";
        metalRatecontroller.text = "${selectedItem.itemMRate?.toStringAsFixed(2) ?? "0.00"}";
        final mrOn = selectedItem.itemMrOn;
        final lrOn = selectedItem.itemLrOn;
        mRateOncontroller.text = mrOn ?? "NET";
        metalRateOnValue = mrOn == "GROSS" ? "GROSS" : "NET";
        labourrateoncontroller.text = lrOn ?? "GROSS";
        labourRateOnValue = lrOn == "NET"
            ? "NET"
            : lrOn == "PC"
            ? "PC"
            : "GROSS";
        metalValuecontroller.text = "${selectedItem.itemMValue?.toStringAsFixed(2) ?? "0.00"}";
        labopurratecontroller.text = "${selectedItem.itemLRate?.toStringAsFixed(2) ?? "0.00"}";
        handlingChargeController.text ="${selectedItem.itemHChgs?.toStringAsFixed(2) ?? "0.00"}";
        labourChargecontroller.text ="${selectedItem.itemLCharges?.toStringAsFixed(2) ?? "0.00"}";
        otherChargescontroller.text ="${selectedItem.itemOCharges?.toStringAsFixed(2) ?? "0.00"}";
        studdValuecontroller.text = "${selectedItem.itemStudValue?.toStringAsFixed(2) ?? "0.00"}";
        gst1controller.text = "${selectedItem.itemGSTPcnt?.toStringAsFixed(2) ?? "3.00"}";
        gst2controller.text ="${selectedItem.itemGSTAmt?.toStringAsFixed(2) ?? "0.00"}";
        totalpricecontroller.text = "${selectedItem.itemSPrice?.toStringAsFixed(2) ?? "0.00"}";

        if (foundItem == JewelleryStockItemData.empty()){
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CatalogueBloc>(context);
    if (bloc.state is CatalogueLoaded) {
      final state = bloc.state as CatalogueLoaded;
      barcode = state.items
          .map((item) => item.itemTagNo?? "")
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
                                            .where((item) => item.itemTagNo != null && item.itemTagNo!.isNotEmpty)
                                            .map((item) => item.itemTagNo!)
                                            .toList();
                                      }

                                      return SearchableDropdown(
                                        label: "BARCODE",
                                        selectedValue: selectedBarcode,
                                        items: barcodes.isNotEmpty ? barcodes : ["No barcode found"],
                                        onChanged: (val) => _onBarcodeSelected(val),
                                        width: MediaQuery.of(context).size.width * 0.300,
                                      );
                                    },
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
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
                              height: MediaQuery.of(context).size.height * 0.04,
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
                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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

                                // keyboardType: TextInputType.number,
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

                                // keyboardType: TextInputType.number,
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

                                // keyboardType: TextInputType.number,
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
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:  buildDropdown<String>(
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
                                // keyboardType: TextInputType.number,
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

                                // keyboardType: TextInputType.number,
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
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:  buildDropdown<String>(
                                label: "LABOUR RATE-ON",
                                value: labourRateOnValue,
                                items: ["NET", "GROSS", "PC"],
                                onChanged: (val) {
                                  setState(() {
                                    labourRateOnValue = val;
                                    labourrateoncontroller.text = val ?? "GROSS";
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

                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'LABOUR CHARGEs',
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

                                // keyboardType: TextInputType.number,
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

                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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
                                // keyboardType: TextInputType.number,
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
                    rows: (selectedItem?.subItems?.isNotEmpty ?? false)
                        ? selectedItem!.subItems!.map((packet) {
                      final amount = (packet.packetQuantity ?? 0) * (packet.packetRate ?? 0.0);
                      return DataRow(cells: [
                        DataCell(Text(packet.packetDescription ?? packet.packetType ?? 'N/A')),
                        DataCell(Text(packet.packetRateOn ?? 'N/A')),
                        DataCell(Text('${packet.packetQuantity}')),
                        DataCell(Text(packet.packetWeight?.toStringAsFixed(3) ?? '0.000')),
                        DataCell(Text(packet.packetRate?.toStringAsFixed(2) ?? '0.00')),
                        DataCell(Text(amount.toStringAsFixed(2))),
                      ]);
                    }).toList()
                        : [
                      DataRow(cells: [
                        DataCell(Text("No sub-items found", style: TextStyle(color: Colors.grey))),
                        DataCell(Text("")),
                        DataCell(Text("")),
                        DataCell(Text("")),
                        DataCell(Text("")),
                        DataCell(Text("")),
                      ]),
                    ],),
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
                        onTap: () {},
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

