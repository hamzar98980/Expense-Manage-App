import 'package:flutter/material.dart';

class ConstColor {
  ConstColor._();

  // ignore: constant_identifier_names — names requested for design tokens
  static const Color Primarycolor = Color(0xFF000000);
  // ignore: constant_identifier_names
  static const Color Secondaycolor = Color(0xFFFFFFFF);

  static const Color Thirdcolor = Color(0xFFF5F3F1);

  static const Color Fourthcolor = Color(0xFFCBFD13);

  /// Bottom navigation (see app bottom bar design).
  static const Color bottomNavActive = Color(0xFF1A1C24);
  static const Color bottomNavInactive = Color(0xFF8E94A3);
  static const Color bottomNavTopBorder = Color(0xFFE8EAEF);
}
