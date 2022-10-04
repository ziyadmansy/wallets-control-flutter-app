import 'dart:convert';

class UserWalletModel {
  final int id;
  final int brandId;
  final String walletNumber;
  final double balance;
  final double receiveLimitRemaining;
  final double sendLimitRemaining;

  UserWalletModel({
    required this.id,
    required this.brandId,
    required this.walletNumber,
    required this.balance,
    required this.receiveLimitRemaining,
    required this.sendLimitRemaining,
  });

  UserWalletModel copyWith({
    int? id,
    int? brandId,
    String? walletNumber,
    double? balance,
    double? receiveLimitRemaining,
    double? sendLimitRemaining,
  }) {
    return UserWalletModel(
      id: id ?? this.id,
      brandId: brandId ?? this.brandId,
      walletNumber: walletNumber ?? this.walletNumber,
      balance: balance ?? this.balance,
      receiveLimitRemaining:
          receiveLimitRemaining ?? this.receiveLimitRemaining,
      sendLimitRemaining: sendLimitRemaining ?? this.sendLimitRemaining,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'brandId': brandId,
      'walletNumber': walletNumber,
      'balance': balance,
      'receiveLimitRemaining': receiveLimitRemaining,
      'sendLimitRemaining': sendLimitRemaining,
    };
  }

  factory UserWalletModel.fromMap(Map<String, dynamic> map) {
    return UserWalletModel(
      id: map['id'],
      brandId: map['brand_id'],
      walletNumber: map['phone_number'],
      balance: double.parse(map['balance'].toString()),
      receiveLimitRemaining: double.parse(map['receive_limit_remaining']),
      sendLimitRemaining: double.parse(map['send_limit_remaining']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserWalletModel.fromJson(String source) =>
      UserWalletModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserWalletModel(id: $id, brandId: $brandId, walletNumber: $walletNumber, balance: $balance, receiveLimitRemaining: $receiveLimitRemaining, sendLimitRemaining: $sendLimitRemaining)';
  }

  @override
  bool operator ==(covariant UserWalletModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.brandId == brandId &&
        other.walletNumber == walletNumber &&
        other.balance == balance &&
        other.receiveLimitRemaining == receiveLimitRemaining &&
        other.sendLimitRemaining == sendLimitRemaining;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        brandId.hashCode ^
        walletNumber.hashCode ^
        balance.hashCode ^
        receiveLimitRemaining.hashCode ^
        sendLimitRemaining.hashCode;
  }
}
