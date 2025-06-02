import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../catalogue/models/jewellery_stock_item_data.dart';
import 'barcode_widget.dart';
import 'number_to_word.dart';

class ReceiptUi extends StatefulWidget {
  final JewelleryStockItemData item;

  const ReceiptUi({super.key, required this.item});

  @override
  State<ReceiptUi> createState() => _ReceiptUiState();
}

class _ReceiptUiState extends State<ReceiptUi> {
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

  String getTodayDate() {
    final now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
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
                            "ESTIMATE",
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
              Row(
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Center(
                        child: Text(
                          "DATE: ${getTodayDate()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                              MediaQuery.of(context).size.width * 0.02),
                        )),
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
                        "DESCRIPTION",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "GR. WT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "NET WT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
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
                        "LAB ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "AMOUNT",
                        textAlign: TextAlign.right,
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
              // item details
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // item description will be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        widget.item.itemDescription ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    // item gross weight
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "${widget.item.itemGrossWeight?.toStringAsFixed(3)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    // item net weight
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "${widget.item.itemNetWeight?.toStringAsFixed(3)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    // rate
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "${widget.item.itemMRate?.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    // labour charges
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "${widget.item.itemLCharges?.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    // amount = sell price
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "${widget.item.itemSPrice?.toStringAsFixed(2)}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                  ],
                ),
              ),

              // render sub items/packets dynamically
              if (widget.item.subItems != null &&
                  widget.item.subItems!.isNotEmpty)
                ...widget.item.subItems!.map((packet) {
                  final amount =
                      (packet.packetQuantity ?? 0) * (packet.packetRate ?? 0.0);
                  return SizedBox(
                    key: ValueKey(packet.packetId),
                    height: MediaQuery.of(context).size.height * 0.05,
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
                        // empty for gross wt
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        // net weight
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
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
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            "${packet.packetRate?.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        // SPcnt -> Labour %
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            "",
                            // "${packet.packetSPcnt?.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.014),
                          ),
                        ),
                        // amount = rate * weight
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.22,
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

              // TOTAL ROW
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "TOTAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "${getTotalGrossWeight().toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "${getTotalNetWeight().toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "${getTotalLabourCharges().toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "${getTotalAmount().toStringAsFixed(2)}",
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

              // CGST
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "CGST",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "@${(getGSTPercentage() / 2).toStringAsFixed(2)}%",
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

              // SGST
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "SGST",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "@${(getGSTPercentage() / 2).toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "${getSGSTAmount().toStringAsFixed(2)}",
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.014),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "GRAND TOTAL",
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
              Divider(color: Colors.black, thickness: 2),

              // FINAL AMOUNT IN WORDS
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    Text("Amt in Words: ",  maxLines: 2,  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.02,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text(
                      numberToWords(getGrandTotal()),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // USER & SALESPERSON
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "USER   : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "KESRI",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Text(
                        "SALESPERSON   : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "BHAVISHA V",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "E. & O.E",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SIGN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}