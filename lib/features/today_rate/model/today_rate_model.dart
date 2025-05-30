class MetalRate {
  final String id;
  final String date;
  final String metalType;
  final Map<String, String> purchaseRate;
  final Map<String, String> sellingRate;

  MetalRate({
    required this.id,
    required this.date,
    required this.metalType,
    required this.purchaseRate,
    required this.sellingRate,
  });

  factory MetalRate.fromMap(Map<String, dynamic> map) {
    return MetalRate(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      metalType: map['metalType'] ?? '',
      purchaseRate: Map<String, String>.from(map['purchaseRate'] ?? {}),
      sellingRate: Map<String, String>.from(map['sellingRate'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'metalType': metalType,
      'purchaseRate': purchaseRate,
      'sellingRate': sellingRate,
    };
  }

  MetalRate copyWith({
    String? id,
    String? date,
    String? metalType,
    Map<String, String>? purchaseRate,
    Map<String, String>? sellingRate,
  }) {
    return MetalRate(
      id: id ?? this.id,
      date: date ?? this.date,
      metalType: metalType ?? this.metalType,
      purchaseRate: purchaseRate ?? this.purchaseRate,
      sellingRate: sellingRate ?? this.sellingRate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetalRate && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
