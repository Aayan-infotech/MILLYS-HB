import 'package:flutter/material.dart';

class Coupon {
  String id;
  String code;
  int discountValue;
  DateTime expiryDate;
  int useLimit;
  bool isActive;

  Coupon({
    required this.id,
    required this.code,
    required this.discountValue,
    required this.expiryDate,
    required this.useLimit,
    required this.isActive,
  });

  // Factory method to create a Discount object from JSON
  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['_id'],
      code: json['code'],
      discountValue: json['discountValue'],
      expiryDate: DateTime.parse(json['expiryDate']),
      useLimit: json['useLimit'],
      isActive: json['isActive'],
    );
  }

  // Method to convert a Discount object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'discountValue': discountValue,
      'expiryDate': expiryDate.toIso8601String(),
      'useLimit': useLimit,
      'isActive': isActive,
    };
  }
}
