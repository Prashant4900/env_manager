import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1F2937);
  static const Color primaryDark = Color(0xFF111827);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9CA3AF);

  // Background Colors
  static const Color backgroundDark = Color(0xFF111827);
  static const Color backgroundLight = Color(0xFF1F2937);

  // Accent Colors
  static const Color accent = Color(0xFF3B82F6);
  static const Color accentLight = Color(0xFF60A5FA);

  // State Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // UI Colors
  static const Color border = Color(0xFF374151);
  static const Color divider = Color(0xFF374151);
  static const Color card = Color(0xFF1F2937);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
