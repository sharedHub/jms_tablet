import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../../../shared/date_time_parser.dart';
import '../../../shared/model/metal_master_model.dart';
import 'jewelery_stock_packet_data.dart';

class JewelleryStockItemData {
  final bool? isAutoBarcode;
  final bool? printWithRate;
  final String? itemCid;
  final String? itemYear;
  final String? itemBLocation;
  final String? itemLocation;
  final String? itemGroup;
  final String? itemInitial;
  final String? itemSub;
  final String? itemTagNo;
  final int? itemMid;
  final String? itemMLot;
  final String? metalColour;
  final String? itemDescription;
  final String? itemSpecification;
  final String? itemDesignNo;
  final String? itemSize;
  final double? itemPurity;
  final double? itemTouch;
  final int? itemQuantity;
  final double? itemGrossWeight;
  final double? itemNetWeight;
  final double? itemMRate;
  final String? itemMrOn;
  final double? itemMValue;
  final double? itemStudValue;
  final double? itemLRate;
  final double? itemLCharges;
  final double? itemRCharges;
  final double? itemOCharges;
  final double? itemCPrice;
  final String? itemSource;
  final DateTime? itemRcdDate;
  final String? itemStatus;
  final String? itemEUser;
  final DateTime? itemEDate;
  final String? itemLrOn;
  final String? itemBranch;
  final String? itemCategory;
  final double? itemChgWeight;
  final double? itemSetChgs;
  final double? itemRodChgs;
  final double? itemSPrice;
  final String? itemSection;
  final int? itemDPcs;
  final double? itemDWeight;
  final int? itemCPcs;
  final double? itemCWeight;
  final double? itemChainWeight;
  final String? CCode;
  final String? itemCounter;
  final String? itemSetNo;
  final String? itemRFID;
  final String? itemQuality;
  final String? itemHUIDNo;
  final DateTime? itemHUIDate;
  final int? itemSerial;
  final String? itemWCode;
  final double? itemTPrice;
  final String? itemWName;
  final bool? itemHMFlag;
  final String? itemDMode;
  final String? itemDModeName;
  final int? mGroupID;
  final String? iFillPath;
  final String? categoryCode;
  final List<JewelleryStockPacketData>? subItems;
  final String? itemImagepath;
  final String? itemCertificate;
  final String? itemSubName;
  final String? itemPMaster;
  final double? itemAddWeight;
  final double? itemHChgs;
  final double? itemEnamelChgs;
  final double? itemStrChgs;
  final double? itemStampChgs;
  final double? itemCertChgs;
  final DateTime? itemOrgDate;
  final String? itemBrand;
  final String? tempCatCode;
  final String? itemSubCode;
  final String? itemBarcode;
  final double? itemGSTPcnt;
  final double? itemGSTAmt;
  final double? itemFPrice;
  final String? itemCCode;
  final double? itemSMRate;
  final String? itemSMROn;
  final double? itemSMValue;
  final double? itemSLRate;
  final String? itemSLROn;
  final double? itemSLabour;
  final double? itemSOChgs;
  final double? itemSSValue;
  final int? itemWVNo;
  final int? itemWID;

  // 🔽 NEW FIELD TO STORE IMAGE BYTES
  Uint8List? imageBytes;

  JewelleryStockItemData({
    this.isAutoBarcode,
    this.printWithRate,
    this.itemCid,
    this.itemYear,
    this.itemBLocation,
    this.itemLocation,
    this.itemGroup,
    this.itemInitial,
    this.itemSub,
    this.itemTagNo,
    this.itemMid,
    this.itemMLot,
    this.metalColour,
    this.itemDescription,
    this.itemSpecification,
    this.itemDesignNo,
    this.itemSize,
    this.itemPurity,
    this.itemTouch,
    this.itemQuantity,
    this.itemGrossWeight,
    this.itemNetWeight,
    this.itemMRate,
    this.itemMrOn,
    this.itemMValue,
    this.itemStudValue,
    this.itemLRate,
    this.itemLCharges,
    this.itemRCharges,
    this.itemOCharges,
    this.itemCPrice,
    this.itemSource,
    this.itemRcdDate,
    this.itemStatus,
    this.itemEUser,
    this.itemEDate,
    this.itemLrOn,
    this.itemBranch,
    this.itemCategory,
    this.itemChgWeight,
    this.itemSetChgs,
    this.itemRodChgs,
    this.itemSPrice,
    this.itemSection,
    this.itemDPcs,
    this.itemDWeight,
    this.itemCPcs,
    this.itemCWeight,
    this.itemChainWeight,
    this.CCode,
    this.subItems,
    this.itemSetNo,
    this.itemRFID,
    this.itemQuality,
    this.itemHUIDNo,
    this.itemHUIDate,
    this.itemSerial,
    this.itemWCode,
    this.itemTPrice,
    this.itemWName,
    this.itemHMFlag,
    this.itemCounter,
    this.itemDMode,
    this.itemDModeName,
    this.mGroupID,
    this.iFillPath,
    this.categoryCode,
    this.itemImagepath,
    this.itemCertificate,
    this.itemSubName,
    this.itemPMaster,
    this.itemAddWeight,
    this.itemHChgs,
    this.itemEnamelChgs,
    this.itemStrChgs,
    this.itemStampChgs,
    this.itemCertChgs,
    this.itemOrgDate,
    this.itemBrand,
    this.tempCatCode,
    this.itemSubCode,
    this.itemBarcode,
    this.itemGSTPcnt,
    this.itemGSTAmt,
    this.itemFPrice,
    this.itemCCode,
    this.itemSMRate,
    this.itemSMROn,
    this.itemSMValue,
    this.itemSLRate,
    this.itemSLROn,
    this.itemSLabour,
    this.itemSOChgs,
    this.itemSSValue,
    this.itemWVNo,
    this.itemWID,
    this.imageBytes, // 🔼 Initialize new field
  });

