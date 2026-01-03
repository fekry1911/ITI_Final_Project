import 'package:flutter/material.dart';

class AppColors {
  // Modern Indigo Design System
  static const Color primary = Color(0xFF1B737E); // Teal 500 (Original mainColor)
  static const Color primaryDark = Color(0xFF135C65); // Teal 700
  static const Color primaryLight = Color(0xFFE0F2F4); // Teal 50

  static const Color secondary = Color(0xFF10B981); // Emerald 500
  static const Color accent = Color(0xFFF59E0B); // Amber 500

  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100
  static const Color lightGrey = Color(0xFFE2E8F0); // Slate 200 - The requested light grey
  
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color success = Color(0xFF22C55E); // Green 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500

  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400
  
  static const Color border = lightGrey; // Slate 200
  static const Color shadow = Color(0x1A000000); // Black with opacity

  // Legacy mappings for compatibility (to be phased out)
  static Color mainColor = primary;
  static Color secondColor = Color(0xff97dfe8); // Keeping for now if used specifically
  static Color greyColor = textSecondary;
  static Color blackColor = textPrimary;
  static Color whiteColor = surface;
  static Color darkBBlack = Color(0xff1E293B); // Slate 800
  static Color redColor = error;
  static Color strongGrey = Color(0xffA9B2B9);
  static Color formGreyColor = Color(0xffE2E8F0); // Slate 200
  static Color scaffoldColor = background;
  static Color lightGreen = Color(0xff638488);
  static Color badgeColor = Color(0xffF1F5F9); // Slate 100
  
  static const card = surface;
  static const subtitle = textSecondary;
  static const danger = Color(0xFFFEE2E2); // Red 100
  static const postCardColor = Color(0xFFF1F5F9); // Slate 100
}

