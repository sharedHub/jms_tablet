import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../catalogue/models/jewellery_stock_item_data.dart';
import 'barcode_widget.dart';
import 'number_to_word.dart';

class pageReceiptUi extends StatefulWidget {
  final JewelleryStockItemData item;

  const pageReceiptUi({super.key, required this.item});

  @override
  State<pageReceiptUi> createState() => _pageReceiptUiState();
}

class _pageReceiptUiState extends State<pageReceiptUi> {
  // Helper method: Number to Words
  String numberToWords(double number) {
    final formatter = NumberToWordsFormatter();
    int numInt = number.toInt();
    return "${formatter.convert(numInt)} Only";
  }

  double getTotalGrossWeight() {
    double total = widget.item.itemGrossWeight ?? 0.0;
    return total;
  }

  double getTotalNetWeight() {
    double total = widget.item.itemNetWeight ?? 0.0;
    if (widget.item.subItems != null && widget.item.subItems!.isNotEmpty) {
      total += widget.item.subItems!
          .map((p) => p.packetWeight ?? 0.0)
          .reduce((a, b) => a + b);
    }
    return total;
  }

  double getTotalLabourCharges() {
    return widget.item.itemLCharges ?? 0.0;
  }

  double getTotalAmount() {
    double mainAmount = widget.item.itemSPrice ?? 0.0;
    double packetsAmount = 0.0;
    if (widget.item.subItems != null && widget.item.subItems!.isNotEmpty) {
      packetsAmount = widget.item.subItems!
          .map((p) => (p.packetQuantity ?? 0) * (p.packetRate ?? 0.0))
          .reduce((a, b) => a + b);
    }
    return mainAmount + packetsAmount;
  }

  double getGSTPercentage() {
    return widget.item.itemGSTPcnt ?? 3.0;
  }

  double getCGSTAmount() {
    double total = getTotalAmount();
    double cgstPercent = getGSTPercentage() / 2;
    return total * (cgstPercent / 100);
  }

  double getSGSTAmount() {
    return getCGSTAmount();
  }

  double getGrandTotal() {
    return getTotalAmount() + getCGSTAmount() + getSGSTAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "ROUGH ESTIMATE ONLY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1
                            ),
                            Center(
                              child: BarcodeView(
                                tagNo: widget.item.itemTagNo ?? "",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),


              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              // headers
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "STUDDED LOT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "QTY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                      child: Text(
                        "WEIGHT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.16,
                      child: Text(
                        "RATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "VALUE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),

                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),

              // render sub items/packets dynamically
              if (widget.item.subItems != null &&
                  widget.item.subItems!.isNotEmpty)
                ...widget.item.subItems!.map((packet) {
                  final amount =
                      (packet.packetQuantity ?? 0) * (packet.packetRate ?? 0.0);
                  return SizedBox(
                    key: ValueKey(packet.packetId),
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // packet description
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            "${packet.packetInitial ?? packet.packetDescription}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            "${packet.packetQuantity}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        // net weight
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.14,
                          child: Text(
                            "${packet.packetWeight?.toStringAsFixed(3)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        // rate
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: Text(
                            "${packet.packetRate?.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        // amount = rate * weight
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            "${amount.toStringAsFixed(2)}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()
              else
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Text("No components found"),
                ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Colors.black,
              ),
              Divider(color: Colors.black, thickness: 2),

              // CGST
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "LABOUR CHARGES: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "${getCGSTAmount().toStringAsFixed(2)}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "OTHER CHARGES: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "${getCGSTAmount().toStringAsFixed(2)}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: Colors.black, thickness: 2),

              // GRAND TOTAL
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "SELLING PRICE: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "${getGrandTotal().toStringAsFixed(2)}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}