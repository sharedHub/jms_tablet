import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jms_tablet/features/catalogue/repository/smb_service.dart';
import '../../../api.dart';
import '../models/jewellery_stock_item_data.dart';

class CatalogueRepository {
  final API api = API();
  final SmbClient smbClient = SmbClient();

  Future<List<JewelleryStockItemData>> getItemListData(int page, int limit) async {
    try {
      final cid = "GJ";
      final branch = "BAN";

      final response = await http.get(
        api.endpointUri(Endpoint.stockItemDataList, queryParameters: {
          "cid": cid ?? "",
          "branch": branch ?? "",
        }),
        headers: await API().getHeaders(),
      );

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        debugPrint('api model raw data is successfully called : $decodeJson[1]');
        // Connect to SMB before fetching images
        // await smbClient.connect();

        // Parse items
        final List<JewelleryStockItemData> items = List.from(decodeJson)
            .map((e) => JewelleryStockItemData.fromJson(e))
            .toList();

        // images from model

        // Load images
        // for (var item in items) {
        //   if (item.itemImagepath != null && item.itemImagepath!.isNotEmpty) {
        //     final bytes = await smbClient.fetchImage(item.itemImagepath!);
        //     if (bytes != null) {
        //       item.imageBytes = bytes;
        //     }
        //   }
        // }


        //testingpath not from model
        // final String testImagePath = r"\c$\Users\Adminis\Pictures\Screenshots\test.png";
        //
        // for (var item in items) {
        //   debugPrint("🖼 Loading image for: ${item.itemDesignNo}");
        //   final bytes = await smbClient.fetchImage(testImagePath);
        //
        //   if (bytes != null) {
        //     item.imageBytes = bytes;
        //     debugPrint("✅ Image loaded for: ${item.itemDesignNo}");
        //   } else {
        //     debugPrint("❌ Failed to load image for: ${item.itemDesignNo}");
        //   }
        // }


        // await smbClient.disconnect();

        return items;
      } else {
        debugPrint("Failed to load items: ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint('Error fetching items: $e');
    }
    return [];
  }
}