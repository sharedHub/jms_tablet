import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/model/metal_master_model.dart';
import '../bloc/today_rate_bloc.dart';
import '../bloc/today_rate_event.dart';
import '../bloc/today_rate_state.dart';
import '../model/today_rate_model.dart';
import '../repository/today_rate_repository.dart';
import '../widgets/rate_card_widget.dart';
import '../widgets/today_date_widget.dart';

class TodayRateScreenBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MetalRatesBloc()..add(LoadMetalRates()),
      child: TodayRateView(),
    );
  }
}

class TodayRateView extends StatefulWidget {
  @override
  State<TodayRateView> createState() => _TodayRateViewState();
}

class _TodayRateViewState extends State<TodayRateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Today's Rate",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => _showAddRateDialog(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      width: MediaQuery.of(context).size.width * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff5275E8),
                        border: Border.all(color: const Color(0xFF97AFFF)),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              'NEW',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<MetalRatesBloc, MetalRatesState>(
                listener: (context, state) {
                  if (state is MetalRatesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is MetalRateAdded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Metal rate added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is MetalRateUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Metal rate updated successfully!'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } else if (state is MetalRateDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Metal rate deleted successfully!'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is MetalRatesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MetalRatesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 64, color: Colors.red),
                          SizedBox(height: 16),
                          Text(
                            'Error loading metal rates',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(state.message),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<MetalRatesBloc>().add(RefreshMetalRates());
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MetalRatesLoaded ||
                      state is MetalRateAdded ||
                      state is MetalRateUpdated ||
                      state is MetalRateDeleted) {
                    List<MetalRate> rates = [];
                    if (state is MetalRatesLoaded) rates = state.rates;
                    else if (state is MetalRateAdded) rates = state.rates;
                    else if (state is MetalRateUpdated) rates = state.rates;
                    else if (state is MetalRateDeleted) rates = state.rates;

                    if (rates.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.monetization_on_outlined, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'No metal rates added yet',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tap "NEW" to add your first metal rate',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }


                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<MetalRatesBloc>().add(RefreshMetalRates());
                      },
                      child: ListView.builder(
                        itemCount: rates.length,
                        itemBuilder: (context, index) {
                          return TodayRateCardBloc(rates[index]);
                        },
                      ),
                    );
                  }
                  return Center(child: Text('Loading...'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddRateDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final purchaseRate14 = TextEditingController();
    final purchaseRate18 = TextEditingController();
    final purchaseRate22 = TextEditingController();
    final purchaseRate24 = TextEditingController();
    final sellingRate14 = TextEditingController();
    final sellingRate18 = TextEditingController();
    final sellingRate22 = TextEditingController();
    final sellingRate24 = TextEditingController();
    MetalMasterModel? selectedMetal;
    MetalRate? selectedMetalRate;
    final todayDate = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height * 0.33;
        return Dialog(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff9da4a9),width: 2),
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(12)
            ),
            height: height,
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Add Rate', style: Theme.of(context).textTheme.titleLarge),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(dialogContext),
                          child: const Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.425,
                          child: TodayDateDisplay()
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.422,
                          child: FutureBuilder<List<MetalMasterModel>>(
                            future: TodayRateRepository.getMetalMasterList(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text('No metal data found');
                              }

                              final metalList = snapshot.data!;
                              print("List of metal master: ${metalList.map((e) => e.toJson())}");

                              return DropdownButtonFormField<MetalMasterModel>(
                                decoration: const InputDecoration(
                                  labelText: 'Select Metal',
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedMetal,
                                items: metalList.map((metal) {
                                  return DropdownMenuItem<MetalMasterModel>(
                                    value: metal,
                                    child: Text(metal.stoneName ?? 'Unknown Metal'),
                                  );
                                }).toList(),
                                onChanged: (MetalMasterModel? metal) {
                                  if (metal != null) {
                                    setState(() {
                                      selectedMetal = metal;
                                      selectedMetalRate = MetalRate(
                                        id: metal.stoneId.toString(),              // Store stoneID
                                        date: DateTime.now().toIso8601String(),    // Or your logic
                                        metalType: metal.stoneName ?? '',          // Store stoneName
                                        purchaseRate: {},                          // Default or fetched later
                                        sellingRate: {},
                                      );
                                    });
                                  }
                                },
                                validator: (value) => value == null ? 'Please select a metal' : null,
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                    Text('Purchase Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.002),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                    Text('Selling Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.002),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate() && selectedMetal != null) {
                              final newRate = MetalRate(
                                id: selectedMetal!.stoneId?.toString() ?? '',
                                date: todayDate,
                                metalType: selectedMetal!.stoneName ?? '',
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
                              context.read<MetalRatesBloc>().add(AddMetalRate(rate: newRate));
                              Navigator.of(dialogContext).pop();
                            }
                            else if (selectedMetal == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select a metal type')),
                              );
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff3E968E),
                              border: Border.all(color: const Color(0xFF5ACAC0)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                Icon(Icons.check, color: Colors.white),
                                Text('Save', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () => Navigator.pop(dialogContext),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff767B7D),
                              border: Border.all(color: const Color(0xFF5174CF)),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                  Icon(Icons.cancel, color: Colors.white),
                                  Text('CANCEL', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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