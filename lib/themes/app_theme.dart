/*
  App's themes (both light and dark theme).
  Make use of the colors and text styles already defined.
 */

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: colorScheme,
        appBarTheme: appBarTheme,
        tabBarTheme: tabBarTheme,
        dividerTheme: dividerThemeData,
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: elevatedButtonThemeData,
        bannerTheme: materialBannerTheme,
        // scrollbarTheme: _scrollbarThemeData,
        bottomNavigationBarTheme: bottomNavigationBarThemeData);
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      foregroundColor: colorScheme.primary,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  static ColorScheme get colorScheme {
    return const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColors.secondaryColor,
        tertiary: Color(0xFF8EB7FF),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black);
  }

  static DividerThemeData get dividerThemeData {
    return DividerThemeData(color: colorScheme.primary);
  }

  static MaterialBannerThemeData get materialBannerTheme {
    return MaterialBannerThemeData(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        elevation: 2,
        dividerColor: colorScheme.primary);
  }

  static BottomNavigationBarThemeData get bottomNavigationBarThemeData {
    return const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.inActiveBottomNavigationColor,
        backgroundColor: AppColors.secondaryColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        enableFeedback: true,
        elevation: 10,
        selectedLabelStyle: AppTextStyles.selectedLabelStyle,
        unselectedLabelStyle: AppTextStyles.unselectedLabelStyle);
  }

  static ElevatedButtonThemeData get elevatedButtonThemeData {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
    ));
  }

  static TabBarTheme get tabBarTheme {
    return TabBarTheme(
      unselectedLabelColor: colorScheme.background,
      labelColor: colorScheme.primary,
      labelStyle: AppTextStyles.tabBarLabelTextStyle,
      indicator: const BoxDecoration(color: Colors.red),
      indicatorColor: Colors.yellow,
    );
  }

  // static ScrollbarThemeData get _scrollbarThemeData {
  //   return ScrollbarThemeData(
  //       thickness: MaterialStateProperty.all(40),
  //       thumbColor: MaterialStateProperty.all(AppColors.primaryColor));
  // }
}