  factory JewelleryStockItemData.fromJson(Map<String, dynamic> json) {
    return JewelleryStockItemData(
      isAutoBarcode: json["isAutoBarcode"],
      printWithRate: json["printWithRate"],
      itemCid: json["itemCID"],
      itemYear: json["itemYear"],
      itemBLocation: json["itemBLocation"],
      itemLocation: json["itemLocation"],
      itemGroup: json["itemGroup"],
      itemInitial: json["itemInitial"],
      itemSub: json["itemSub"],
      itemTagNo: json["itemTagNo"],
      itemMid: json["itemMID"],
      itemMLot: json["itemMLot"],
      metalColour: json["metalColour"],
      itemDescription: json["itemDescription"],
      itemSpecification: json["itemSpecification"],
      itemDesignNo: json["itemDesignNo"],
      itemSize: json["itemSize"],
      itemPurity: doubleParser(json["itemPurity"]),
      itemTouch: doubleParser(json["itemTouch"]),
      itemQuantity: json["itemQuantity"],
      itemGrossWeight: doubleParser(json["itemGrossWeight"]),
      itemNetWeight: doubleParser(json["itemNetWeight"]),
      itemMRate: doubleParser(json["itemMRate"]),
      itemMrOn: json["itemMROn"],
      itemMValue: doubleParser(json["itemMValue"]),
      itemStudValue: doubleParser(json["itemStudValue"]),
      itemLRate: doubleParser(json["itemLRate"]),
      itemLCharges: doubleParser(json["itemLCharges"]),
      itemRCharges: doubleParser(json["itemRCharges"]),
      itemOCharges: doubleParser(json["itemOCharges"]),
      itemCPrice: doubleParser(json["itemCPrice"]),
      itemSource: json["itemSource"],
      itemRcdDate: json["itemRcdDate"] == null ? null : DateTime.parse(json["itemRcdDate"]),
      itemStatus: json["itemStatus"],
      itemEUser: json["itemEUser"],
      itemEDate: json["itemEDate"] == null ? null : DateTime.parse(json["itemEDate"]).toLocal(),
      itemLrOn: json["itemLROn"],
      itemBranch: json["itemBranch"],
      itemCategory: json["itemCategory"],
      itemChgWeight: doubleParser(json["itemChgWeight"]),
      itemSetChgs: doubleParser(json["itemSetChgs"]),
      itemRodChgs: doubleParser(json["itemRodChgs"]),
      itemSPrice: doubleParser(json["itemSPrice"]),
      itemSection: json["itemSection"] ?? "DIAMOND",
      itemDPcs: json["itemDPcs"] ?? 0,
      itemDWeight: doubleParser(json["itemDWeight"]),
      itemCPcs: json["itemCPcs"] ?? 0,
      itemCWeight: doubleParser(json["itemCWeight"]),
      itemChainWeight: doubleParser(json["itemChainWeight"]),
      CCode: json["CCode"],
      subItems: json["subItems"] == null
          ? []
          : List<JewelleryStockPacketData>.from(json["subItems"]!.map((x) => JewelleryStockPacketData.fromJson(x))),
      itemSetNo: json["itemSetNo"],
      itemRFID: json["itemRFID"],
      itemQuality: json["itemQuality"],
      itemHUIDNo: json["itemHUIDNo"],
      itemHUIDate: json["itemHUIDate"] == null ? null : DateTime.parse(json["itemHUIDate"]).toLocal(),
      itemSerial: json["itemSerial"],
      itemWCode: json["itemWCode"],
      itemTPrice: doubleParser(json["itemTPrice"]),
      itemWName: json["itemWName"],
      itemHMFlag: json["itemHMFlag"],
      itemCounter: json["itemCounter"],
      itemDMode: json["itemDMode"],
      itemDModeName: json["itemDModeName"],
      mGroupID: json["mGroupID"],
      iFillPath: json["iFillPath"],
      categoryCode: json["categoryCode"],
      itemImagepath: json["itemImagepath"],
      itemCertificate: json["itemCertificate"],
      itemSubName: json["itemSubName"],
      itemPMaster: json["itemPMaster"],
      itemAddWeight: doubleParser(json["itemAddWeight"]),
      itemHChgs: doubleParser(json["itemHChgs"]),
      itemEnamelChgs: doubleParser(json["itemEnamelChgs"]),
      itemCertChgs: doubleParser(json["itemCertChgs"]),
      itemStampChgs: doubleParser(json["itemStampChgs"]),
      itemStrChgs: doubleParser(json["itemStrChgs"]),
      itemOrgDate: json["itemOrgDate"] == null ? null : DateTime.parse(json["itemOrgDate"]).toLocal(),
      itemBrand: json["itemBrand"],
      tempCatCode: json["tempCatCode"],
      itemSubCode: json["itemSubCode"],
      itemBarcode: json["itemBarcode"],
      itemGSTAmt: doubleParser(json["itemGSTAmt"]),
      itemGSTPcnt: doubleParser(json["itemGSTPcnt"]),
      itemFPrice: doubleParser(json["itemFPrice"]),
      itemCCode: json["itemCCode"],
      itemSMRate: doubleParser(json["itemSMRate"]),
      itemSMROn: json["itemSMROn"],
      itemSMValue: doubleParser(json["itemSMValue"]),
      itemSLRate: doubleParser(json["itemSLRate"]),
      itemSLROn: json["itemSLROn"],
      itemSLabour: doubleParser(json["itemSLabour"]),
      itemSOChgs: doubleParser(json["itemSOChgs"]),
      itemSSValue: doubleParser(json["itemSSValue"]),
      itemWVNo: json["itemWVNo"],
      itemWID: json["itemWID"],
      // 🔽 Default to null until loaded
      imageBytes: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isAutoBarcode": isAutoBarcode,
      "printWithRate": printWithRate,
      "itemCID": itemCid,
      "itemYear": itemYear,
      "itemBLocation": itemBLocation,
      "itemLocation": itemLocation,
      "itemGroup": itemGroup,
      "itemInitial": itemInitial,
      "itemSub": itemSub,
      "itemTagNo": itemTagNo,
      "itemMID": itemMid,
      "itemMLot": itemMLot,
      "metalColour": metalColour,
      "itemDescription": itemDescription,
      "itemSpecification": itemSpecification,
      "itemDesignNo": itemDesignNo,
      "itemSize": itemSize,
      "itemPurity": itemPurity,
      "itemTouch": itemTouch,
      "itemQuantity": itemQuantity,
      "itemGrossWeight": itemGrossWeight,
      "itemNetWeight": itemNetWeight,
      "itemMRate": itemMRate,
      "itemMROn": itemMrOn,
      "itemMValue": itemMValue,
      "itemStudValue": itemStudValue,
      "itemLRate": itemLRate,
      "itemLCharges": itemLCharges,
      "itemRCharges": itemRCharges,
      "itemOCharges": itemOCharges,
      "itemCPrice": itemCPrice,
      "itemSource": itemSource,
      "itemRcdDate": DateConverter.formatToGolangCompatibleRFC3339NanoUtc(itemRcdDate),
      "itemStatus": itemStatus,
      "itemEUser": itemEUser,
      "itemEDate": DateConverter.formatToGolangCompatibleRFC3339NanoUtc(itemEDate),
      "itemLROn": itemLrOn,
      "itemBranch": itemBranch,
      "itemCategory": itemCategory,
      "itemChgWeight": itemChgWeight,
      "itemSetChgs": itemSetChgs,
      "itemRodChgs": itemRodChgs,
      "itemSPrice": itemSPrice,
      "itemSection": itemSection,
      "itemDPcs": itemDPcs,
      "itemDWeight": itemDWeight,
      "itemCPcs": itemCPcs,
      "itemCWeight": itemCWeight,
      "itemChainWeight": itemChainWeight,
      "CCode": CCode,
      "itemCounter": itemCounter,
      "itemSetNo": itemSetNo,
      "itemRFID": itemRFID,
      "itemQuality": itemQuality,
      "itemHUIDNo": itemHUIDNo,
      "itemHUIDate": DateConverter.formatToGolangCompatibleRFC3339NanoUtc(itemHUIDate),
      "itemSerial": itemSerial,
      "itemWCode": itemWCode,
      "itemTPrice": itemTPrice,
      "itemWName": itemWName,
      "itemHMFlag": itemHMFlag,
      "itemDMode": itemDMode,
      "itemDModeName": itemDModeName,
      "mGroupID": mGroupID,
      "subItems": subItems == null ? [] : List<dynamic>.from(subItems!.map((x) => x.toJson())),
      "iFillPath": iFillPath,
      "categoryCode": categoryCode,
      "itemImagepath": itemImagepath,
      "itemCertificate": itemCertificate,
      "itemSubName": itemSubName,
      "itemPMaster": itemPMaster,
      "itemAddWeight": itemAddWeight,
      "itemHChgs": itemHChgs,
      "itemEnamelChgs": itemEnamelChgs,
      "itemCertChgs": itemCertChgs,
      "itemStampChgs": itemStampChgs,
      "itemStrChgs": itemStrChgs,
      "itemOrgDate": DateConverter.formatToGolangCompatibleRFC3339NanoUtc(itemOrgDate),
      "itemBrand": itemBrand,
      "itemGSTAmt": itemGSTAmt,
      "itemGSTPcnt": itemGSTPcnt,
      "itemFPrice": itemFPrice,
      "itemCCode": itemCCode,
      "itemSMRate": itemSMRate,
      "itemSMROn": itemSMROn,
      "itemSMValue": itemSMValue,
      "itemSLRate": itemSLRate,
      "itemSLROn": itemSLROn,
      "itemSLabour": itemSLabour,
      "itemSOChgs": itemSOChgs,
      "itemSSValue": itemSSValue,
      "itemWVNo": itemWVNo,
      "itemWID": itemWID,
      // 🔽 Do not serialize imageBytes
    };
  }

