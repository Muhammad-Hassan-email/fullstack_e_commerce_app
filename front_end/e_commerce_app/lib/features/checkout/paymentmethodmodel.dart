import 'package:flutter/material.dart';

// --- Model ---
class PaymentMethod {
  final String type;
  final String label;
  final String? lastFour;
  final IconData icon;

  const PaymentMethod({
    required this.type,
    required this.label,
    this.lastFour,
    required this.icon,
  });
}