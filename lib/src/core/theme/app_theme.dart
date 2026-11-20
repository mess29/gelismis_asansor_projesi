import 'package:flutter/material.dart';

class AppTheme {
  // Standart Renkler
  static const Color primaryColor = Color(0xFF0D47A1); // Koyu Mavi
  static const Color accentColor = Color(0xFF1976D2);  // Canlı Mavi
  static const Color backgroundColor = Color(0xFFF5F5F5); // Açık Gri Arkaplan
  static const Color surfaceColor = Colors.white; // Kartların rengi
  static const Color errorColor = Color(0xFFD32F2F);   // Kırmızı (Hata)
  static const Color successColor = Color(0xFF388E3C); // Yeşil (Başarı)
  static const Color warningColor = Color(0xFFF57C00); // Turuncu (Uyarı)

  // Metin Renkleri
  static const Color textPrimary = Color(0xFF212121); // Koyu Gri (Başlıklar)
  static const Color textSecondary = Color(0xFF757575); // Orta Gri (Alt metinler)

  // Asansör Kuyusu Yüksek Kontrastlı Saha Renkleri
  static const Color shaftBackground = Color(0xFF121212); // Siyah Arkaplan
  static const Color shaftSurface = Color(0xFF1E1E1E);    // Koyu Gri Kart
  static const Color shaftPrimary = Color(0xFFFFD600);    // Yüksek Görünürlük Sarı
  static const Color shaftOnPrimary = Color(0xFF000000);  // Siyah Metin
  static const Color shaftText = Color(0xFFFFFFFF);       // Beyaz Metin

  static ThemeData getTheme({bool isHighContrastShaftMode = false}) {
    if (isHighContrastShaftMode) {
      return getShaftHighContrastTheme();
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentColor,
        onSecondary: Colors.white,
        error: errorColor,
        onError: Colors.white,
        surface: surfaceColor,
        onSurface: textPrimary,
      ),
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor, size: 28),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54), // Eldivenli kullanıma uygun 54dp
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 3,
        color: surfaceColor,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2.5),
        ),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  static ThemeData getShaftHighContrastTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: shaftPrimary,
        onPrimary: shaftOnPrimary,
        secondary: Color(0xFFFFAB00),
        onSecondary: Colors.black,
        surface: shaftSurface,
        onSurface: shaftText,
        error: Color(0xFFFF5252),
        onError: Colors.black,
      ),
      scaffoldBackgroundColor: shaftBackground,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: shaftSurface,
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(color: shaftPrimary, size: 30),
        titleTextStyle: TextStyle(
          color: shaftPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: shaftPrimary,
          foregroundColor: shaftOnPrimary,
          minimumSize: const Size(double.infinity, 58), // Eldivenli / Tek elle kullanım için 58dp
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontFamily: 'Inter',
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 6,
        color: shaftSurface,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          side: BorderSide(color: shaftPrimary.withValues(alpha: 0.4), width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: shaftPrimary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: shaftPrimary, width: 3),
        ),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: shaftPrimary),
      ),
    );
  }
}