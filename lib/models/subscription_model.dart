import 'dart:convert';

import 'package:wallets_control/models/plan_model.dart';

class SubscriptionModel {
  final int id;
  final String startDate;
  final String endDate;
  final PlanModel plan;

  SubscriptionModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.plan,
  });

  SubscriptionModel copyWith({
    int? id,
    String? startDate,
    String? endDate,
    PlanModel? plan,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      plan: plan ?? this.plan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id'],
      startDate: map['start_subscription_date'],
      endDate: map['end_subscription_date'],
      plan: PlanModel.fromMap(map['plan']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) =>
      SubscriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubscriptionModel(id: $id, startDate: $startDate, endDate: $endDate)';

  @override
  bool operator ==(covariant SubscriptionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode => id.hashCode ^ startDate.hashCode ^ endDate.hashCode;
}
