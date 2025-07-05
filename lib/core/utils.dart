import 'package:flutter/material.dart';

class Utils {
  static Color getTileColor(int value) {
    switch (value) {
      case 0:
        return Color(0xFFCDC1B4);
      case 2:
        return Color(0xFFEEE4DA);
      case 4:
        return Color(0xFFEDE0C8);
      case 8:
        return Color(0xFFF2B179);
      case 16:
        return Color(0xFFF59563);
      case 32:
        return Color(0xFFF67C5F);
      case 64:
        return Color(0xFFF65E3B);
      case 128:
        return Color(0xFFEDCF72);
      case 256:
        return Color(0xFFEDCC61);
      case 512:
        return Color(0xFFEDC850);
      case 1024:
        return Color(0xFFEDC53F);
      case 2048:
        return Color(0xFFEDC22E);
      default:
        return Color(0xFF3C3A32);
    }
  }

  static Color getTextColor(int value) {
    return value <= 4 ? Color(0xFF776E65) : Colors.white;
  }

  static double getFontSize(int value) {
    if (value == 0) return 0;
    if (value < 100) return 32;
    if (value < 1000) return 28;
    return 24;
  }
}
