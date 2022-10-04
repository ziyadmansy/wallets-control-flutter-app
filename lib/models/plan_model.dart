class PlanModel {
  final int id;
  final String planNameEn;
  final String planNameAr;
  final int amount;
  final String expiry;
  final int walletsLimit;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  PlanModel({
    required this.id,
    required this.planNameEn,
    required this.planNameAr,
    required this.amount,
    required this.expiry,
    required this.walletsLimit,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      planNameEn: json['plan_name_en'],
      planNameAr: json['plan_name_ar'],
      amount: json['amount'],
      expiry: json['expiry'],
      walletsLimit: json['wallets_limit'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_name_en'] = this.planNameEn;
    data['plan_name_ar'] = this.planNameAr;
    data['amount'] = this.amount;
    data['expiry'] = this.expiry;
    data['wallets_limit'] = this.walletsLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
