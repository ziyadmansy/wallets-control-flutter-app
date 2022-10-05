import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wallets_control/models/subscription_model.dart';

import 'package:wallets_control/models/user_wallet_model.dart';

class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String createdAt;
  final String phone;
  final String mainWalletPhone;
  final String appLang;
  final String? fcmToken;
  final String? uuid;
  final String? os;
  final String? osVersion;
  final String? model;
  final List<UserWalletModel> wallets;
  final List<SubscriptionModel> subscriptions;
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.phone,
    required this.mainWalletPhone,
    required this.appLang,
    this.fcmToken,
    this.uuid,
    this.os,
    this.osVersion,
    this.model,
    required this.wallets,
    required this.subscriptions,
  });

  ProfileModel copyWith({
    int? id,
    String? name,
    String? email,
    String? createdAt,
    String? phone,
    String? mainWalletPhone,
    String? appLang,
    String? fcmToken,
    String? uuid,
    String? os,
    String? osVersion,
    String? model,
    List<UserWalletModel>? wallets,
    List<SubscriptionModel>? subscriptions,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      phone: phone ?? this.phone,
      mainWalletPhone: mainWalletPhone ?? this.mainWalletPhone,
      appLang: appLang ?? this.appLang,
      fcmToken: fcmToken ?? this.fcmToken,
      uuid: uuid ?? this.uuid,
      os: os ?? this.os,
      osVersion: osVersion ?? this.osVersion,
      model: model ?? this.model,
      wallets: wallets ?? this.wallets,
      subscriptions: subscriptions ?? this.subscriptions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'phone': phone,
      'mainWalletPhone': mainWalletPhone,
      'appLang': appLang,
      'fcmToken': fcmToken,
      'uuid': uuid,
      'os': os,
      'osVersion': osVersion,
      'model': model,
      'wallets': wallets.map((x) => x.toMap()).toList(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      createdAt: map['created_at'],
      phone: map['phone'] as String,
      mainWalletPhone: map['main_wallet_phone'],
      appLang: map['app_lang'],
      fcmToken: map['fcm_token'],
      uuid: map['uuid'],
      os: map['os'],
      osVersion: map['os_version'],
      model: map['model'],
      wallets: (map['wallets'] as List)
          .map((wallet) => UserWalletModel.fromMap(wallet))
          .toList(),
      subscriptions: (map['subscriptions'] as List)
          .map((sub) => SubscriptionModel.fromMap(sub))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, email: $email, createdAt: $createdAt, phone: $phone, mainWalletPhone: $mainWalletPhone, appLang: $appLang, fcmToken: $fcmToken, uuid: $uuid, os: $os, osVersion: $osVersion, model: $model, wallets: $wallets, subscriptions: $subscriptions)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.phone == phone &&
        other.mainWalletPhone == mainWalletPhone &&
        other.appLang == appLang &&
        other.fcmToken == fcmToken &&
        other.uuid == uuid &&
        other.os == os &&
        other.osVersion == osVersion &&
        other.model == model &&
        listEquals(other.wallets, wallets);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        createdAt.hashCode ^
        phone.hashCode ^
        mainWalletPhone.hashCode ^
        appLang.hashCode ^
        fcmToken.hashCode ^
        uuid.hashCode ^
        os.hashCode ^
        osVersion.hashCode ^
        model.hashCode ^
        wallets.hashCode;
  }
}
