import 'dart:convert';

MetalMasterModel metalMasterModelFromJson(String str) =>
    MetalMasterModel.fromJson(json.decode(str));

String metalMasterModelToJson(MetalMasterModel data) =>
    json.encode(data.toJson());

double? doubleParser(value, [int? decimal]) {
  if (value == null || value == "0") return 0.0;
  double? parsedValue =
  value is double ? value : double.tryParse(value.toString());
  return double.tryParse(
      parsedValue == null ? "0" : parsedValue.toStringAsFixed(decimal ?? 3));
}
class MetalMasterModel {
  final String? stoneCid;
  final int? stoneId;
  final String? stoneType;
  final String? stoneName;
  final String? stoneAlias;
  final String? stoneUnits;
  final int? pAccountID;
  final int? sAccountID;
  final int? stoneCreditPcs;
  final String? stoneFlag;
  final String? stoneICode;
  final String? stoneIInitial;
  final String? stoneECode;
  final String? stoneEInitial;
  final String? stoneHsnCode;
  final int? stoneDecimal;
  final double? stoneSgst;
  final double? stoneCgst;
  final double? stoneIgst;
  final String? pAccountDescription;
  final String? sAccountDescription;

  MetalMasterModel({
    this.stoneCid,
    this.stoneId,
    this.stoneType,
    this.stoneName,
    this.stoneAlias,
    this.stoneUnits,
    this.pAccountID,
    this.sAccountID,
    this.stoneCreditPcs,
    this.stoneFlag,
    this.stoneICode,
    this.stoneIInitial,
    this.stoneECode,
    this.stoneEInitial,
    this.stoneHsnCode,
    this.stoneDecimal,
    this.stoneSgst,
    this.stoneCgst,
    this.stoneIgst,
    this.pAccountDescription,
    this.sAccountDescription,
  });

  factory MetalMasterModel.fromJson(Map<String, dynamic> json) =>
      MetalMasterModel(
        stoneCid: json["stoneCID"],
        stoneId: json["stoneID"],
        stoneType: json["stoneType"],
        stoneName: json["stoneName"],
        stoneAlias: json["stoneAlias"],
        stoneUnits: json["stoneUnits"],
        pAccountID: json["pAccountID"],
        sAccountID: json["sAccountID"],
        stoneCreditPcs: json["stoneCreditPcs"],
        stoneFlag: json["stoneFlag"],
        stoneICode: json["stoneICode"],
        stoneIInitial: json["stoneIInitial"],
        stoneECode: json["stoneECode"],
        stoneEInitial: json["stoneEInitial"],
        stoneHsnCode: json["stoneHSNCode"],
        stoneDecimal: json["stoneDecimal"] is int
            ? json["stoneDecimal"]
            : int.tryParse(json["stoneDecimal"] ?? ""),
        stoneSgst: doubleParser(
          json["stoneSGST"],
        ),
        stoneCgst: doubleParser(
          json["stoneCGST"],
        ),
        stoneIgst: doubleParser(
          json["stoneIGST"],
        ),
        pAccountDescription: json["pAccountDescription"],
        sAccountDescription: json["sAccountDescription"],
      );

  Map<String, dynamic> toJson() => {
    "stoneCID": stoneCid,
    "stoneID": stoneId,
    "stoneType": stoneType,
    "stoneName": stoneName,
    "stoneAlias": stoneAlias,
    "stoneUnits": stoneUnits,
    "pAccountID": pAccountID,
    "sAccountID": sAccountID,
    "stoneCreditPcs": stoneCreditPcs,
    "stoneFlag": stoneFlag,
    "stoneICode": stoneICode,
    "stoneIInitial": stoneIInitial,
    "stoneECode": stoneECode,
    "stoneEInitial": stoneEInitial,
    "stoneHSNCode": stoneHsnCode,
    "stoneDecimal": stoneDecimal,
    "stoneSGST": stoneSgst,
    "stoneCGST": stoneCgst,
    "stoneIGST": stoneIgst,
    "pAccountDescription": pAccountDescription,
    "sAccountDescription": sAccountDescription,
  };
}
