import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final String label;
  final bool isCart;

  const NavItem({
    required this.icon,
    required this.label,
    this.isCart = false,
  });
}