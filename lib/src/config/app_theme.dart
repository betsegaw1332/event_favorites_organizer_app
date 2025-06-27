import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Color scheme
      primaryColor:
          AppStyles
              .primaryColor, // Green for primary elements (e.g., "Travel" button)
      scaffoldBackgroundColor:
          AppStyles.veryLightBlueGrayBackground, // Light blue background
      colorScheme: const ColorScheme.light(
        primary: AppStyles.primaryColor,
        onPrimary: Colors.white, // Text/icon color on primary background
        secondary: AppStyles.almostBlack, // Black for "Create Event" button
        onSecondary: Colors.white, // Text color on "Create Event" button
        surface: Colors.white, // Background for cards or text fields
        onSurface: Color(0xFF333333), // Text color for labels
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppStyles.almostBlack,
        ), // For "Events Reminder" title
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppStyles.almostBlack,
        ), // For labels like "Event Type", "Name"
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppStyles.almostBlack,
        ), // For placeholder text
      ),

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.black, // Black "Create Event" button
          foregroundColor: Colors.white, // Text/icon color on button
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Manrope",
          ),
        ),
      ),

      // Card theme (for event type buttons)
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFD3D3D3)),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: Color(0xFF333333), // Default icon color
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppStyles.veryLightBlueGrayBackground,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
          color: AppStyles.black,
        ),
        iconTheme: IconThemeData(color: AppStyles.black),
      ),

      // Font family
      fontFamily: 'Manrope',
    );
  }
}
