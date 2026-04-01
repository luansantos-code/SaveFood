import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// AppTheme centraliza TODAS as definições visuais do app.
// Assim, se você quiser mudar uma cor, muda só aqui e afeta o app inteiro!
class AppTheme {
  // --- Paleta de Cores ---
  static const Color primaryGreen = Color(0xFF2E7D32);    // Verde escuro
  static const Color lightGreen = Color(0xFF66BB6A);      // Verde suave
  static const Color accentOrange = Color(0xFFF57C00);    // Laranja vibrante
  static const Color background = Color(0xFFF4F6F4);      // Fundo levemente verde
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1B2A1E);
  static const Color textGrey = Color(0xFF757575);

  // --- Gradiente usado no header das telas ---
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B5E20), Color(0xFF43A047)],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        secondary: accentOrange,
        background: background,
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,

      // Tipografia com a fonte Poppins (moderna e legível)
      textTheme: GoogleFonts.poppinsTextTheme(),

      appBarTheme: AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Estilo padrão dos botões principais
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Estilo padrão dos campos de texto (TextField)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDCE8DC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDCE8DC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
