// lib/styles/app_styles.dart
import 'package:flutter/material.dart';
import 'theme.dart'; // Import the theme

class AppStyles {
  static final defaultBorderRadius = BorderRadius.circular(24.0);
  static final glowShadow = [
    BoxShadow(
      color: Colors.white.withOpacity(0.3), // Inner white
      blurRadius: 6.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Colors.purple.withOpacity(0.3), // Middle magenta
      blurRadius: 10.0,
      spreadRadius: 6.0,
    ),
    BoxShadow(
      color: Colors.cyan.withOpacity(0.3), // Outer cyan
      blurRadius: 14.0,
      spreadRadius: 9.0,
    ),
  ];

  static BoxDecoration get glassDecor {
    return BoxDecoration(
      color: AppTheme.darkTheme.colorScheme.surface
          .withOpacity(0.2), // Semi-transparent

      // color: Colors.red, // Semi-transparent
      borderRadius: defaultBorderRadius,
      // border: Border.all(color: Colors.white, width: 1.0),
      border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.0),
    );
  }

  static BoxDecoration get bgDecor {
    return BoxDecoration(
      color: AppTheme.darkTheme.colorScheme.surface,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(color: Colors.white, width: 2.0),
    );
  }

  // static TextStyle get textStyle {
  //   return AppTheme.darkTheme.textTheme.bodyLarge!.copyWith(
  //     color: AppTheme.customTextColor,
  //   );
  // }

  // static TextStyle get buttonTextStyle {
  //   return AppTheme.themeData.textTheme.bodyMedium!.copyWith(
  //     color: AppTheme.customTextColor,
  //   );
  // }
}
