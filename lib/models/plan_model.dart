import 'dart:convert';

class PlanModel {
  final int id;
  final String planName;
  final double amount;
  final String expiry;
  final int walletsLimit;
  final String createdAt;
  PlanModel({
    required this.id,
    required this.planName,
    required this.amount,
    required this.expiry,
    required this.walletsLimit,
    required this.createdAt,
  });

  PlanModel copyWith({
    int? id,
    String? planName,
    double? amount,
    String? expiry,
    int? walletsLimit,
    String? createdAt,
  }) {
    return PlanModel(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      amount: amount ?? this.amount,
      expiry: expiry ?? this.expiry,
      walletsLimit: walletsLimit ?? this.walletsLimit,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'planName': planName,
      'amount': amount,
      'expiry': expiry,
      'walletsLimit': walletsLimit,
      'createdAt': createdAt,
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      id: map['id'],
      planName: map['plan_name_en'],
      amount: double.parse(map['amount'].toString()),
      expiry: map['expiry'],
      walletsLimit: map['wallets_limit'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanModel.fromJson(String source) => PlanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlanModel(id: $id, planName: $planName, amount: $amount, expiry: $expiry, walletsLimit: $walletsLimit, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant PlanModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.planName == planName &&
      other.amount == amount &&
      other.expiry == expiry &&
      other.walletsLimit == walletsLimit &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      planName.hashCode ^
      amount.hashCode ^
      expiry.hashCode ^
      walletsLimit.hashCode ^
      createdAt.hashCode;
  }
}
