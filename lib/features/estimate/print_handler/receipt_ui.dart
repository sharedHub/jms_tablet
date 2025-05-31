import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ReceiptUi extends StatefulWidget {
  const ReceiptUi({super.key});

  @override
  State<ReceiptUi> createState() => _ReceiptUiState();
}

class _ReceiptUiState extends State<ReceiptUi> {
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Center(
                      child: Text(
                        "ESTIMATE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "INV NO.: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.02,
                              ),
                            )),
                        Text(
                          "DJ / 1792 ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Center(
                        child: Text(
                      "DATE: 19/02/2005",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
),
                    )),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "NAME   : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "HEMINA JITENDRA PATIL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
),
                      ))
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
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "GR. WT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "NET WT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "RATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "LAB ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "AMOUNT",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
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
                        "itemDescription",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // item gross weight to be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "2.11",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // item net weight to be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "10.11",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // item rate is going to be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "110000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // item labour charges will be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "1200",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // total amount (that is itemsprcie) will be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "123456",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                  ],
                ),
              ),

              // packets details (it can be more than one row)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // packet description will be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "itemDescription",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // there is no gross weight for packets so they will be empty
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // packet weight to be printed here (under net weight)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "10.11",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // packet rate is going to be printed here
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "110000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // there is no labour charges for packets so they will be empty
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "1200",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // packetrate * packet weight should come
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "123456",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                  ],
                ),
              ),

              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Colors.black,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapRadius: 0.0,
              ),

              // this (item details and packet details section will be repeated if multiple items got printed else only 1
              // for now i am putting only 1 item and 1 packet and moving to total

              Divider(
                color: Colors.black,
                thickness: 2,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child:
                          // DEFAULT VALUE
                          Text(
                        "TOTAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // TOTAL OF GROSS WT
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "12.34",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // TOTAL OF NET WT
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "12.34",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // empty
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // total of labour rate/charges
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "12345 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // total of all amount
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "1234567",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                color: Colors.black,
                thickness: 2,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // default value
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "CGST",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // FETCH FROM MODEL IF NOT THERE THEN DIVIDE GST BY 2 AND STORE THE VALUE IN CGST AND SGST
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "@1.5%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // AMOUNT OF CGST ON TOTAL AMOUNT (OR SIMPLY GST AMOUNT BY 2)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "1234567",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // default value
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "SGST",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // FETCH FROM MODEL IF NOT THERE THEN DIVIDE GST BY 2 AND STORE THE VALUE IN CGST AND SGST
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "@1.5%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // AMOUNT OF CGST ON TOTAL AMOUNT (OR SIMPLY GST AMOUNT BY 2)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "1234567",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                color: Colors.black,
                thickness: 2,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // default value
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "TOTAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                    // TOTAL AMOUNT + BOTH GST
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "12,34,567",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.014,

),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                color: Colors.black,
                thickness: 2,
              ),


              // final amount (last one) to be printed in text
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text("Twelve Lacs Thirty Four Thousand Three Hundred and Sixty Seven", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontWeight: FontWeight.bold
                ),),
              ),

              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        "USER   : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "KESRI",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
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
                          fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "BHAVISHA V",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ))
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "E. & O.E",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SIGN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.02,
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