  static JewelleryStockItemData empty() {
    return JewelleryStockItemData(
      itemCid: '',
      itemYear: '',
      itemBLocation: '',
      itemLocation: '',
      itemGroup: 'GOLD',
      itemInitial: '',
      itemSub: '',
      itemTagNo: '',
      itemMid: 0,
      itemMLot: '',
      metalColour: '',
      itemDescription: '',
      itemSpecification: '',
      itemDesignNo: '',
      itemSize: '',
      itemPurity: 0.0,
      itemTouch: 0.0,
      itemQuantity: 1,
      itemGrossWeight: 0.0,
      itemNetWeight: 0.0,
      itemMRate: 0.0,
      itemMrOn: 'NET',
      itemMValue: 0.0,
      itemStudValue: 0.0,
      itemLRate: 0.0,
      itemLCharges: 0.0,
      itemRCharges: 0.0,
      itemOCharges: 0.0,
      itemCPrice: 0.0,
      itemSource: '',
      itemRcdDate: DateTime.now(),
      itemStatus: '',
      itemEUser: '',
      itemEDate: DateTime.now(),
      itemLrOn: 'NET',
      itemBranch: '',
      itemCategory: '',
      itemChgWeight: 0.0,
      itemSetChgs: 0.0,
      itemRodChgs: 0.0,
      itemSPrice: 0.0,
      itemSection: 'DIAMOND',
      itemDPcs: 0,
      itemDWeight: 0.0,
      itemCPcs: 0,
      itemCWeight: 0.0,
      itemChainWeight: 0.0,
      CCode: '',
      itemCounter: '',
      itemSetNo: '',
      itemRFID: '',
      itemQuality: '',
      itemHUIDNo: '',
      itemHUIDate: null,
      itemSerial: 0,
      itemWCode: '',
      itemTPrice: 0.0,
      itemWName: '',
      itemHMFlag: false,
      itemDMode: "",
      itemDModeName: 'DEDUCT BOTH',
      mGroupID: 1,
      subItems: [JewelleryStockPacketData.empty()],
      iFillPath: '',
      categoryCode: '',
      itemImagepath: "",
      itemCertificate: "",
      itemSubName: "",
      itemPMaster: "",
      itemAddWeight: 0.0,
      itemHChgs: 0.0,
      itemEnamelChgs: 0.0,
      itemCertChgs: 0.0,
      itemStampChgs: 0.0,
      itemStrChgs: 0.0,
      itemOrgDate: DateTime.now(),
      itemBrand: "",
      itemGSTAmt: 0.0,
      itemGSTPcnt: 3.0,
      itemFPrice: 0.0,
      itemCCode: "",
      itemSMRate: 0.0,
      itemSMROn: 'NET',
      itemSMValue: 0.0,
      itemSLRate: 0.0,
      itemSLROn: 'NET',
      itemSLabour: 0.0,
      itemSOChgs: 0.0,
      itemSSValue: 0.0,
      itemWVNo: 0,
      itemWID: 0,
      // 🔽 Default for empty
      imageBytes: null,
    );
  }
}