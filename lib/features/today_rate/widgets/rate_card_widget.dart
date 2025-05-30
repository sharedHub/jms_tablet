import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/today_rate_bloc.dart';
import '../bloc/today_rate_event.dart';
import '../model/today_rate_model.dart';
import 'today_date_widget.dart';

class TodayRateCardBloc extends StatelessWidget {
  final MetalRate rate;

  TodayRateCardBloc(this.rate);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Date + Metal Type + 3-dot menu
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.04,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffD1E3FD),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    rate.date,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditRateDialog(context, rate);
                      } else if (value == 'delete') {
                        _deleteRate(context, rate);
                      }
                    },
                    icon: Icon(Icons.more_vert, size: 20), // Consistent size
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            SizedBox(height: MediaQuery.of(context).size.height * 0.008),

            // Karat Headers
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: Text(
                      rate.metalType,
                      style: TextStyle(fontSize: 14, color: Colors.purple),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '14 Karat',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '18 Karat',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '22 Karat',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '24 Karat',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Purchase Rate Row
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      'Purchase Rate',
                      style: TextStyle(color: Color(0xff585C60)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.purchaseRate['14K'] ?? '0',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.purchaseRate['18K'] ?? '0',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.purchaseRate['22K'] ?? '0',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.purchaseRate['24K'] ?? '0',
                        style: TextStyle(color: Color(0xff242B30)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Selling Rate Row
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      'Selling Rate',
                      style: TextStyle(color: Color(0xff585C60)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.sellingRate['14K'] ?? '0',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.sellingRate['18K'] ?? '0',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.sellingRate['22K'] ?? '0',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        rate.sellingRate['24K'] ?? '0',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Edit Function - Opens Dialog to edit existing rate
  void _showEditRateDialog(BuildContext context, MetalRate rate) {
    final formKey = GlobalKey<FormState>();
    final purchaseRate14 = TextEditingController(text: rate.purchaseRate['14K']);
    final purchaseRate18 = TextEditingController(text: rate.purchaseRate['18K']);
    final purchaseRate22 = TextEditingController(text: rate.purchaseRate['22K']);
    final purchaseRate24 = TextEditingController(text: rate.purchaseRate['24K']);

    final sellingRate14 = TextEditingController(text: rate.sellingRate['14K']);
    final sellingRate18 = TextEditingController(text: rate.sellingRate['18K']);
    final sellingRate22 = TextEditingController(text: rate.sellingRate['22K']);
    final sellingRate24 = TextEditingController(text: rate.sellingRate['24K']);

    String selectedMetal = rate.metalType;
    final List<String> metalOptions = ['Gold', 'Silver', 'Platinum', 'Diamond'];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Edit Rate', style: Theme.of(context).textTheme.titleLarge),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(dialogContext),
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Display Date and Metal Type dropdown
                  Row(
                    children: [
                      Expanded(
                        child: Text('Date: ${rate.date}'),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButtonFormField<String>(
                              value: selectedMetal,
                              items: metalOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedMetal = newValue;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Select Metal',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Text('Purchase Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      _buildRateField('14 Karat', purchaseRate14),
                      SizedBox(width: 8),
                      _buildRateField('18 Karat', purchaseRate18),
                      SizedBox(width: 8),
                      _buildRateField('22 Karat', purchaseRate22),
                      SizedBox(width: 8),
                      _buildRateField('24 Karat', purchaseRate24),
                    ],
                  ),

                  SizedBox(height: 16),

                  Text('Selling Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      _buildRateField('14 Karat', sellingRate14),
                      SizedBox(width: 8),
                      _buildRateField('18 Karat', sellingRate18),
                      SizedBox(width: 8),
                      _buildRateField('22 Karat', sellingRate22),
                      SizedBox(width: 8),
                      _buildRateField('24 Karat', sellingRate24),
                    ],
                  ),

                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final updatedRate = rate.copyWith(
                              metalType: selectedMetal,
                              purchaseRate: {
                                '14K': purchaseRate14.text,
                                '18K': purchaseRate18.text,
                                '22K': purchaseRate22.text,
                                '24K': purchaseRate24.text,
                              },
                              sellingRate: {
                                '14K': sellingRate14.text,
                                '18K': sellingRate18.text,
                                '22K': sellingRate22.text,
                                '24K': sellingRate24.text,
                              },
                            );

                            context.read<MetalRatesBloc>().add(
                              UpdateMetalRate(oldRate: rate, newRate: updatedRate),
                            );
                            Navigator.pop(dialogContext);
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff3E968E),
                            border: Border.all(color: const Color(0xFF5ACAC0)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.white),
                              SizedBox(width: 4),
                              Text('Save', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () => Navigator.pop(dialogContext),
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff767B7D),
                            border: Border.all(color: const Color(0xFF5174CF)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.cancel, color: Colors.white),
                              SizedBox(width: 4),
                              Text('Cancel', style: TextStyle(color: Colors.white)),
                            ],
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
      },
    );
  }

  // Delete Function
  void _deleteRate(BuildContext context, MetalRate rate) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Delete Confirmation"),
          content: Text("Are you sure you want to delete this ${rate.metalType} rate for ${rate.date}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<MetalRatesBloc>().add(DeleteMetalRate(rate: rate));
                Navigator.pop(dialogContext);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Helper widget for TextFormField
  Widget _buildRateField(String label, TextEditingController controller) {
    return SizedBox(
      width: 167,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }
}

