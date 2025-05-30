 import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api.dart';
import '../../../shared/model/metal_master_model.dart';

final API api = API();

class TodayRateRepository {

  static Future<List<MetalMasterModel>> getMetalMasterList() async {
    try {
      final response = await http.get(
        api.endpointUri(Endpoint.getMetalGroupData),
        headers: await API().getHeaders(),
      );

      if (response.statusCode == HttpStatus.ok) {
        List<MetalMasterModel> list = (jsonDecode(response.body) as List)
            .map((e) => MetalMasterModel.fromJson(e))
            .toList();
        log("List of metal master: ${list.map((e) => e.toJson())}");
        return list;

      }
    } catch (e) {
      log("Error gettingMetal master list: $e");
    }

    return [];
  }

}