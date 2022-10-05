import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallets_control/shared/constants.dart';

class WalletBrandModel {
  final int id;
  final String name;
  final String imgUrl;
  final String color;
  final double sendMonthlyLimit;
  final double receiveMonthlyLimit;

  WalletBrandModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.color,
    required this.sendMonthlyLimit,
    required this.receiveMonthlyLimit,
  });

  WalletBrandModel copyWith({
    int? id,
    String? name,
    String? imgUrl,
    String? color,
    double? spentBalance,
    double? remainingBalance,
  }) {
    return WalletBrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      color: color ?? this.color,
      sendMonthlyLimit: spentBalance ?? this.sendMonthlyLimit,
      receiveMonthlyLimit: remainingBalance ?? this.receiveMonthlyLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'color': color,
      'spentBalance': sendMonthlyLimit,
      'remainingBalance': receiveMonthlyLimit,
    };
  }

  factory WalletBrandModel.fromMap(Map<String, dynamic> map) {
    return WalletBrandModel(
      id: map['id']?.toInt() ?? 0,
      name: map['brand_name_en'] ?? '',
      imgUrl: '$imgBaseUrl/${map['image']}',
      color: map['main_color'],
      sendMonthlyLimit: map['send_monthly_limit']?.toDouble() ?? 0.0,
      receiveMonthlyLimit: map['receive_monthly_limit']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletBrandModel.fromJson(String source) =>
      WalletBrandModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(id: $id, name: $name, imgUrl: $imgUrl, color: $color, spentBalance: $sendMonthlyLimit, remainingBalance: $receiveMonthlyLimit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletBrandModel &&
        other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.color == color &&
        other.sendMonthlyLimit == sendMonthlyLimit &&
        other.receiveMonthlyLimit == receiveMonthlyLimit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        color.hashCode ^
        sendMonthlyLimit.hashCode ^
        receiveMonthlyLimit.hashCode;
  }
}
