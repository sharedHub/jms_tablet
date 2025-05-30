import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'catalogue_page.dart';

class JewelleryDetailScreen extends StatelessWidget {
  const JewelleryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
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
                              builder: (context) => CataloguePage()),
                        );
                      },
                      child: Icon(Icons.arrow_back, color: Colors.black)),
                  SizedBox(width: 15),
                  Text(
                    'DETAILS',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Drop shadow color
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
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.630,
                          child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                        child: Text("SD321/SD010S", style: TextStyle(fontSize: 14, color: Color(0xff677D99)))
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Text("24 KT DIAMOND JEWELLERY", style: TextStyle(fontSize: 18, color: Color(0xff3B85E6)))
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        child: Text("₹ 999999999.99", style: TextStyle(fontSize: 14, color: Colors.black))
                                    ),
                                  ),
                                ],
                              ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *  0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *  0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("PURITY:")
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.08,
                                      child: Text("99.99")
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
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
                    headingRowColor: MaterialStateProperty.all(const Color(0xFF366BAF)),
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
                        fixedWidth: MediaQuery.of(context).size.width * 0.427,
                      ),
                      DataColumn2(
                        label: Text('PCS'),
                        numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.12,
                      ),
                      DataColumn2(
                        label: Text('WEIGHT'),
                        numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.18,
                      ),
                      DataColumn2(
                        label: Text('AMOUNT'),
                          numeric: true,
                        fixedWidth: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('Lot A')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Lot B with longer description')),
                        DataCell(Text('6')),
                        DataCell(Text('3.2kg')),
                        DataCell(Text('\$850')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Lot C')),
                        DataCell(Text('8')),
                        DataCell(Text('4.0kg')),
                        DataCell(Text('\$950')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Lot D')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Lot E')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Lot F')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]), DataRow(cells: [
                        DataCell(Text('Lot G')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]), DataRow(cells: [
                        DataCell(Text('Lot H')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]), DataRow(cells: [
                        DataCell(Text('Lot I')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Lot J')),
                        DataCell(Text('10')),
                        DataCell(Text('5.5kg')),
                        DataCell(Text('\$1200')),
                      ]),




                    ]
                                ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.029,
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF75ADF6), Color(0xFF25599C)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: const Color(0xFF5174CF), width: 1),
                  ),
                  child: const Center(
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
