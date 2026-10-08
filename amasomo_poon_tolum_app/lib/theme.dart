import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primary = Color(0xFF006B2C);
const primaryContainer = Color(0xFF00873A);
const onPrimary = Color(0xFFFFFFFF);
const primaryFixed = Color(0xFF7FFC97);
const primaryFixedDim = Color(0xFF62DF7D);
const onPrimaryFixed = Color(0xFF002109);
const onPrimaryFixedVariant = Color(0xFF005320);

const secondary = Color(0xFF855300);
const secondaryContainer = Color(0xFFFEA619);
const onSecondary = Color(0xFFFFFFFF);
const secondaryFixed = Color(0xFFFFDDB8);
const secondaryFixedDim = Color(0xFFFFB95F);
const onSecondaryFixed = Color(0xFF2A1700);
const onSecondaryContainer = Color(0xFF684000);

const tertiary = Color(0xFF006194);
const tertiaryContainer = Color(0xFF007BB9);
const onTertiary = Color(0xFFFFFFFF);
const tertiaryFixed = Color(0xFFCCE5FF);
const tertiaryFixedDim = Color(0xFF93CCFF);
const onTertiaryFixed = Color(0xFF001D31);
const onTertiaryContainer = Color(0xFFFDFCFF);

const surface = Color(0xFFFAF8FF);
const surfaceContainerLowest = Color(0xFFFFFFFF);
const surfaceContainerLow = Color(0xFFF2F3FF);
const surfaceContainer = Color(0xFFEAEDFF);
const surfaceContainerHigh = Color(0xFFE2E7FF);
const surfaceContainerHighest = Color(0xFFDAE2FD);
const onSurface = Color(0xFF131B2E);
const onSurfaceVariant = Color(0xFF3E4A3D);
const outline = Color(0xFF6E7B6C);
const outlineVariant = Color(0xFFBDCABA);

const errorColor = Color(0xFFBA1A1A);
const errorContainer = Color(0xFFFFDAD6);
const onError = Color(0xFFFFFFFF);
const onErrorContainer = Color(0xFF93000A);

ThemeData buildTheme() {
  final base = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: Color(0xFFF7FFF2),
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: errorColor,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: surface,
  );
  return base.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
  );
}
