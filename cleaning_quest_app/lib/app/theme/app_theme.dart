import 'package:flutter/material.dart';

class AppTheme {
  // ギルド風カラーパレット
  static const Color guildBrown = Color(0xFF4A2C2A);
  static const Color guildBrownDark = Color(0xFF3E2723);
  static const Color guildBrownLight = Color(0xFF6D4C41);
  static const Color guildBeige = Color(0xFF8D6E63);

  static const Color guildGold = Color(0xFFFFD700);
  static const Color guildOrange = Color(0xFFFFA500);

  static const Color paperYellow = Color(0xFFFFF8E1);
  static const Color paperYellowLight = Color(0xFFFFECB3);

  static const Color completedGreen = Color(0xFFE8F5E8);
  static const Color completedGreenDark = Color(0xFFC8E6C9);

  static const Color urgentRed = Color(0xFFFFEBEE);
  static const Color urgentRedDark = Color(0xFFFFCDD2);

  static const Color textDark = Color(0xFF3E2723);
  static const Color textMedium = Color(0xFF5D4037);
  static const Color textLight = Color(0xFFD7CCC8);

  // メインテーマ
  static ThemeData get guildTheme {
    return ThemeData(
      useMaterial3: true,

      // カラースキーム
      colorScheme: ColorScheme.dark(
        primary: guildGold,
        secondary: guildOrange,
        surface: guildBrown,
        error: urgentRedDark,
        onPrimary: textDark,
        onSecondary: textDark,
        onSurface: textLight,
      ),

      // スキャフォールド背景
      scaffoldBackgroundColor: guildBrown,

      // AppBar テーマ
      appBarTheme: AppBarTheme(
        backgroundColor: guildBrownLight,
        foregroundColor: guildGold,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: guildGold,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.7),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),

      // カードテーマ
      cardTheme: CardThemeData(
        color: paperYellow,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: guildBeige, width: 3),
        ),
      ),

      // ボタンテーマ
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: guildGold,
          foregroundColor: textDark,
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),

      // アウトラインボタン
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: guildGold,
          side: BorderSide(color: guildGold, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

      // テキストテーマ
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: guildGold,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: guildGold,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: guildGold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textMedium,
        ),
        bodyLarge: TextStyle(fontSize: 14, color: textMedium),
        bodyMedium: TextStyle(fontSize: 13, color: textMedium),
        bodySmall: TextStyle(fontSize: 11, color: textMedium),
      ),

      // 入力装飾テーマ
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: paperYellow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: guildBeige, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: guildBeige, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: guildGold, width: 2),
        ),
      ),

      // アイコンテーマ
      iconTheme: const IconThemeData(color: guildGold, size: 24),

      // Divider テーマ
      dividerTheme: DividerThemeData(
        color: guildBeige.withValues(alpha: .5),
        thickness: 2,
      ),

      // プログレスインジケーター
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: guildGold,
      ),
    );
  }

  // ボックスデコレーション（よく使うスタイル）

  // 羊皮紙カード
  static BoxDecoration get paperCard => BoxDecoration(
    gradient: const LinearGradient(
      colors: [paperYellow, paperYellowLight],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(color: guildBeige, width: 2),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // 完了カード（緑）
  static BoxDecoration get completedCard => BoxDecoration(
    gradient: const LinearGradient(
      colors: [completedGreen, completedGreenDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(color: const Color(0xFF4CAF50), width: 2),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // 緊急カード（赤）
  static BoxDecoration get urgentCard => BoxDecoration(
    gradient: const LinearGradient(
      colors: [urgentRed, urgentRedDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(color: const Color(0xFFF44336), width: 2),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFFF44336).withValues(alpha: .3),
        blurRadius: 15,
        offset: const Offset(0, 0),
      ),
    ],
  );

  // ギルド背景パネル
  static BoxDecoration get guildPanel => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        guildBrownLight.withValues(alpha: .8),
        const Color(0xFF795548).withValues(alpha: .9),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(color: guildBeige, width: 3),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .3),
        blurRadius: 12,
        offset: const Offset(0, 5),
      ),
    ],
  );

  // 金色のバッジ
  static BoxDecoration get goldBadge => BoxDecoration(
    gradient: const LinearGradient(
      colors: [guildGold, guildOrange],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(color: const Color(0xFFFF8F00), width: 1),
    borderRadius: BorderRadius.circular(20),
  );

  // テキストシャドウ（金色）
  static List<Shadow> get goldTextShadow => [
    Shadow(
      color: Colors.black.withValues(alpha: .7),
      offset: const Offset(2, 2),
      blurRadius: 4,
    ),
  ];
}
