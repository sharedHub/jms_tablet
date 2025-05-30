import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/catalogue_bloc.dart';
import '../models/jewelery_stock_packet_data.dart';
import '../models/jewellery_stock_item_data.dart';

class JewelleryCard extends StatelessWidget {
  final JewelleryStockItemData item;

  const JewelleryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Calculate diamond & clasp values from subItems
    double diamondWeight = 0.0;
    int diamondPieces = 0;
    double claspWeight = 0.0;
    int claspPieces = 0;

    if (item.subItems != null && item.subItems!.isNotEmpty) {
      for (var packet in item.subItems!) {
        if (packet.packetType?.toUpperCase() == 'DIAMOND') {
          diamondWeight += packet.packetWeight ?? 0.0;
          diamondPieces += packet.packetQuantity ?? 0;
        } else {
          claspWeight += packet.packetWeight ?? 0.0;
          claspPieces += packet.packetQuantity ?? 0;
        }
      }
    }

    return InkWell(
      onTap: () {
        // TODO: Navigate to detail screen with full item object
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => JewelleryDetailScreen(item: item),
        //   ),
        // );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: item.imageBytes == null
                  ? item.itemImagepath != null && item.itemImagepath!.isNotEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Image.asset('assets/images/jewellery_image.png')
                  : Image.memory(
                item.imageBytes!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.itemDesignNo ?? "N/A",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.itemBarcode ?? "Jewellery Item",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "PURITY: ",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.14,
                                child: Text(
                                  (item.itemPurity ?? 0.0).toStringAsFixed(2),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "TOUCH: ",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(
                                  (item.itemTouch ?? 0.0).toStringAsFixed(2),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "GROSS:",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.14,
                                child: Text(
                                  (item.itemGrossWeight ?? 0.0).toStringAsFixed(3),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "NET WT:",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(
                                  (item.itemNetWeight ?? 0.0).toStringAsFixed(3),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "DIA WT:",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.14,
                                child: Text(
                                  (diamondWeight ?? 0.0).toStringAsFixed(3),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "DIA PCS:",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(
                                  (diamondPieces ?? 0.0).toStringAsFixed(3),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  "CLS WT:",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.14,
                                child: Text(
                                  (claspWeight ?? 0.0).toStringAsFixed(3),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09 ,
                                child: Text(
                                  "CLS PCS:",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(
                                  (claspPieces ?? 0.0).toStringAsFixed(3),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹ ${(item.itemTPrice ?? 0.0).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<CatalogueBloc>().add(AddToCart(item: item));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.029,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF5174CF), Color(0xFF27489C)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(color: Color(0xFF5174CF), width: 1),
                          ),
                          child: BlocBuilder<CatalogueBloc, CatalogueState>(
                            builder: (context, state) {
                              if (state is CatalogueLoaded) {
                                final bool isInCart = state.cartItems
                                    .any((cartItem) => identical(cartItem.item, item));

                                return Center(
                                  child: isInCart
                                      ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.check, color: Colors.white, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        'ADDED',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                      : const Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return const Center(
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value, BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.16,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}