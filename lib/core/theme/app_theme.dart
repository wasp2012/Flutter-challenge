import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF000014),
    appBarTheme: const AppBarTheme(color: Color(0xFF141428)),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF14283c)),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1),
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        return GoogleFonts.inter(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: states.contains(MaterialState.selected)
              ? FontWeight.w600
              : FontWeight.w500,
        );
      }),
    ),
  );
}
