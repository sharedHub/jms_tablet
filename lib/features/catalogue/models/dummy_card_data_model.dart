import 'package:flutter/material.dart';

import 'jewelery_stock_packet_data.dart';
import 'jewellery_stock_item_data.dart';

class JewelleryItem {
  final String code;
  final String name;
  final String purity;
  final String touch;
  final String grossWeight;
  final String netWeight;
  final String diamondWeight;
  final String claspWeight; // color stone weight
  final String diamondPieces;
  final String claspPieces;
  final double price;

  JewelleryItem({
    required this.code,
    required this.name,
    required this.purity,
    required this.touch,
    required this.grossWeight,
    required this.netWeight,
    required this.diamondWeight,
    required this.claspWeight,
    required this.diamondPieces,
    required this.claspPieces,
    required this.price,
  });
}

// Function to generate the list
late final List<JewelleryItem> allItems = List.generate(
  stockItems.length,
      (index) {
    final itemData = stockItems[index];
    double diamondWeight = 0.0;
    double claspWeight = 0.0; // color stone or other than diamond
    int diamondPieces = 0;
    int claspPieces = 0;

    if (itemData.subItems != null && itemData.subItems!.isNotEmpty) {
      for (var packet in itemData.subItems!) {
        if (packet.packetType?.toUpperCase() == 'DIAMOND') {
          diamondWeight += packet.packetWeight ?? 0.0;
          diamondPieces += packet.packetQuantity ?? 0;
        } else {
          claspWeight += packet.packetWeight ?? 0.0;
          claspPieces += packet.packetQuantity ?? 0;
        }
      }
    }

    return JewelleryItem(
      code: itemData.itemDesignNo ?? "ITEM-$index",
      name: itemData.itemBarcode ?? "Jewellery $index",
      purity: "${(itemData.itemPurity ?? 0.0).toStringAsFixed(2)}",
      touch: "${(itemData.itemTouch ?? 0.0).toStringAsFixed(2)}",
      grossWeight: "${(itemData.itemGrossWeight ?? 0.0).toStringAsFixed(3)}",
      netWeight: "${(itemData.itemNetWeight ?? 0.0).toStringAsFixed(3)}",
      diamondWeight: "${diamondWeight.toStringAsFixed(3)}",
      claspWeight: "${claspWeight.toStringAsFixed(3)}",
      diamondPieces: "$diamondPieces",
      claspPieces: "$claspPieces",
      price: itemData.itemTPrice ?? 1000.0 * (index % 50 + 1),
    );
  },
);

// Sample data (replace with real data from JSON or API)
final List<JewelleryStockItemData> stockItems = [
  JewelleryStockItemData(
    itemDesignNo: "DESIGN-001",
    itemBarcode: "BARCODE-001",
    itemPurity: 91.67,
    itemTouch: 91.67,
    itemGrossWeight: 105.45,
    itemNetWeight: 100.23,
    itemTPrice: 6000.0,
    subItems: [
      JewelleryStockPacketData(
        packetType: "DIAMOND",
        packetQuantity: 5,
        packetWeight: 2.5,
      ),
      JewelleryStockPacketData(
        packetType: "COLOR_STONE",
        packetQuantity: 1,
        packetWeight: 0.3,
      ),
    ],
  ),
  // Add more items here
];