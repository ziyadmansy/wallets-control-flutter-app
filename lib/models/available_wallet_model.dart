import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallets_control/shared/constants.dart';

class AvailableWalletModel {
  final int id;
  final String name;
  final String imgUrl;
  final Color color;
  final double sendMonthlyLimit;
  final double receiveMonthlyLimit;

  AvailableWalletModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.color,
    required this.sendMonthlyLimit,
    required this.receiveMonthlyLimit,
  });

  AvailableWalletModel copyWith({
    int? id,
    String? name,
    String? imgUrl,
    Color? color,
    double? spentBalance,
    double? remainingBalance,
  }) {
    return AvailableWalletModel(
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

  factory AvailableWalletModel.fromMap(Map<String, dynamic> map) {
    return AvailableWalletModel(
      id: map['id']?.toInt() ?? 0,
      name: map['brand_name_en'] ?? '',
      imgUrl: '$imgBaseUrl/${map['image']}',
      color: map['main_color']?.toInt() ?? 0,
      sendMonthlyLimit: map['send_monthly_limit']?.toDouble() ?? 0.0,
      receiveMonthlyLimit: map['receive_monthly_limit']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableWalletModel.fromJson(String source) =>
      AvailableWalletModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(id: $id, name: $name, imgUrl: $imgUrl, color: $color, spentBalance: $sendMonthlyLimit, remainingBalance: $receiveMonthlyLimit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvailableWalletModel &&
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
