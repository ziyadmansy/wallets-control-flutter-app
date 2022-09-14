import 'dart:convert';

class WalletModel {
  final int id;
  final String name;
  final String imgUrl;
  final int color;
  final String number;
  final double spentBalance;
  final double remainingBalance;
  final bool isActivated;

  WalletModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.color,
    required this.number,
    required this.spentBalance,
    required this.remainingBalance,
    required this.isActivated,
  });

  WalletModel copyWith({
    int? id,
    String? name,
    String? imgUrl,
    int? color,
    String? number,
    double? spentBalance,
    double? remainingBalance,
    bool? isActivated,
  }) {
    return WalletModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      color: color ?? this.color,
      number: number ?? this.number,
      spentBalance: spentBalance ?? this.spentBalance,
      remainingBalance: remainingBalance ?? this.remainingBalance,
      isActivated: isActivated ?? this.isActivated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'color': color,
      'number': number,
      'spentBalance': spentBalance,
      'remainingBalance': remainingBalance,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      color: map['color']?.toInt() ?? 0,
      number: map['number'] ?? '',
      spentBalance: map['spentBalance']?.toDouble() ?? 0.0,
      remainingBalance: map['remainingBalance']?.toDouble() ?? 0.0,
      isActivated: map['isActivated'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(id: $id, name: $name, imgUrl: $imgUrl, color: $color, number: $number, spentBalance: $spentBalance, remainingBalance: $remainingBalance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletModel &&
        other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.color == color &&
        other.number == number &&
        other.spentBalance == spentBalance &&
        other.remainingBalance == remainingBalance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        color.hashCode ^
        number.hashCode ^
        spentBalance.hashCode ^
        remainingBalance.hashCode;
  }
}
