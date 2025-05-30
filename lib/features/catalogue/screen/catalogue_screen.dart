import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/catalogue_bloc.dart';
import '../models/jewellery_stock_item_data.dart';
import '../widgets/jewellery_card.dart';
import '../../dashboard/screens/dashboard_page.dart';
import '../widgets/custom_overlay_dropdown.dart';
import 'cart_screen.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  final int itemsPerPage = 10;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Make sure Bloc is available before reading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatalogueBloc>().add(LoadCatalogueItems(page: 0, itemsPerPage: itemsPerPage));
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final currentState = context.read<CatalogueBloc>().state;
      if (currentState is CatalogueLoaded && !currentState.hasReachedMax) {
        context.read<CatalogueBloc>().add(
          LoadCatalogueItems(
            page: currentState.items.length ~/ itemsPerPage,
            itemsPerPage: itemsPerPage,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void showPartialStockFilterOverlay(BuildContext context) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                overlayEntry?.remove();
              },
              child: Container(
                color: Colors.black54,
              ),
            ),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stock Filter',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => overlayEntry?.remove(),
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('STOCK SELECTION'),
                                    SizedBox(height: 8),
                                    CustomDropdownField(
                                      label: 'Stock Selection',
                                      options: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3',
                                        'Option 4'
                                      ],
                                      onChanged: (value) {
                                        print('Selected: $value');
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text('COUNTER'),
                                    SizedBox(height: 8),
                                    CustomDropdownField(
                                      label: 'COUNTER',
                                      options: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3',
                                        'Option 4'
                                      ],
                                      onChanged: (value) {
                                        print('Selected: $value');
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text('PURITY'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text('NET WT'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text('COST PRICE'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('PRODUCT GROUP'),
                                    SizedBox(height: 8),
                                    CustomDropdownField(
                                      label: 'PRODUCT GROUP',
                                      options: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3',
                                        'Option 4'
                                      ],
                                      onChanged: (value) {
                                        print('Selected: $value');
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text('CATEGORY'),
                                    SizedBox(height: 8),
                                    CustomDropdownField(
                                      label: 'CATEGORY',
                                      options: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3',
                                        'Option 4'
                                      ],
                                      onChanged: (value) {
                                        print('Selected: $value');
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text('QUANTITY'),
                                    SizedBox(height: 8),
                                    SizedBox(
                                      height: 40,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'QUANTITY',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                        ),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text('DIAMOND WT'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text('SELL PRICE'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('COLLECTION'),
                                    SizedBox(height: 8),
                                    CustomDropdownField(
                                      label: 'COLLECTION',
                                      options: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3',
                                        'Option 4'
                                      ],
                                      onChanged: (value) {
                                        print('Selected: $value');
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text('STYLE NO.'),
                                    SizedBox(height: 8),
                                    CustomDropdownField(
                                      label: 'STYLE NO.',
                                      options: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3',
                                        'Option 4'
                                      ],
                                      onChanged: (value) {
                                        print('Selected: $value');
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text('GROSS WT'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text('C/STONE WT'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'FROM',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        Text('to'),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'TO',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                ),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              overlayEntry?.remove();
                            },
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height * 0.045,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff50E6C8),
                                      Color(0xff154D42)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                border: Border.all(
                                    color: const Color(0xFF339B86), width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  'GET DATA',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              overlayEntry?.remove();
                            },
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height * 0.045,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xffA8B0B9),
                                      Color(0xff3A3B3F)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                border: Border.all(
                                    color: const Color(0xFF686B71), width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  'RESET',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
          ],
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardPage()),
                          );
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'JEWELLERY CATALOGUE',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      final catalogueBloc = BlocProvider.of<CatalogueBloc>(context); // ✅ Get bloc before showDialog

                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider.value(
                            value: catalogueBloc, // ✅ Pass it here
                            child: CartDialog(),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFB972), Color(0xFF875012)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border.all(color: Color(0xFFD08E47), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.shopping_cart, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'CART',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Search & Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for quick results...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xFFE2E8F5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xFFE2E8F5), width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xFFE2E8F5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () => showPartialStockFilterOverlay(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(color: const Color(0xFFEBEEF4), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.filter_list, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'FILTER',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Grid View + Bloc Builder
            BlocBuilder<CatalogueBloc, CatalogueState>(
              builder: (context, state) {
                List<JewelleryStockItemData> items = [];
                bool hasReachedMax = false;

                if (state is CatalogueInitial) {
                  return Center(child: Text("Tap to load items"));
                } else if (state is CatalogueLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CatalogueLoaded) {
                  items = state.items;
                  hasReachedMax = state.hasReachedMax;
                } else if (state is CatalogueError) {
                  return Center(child: Text("Error: ${state.message}"));
                }

                if (items.isEmpty) {
                  return Center(child: Text("No items found."));
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      itemCount: items.length,
                      controller: _scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return JewelleryCard(item: items[index]);
                      },
                    ),
                  ),
                );
              },
            ),

            // Footer Row
            BlocConsumer<CatalogueBloc, CatalogueState>(
              listener: (context, state) {},
              builder: (context, state) {
                int total = 0;
                if (state is CatalogueLoaded) {
                  total = state.items.length;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total count: $total"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}