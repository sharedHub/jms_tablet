import '../../../shared/model/metal_master_model.dart';

class JewelleryStockPacketData {
  final int? packetSerial;
  final String? itemCid;
  final String? itemYear;
  final String? itemGroup;
  final String? itemInitial;
  final String? itemTagNo;
  final int? packetId;
  final String? packetInitial;
  final String? packetDescription;
  final String? packetUnits;
  final String? packetType;
  final int? packetQuantity;
  final double? packetWeight;
  final double? packetAddWeight;
  final String? packetRateOn;
  final double? packetRate;
  final double? packetTAmount;
  final double? packetValue;
  final double? packetPurity;
  final double? packetTouch;
  final double? packetSPcnt;
  final double? packetSRate;
  final double? packetSValue;
  final String? packetSubLot;
  final int? packetSubLotID;
  final String? packetRemarks;
  final double? packetHRate;
  final double? packetHCharges;
  final String? packetCut;
  final String? packetClarity;
  final String? packetColour;
  final String? packetBranch;
  final String? packetSieve;

  JewelleryStockPacketData({
    this.packetSerial,
    this.itemCid,
    this.itemYear,
    this.itemGroup,
    this.itemInitial,
    this.itemTagNo,
    this.packetId,
    this.packetInitial,
    this.packetDescription,
    this.packetUnits,
    this.packetType,
    this.packetQuantity,
    this.packetWeight,
    this.packetAddWeight,
    this.packetRateOn,
    this.packetRate,
    this.packetTAmount,
    this.packetValue,
    this.packetPurity,
    this.packetTouch,
    this.packetSPcnt,
    this.packetSRate,
    this.packetSValue,
    this.packetSubLot,
    this.packetSubLotID,
    this.packetRemarks,
    this.packetHRate,
    this.packetHCharges,
    this.packetCut,
    this.packetClarity,
    this.packetColour,
    this.packetBranch,
    this.packetSieve,
  });

  factory JewelleryStockPacketData.fromJson(Map<String, dynamic> json) =>
      JewelleryStockPacketData(
        packetSerial: json["packetSerial"],
        itemCid: json["itemCID"],
        itemYear: json["itemYear"],
        itemGroup: json["itemGroup"],
        itemInitial: json["itemInitial"],
        itemTagNo: json["itemTagNo"],
        packetId: json["packetID"],
        packetInitial: json["packetInitial"],
        packetDescription: json["packetDescription"],
        packetUnits: json["packetUnits"],
        packetType: json["packetType"],
        packetQuantity: json["packetQuantity"],
        packetWeight: doubleParser(json["packetWeight"]),
        packetAddWeight: doubleParser(json["packetAddWeight"]),
        packetRateOn: json["packetRateOn"],
        packetRate: doubleParser(json["packetRate"]),
        packetTAmount: doubleParser(json["packetTAmount"]),
        packetValue: doubleParser(json["packetValue"]),
        packetPurity: doubleParser(json["packetPurity"]),
        packetTouch: doubleParser(json["packetTouch"]),
        packetSPcnt: doubleParser(json["packetSPcnt"]),
        packetSRate: doubleParser(json["packetSRate"]),
        packetSValue: doubleParser(json["packetSValue"]),
        packetSubLot: json["packetSubLot"],
        packetSubLotID: json["packetSubLotID"],
        packetHRate: doubleParser(json["packetHRate"]),
        packetHCharges: doubleParser(json["packetHCharges"]),
        packetRemarks: json["packetRemarks"],
        packetCut: json["packetCut"],
        packetClarity: json["packetClarity"],
        packetColour: json["packetColour"],
        packetBranch: json["packetBranch"],
        packetSieve: json["packetSieve"],
      );

  Map<String, dynamic> toJson() => {
    "packetSerial": packetSerial,
    "itemCID": itemCid,
    "itemYear": itemYear,
    "itemGroup": itemGroup,
    "itemInitial": itemInitial,
    "itemTagNo": itemTagNo,
    "packetID": packetId,
    "packetInitial": packetInitial,
    "packetDescription": packetDescription,
    "packetUnits": packetUnits,
    "packetType": packetType,
    "packetQuantity": packetQuantity,
    "packetWeight": packetWeight,
    "packetAddWeight": packetAddWeight,
    "packetRateOn": packetRateOn,
    "packetRate": packetRate,
    "packetTAmount": packetTAmount,
    "packetValue": packetValue,
    "packetPurity": packetPurity,
    "packetTouch": packetTouch,
    "packetSPcnt": packetSPcnt,
    "packetSRate": packetSRate,
    "packetSValue": packetSValue,
    "packetSubLot": packetSubLot,
    "packetSubLotID": packetSubLotID,
    "packetRemarks": packetRemarks,
    "packetHRate": packetHRate,
    "packetHCharges": packetHCharges,
    "packetCut": packetCut,
    "packetClarity": packetClarity,
    "packetColour": packetColour,
    "packetBranch": packetBranch,
    "packetSieve": packetSieve,
  };

  //empty models
  static JewelleryStockPacketData empty() {
    return JewelleryStockPacketData(
      packetSerial: 0,
      itemCid: '',
      itemYear: '',
      itemGroup: '',
      itemInitial: '',
      itemTagNo: '',
      packetId: 0,
      packetInitial: '',
      packetDescription: '',
      packetUnits: '',
      packetType: '',
      packetQuantity: 0,
      packetWeight: 0.0,
      packetAddWeight: 0.0,
      packetRateOn: 'WEIGHT',
      packetRate: 0.0,
      packetTAmount: 0.0,
      packetValue: 0.0,
      packetPurity: 0.0,
      packetTouch: 0.0,
      packetSPcnt: 0.0,
      packetSRate: 0.0,
      packetSValue: 0.0,
      packetHRate: 0.0,
      packetHCharges: 0.0,
      packetRemarks: "",
      packetSubLot: "",
      packetSubLotID: 0,
      packetCut: "",
      packetClarity: "",
      packetColour: "",
      packetBranch: "",
      packetSieve: "",
    );
  }
}
