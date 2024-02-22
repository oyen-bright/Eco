import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/theme/w3m_text_styles.dart';
import 'package:web3modal_flutter/theme/w3m_theme.dart';

final walletConnectModalTheme = Web3ModalThemeData(
  lightColors: Web3ModalColors.lightMode.copyWith(
    accent100: AppColors.primaryColor,
  ),
  darkColors: Web3ModalColors.darkMode.copyWith(
    accent100: AppColors.primaryColor,
    background125: Colors.brown,
  ),
  textStyles: const Web3ModalTextStyles(
    fontFamily: 'poppins',
    title400: TextStyle(
      fontFamily: 'poppins',
      letterSpacing: -0.04,
      fontWeight: FontWeight.w400,
      fontSize: 24.0,
    ),
    title500: TextStyle(
      fontFamily: 'poppins',
      letterSpacing: -0.04,
      fontWeight: FontWeight.w500,
      fontSize: 24.0,
    ),
    title600: TextStyle(
      fontFamily: 'poppins',
      letterSpacing: -0.04,
      fontWeight: FontWeight.w600,
      fontSize: 24.0,
    ),
    large400: TextStyle(
      fontFamily: 'poppins',
      fontSize: 20.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w400,
    ),
    large500: TextStyle(
      fontFamily: 'poppins',
      fontSize: 20.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w500,
    ),
    large600: TextStyle(
      fontFamily: 'poppins',
      fontSize: 20.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w600,
    ),
    paragraph400: TextStyle(
      fontFamily: 'poppins',
      fontSize: 16.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w400,
    ),
    paragraph500: TextStyle(
      fontFamily: 'poppins',
      fontSize: 16.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w500,
    ),
    paragraph600: TextStyle(
      fontFamily: 'poppins',
      fontSize: 16.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w600,
    ),
    small400: TextStyle(
      fontFamily: 'poppins',
      fontSize: 14.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w400,
    ),
    small500: TextStyle(
      fontFamily: 'poppins',
      fontSize: 14.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w500,
    ),
    small600: TextStyle(
      fontFamily: 'poppins',
      fontSize: 14.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w600,
    ),
    tiny400: TextStyle(
      fontFamily: 'poppins',
      fontSize: 12.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w400,
    ),
    tiny500: TextStyle(
      fontFamily: 'poppins',
      fontSize: 12.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w500,
    ),
    tiny600: TextStyle(
      fontFamily: 'poppins',
      fontSize: 12.0,
      letterSpacing: -0.04,
      fontWeight: FontWeight.w600,
    ),
    micro600: TextStyle(
      fontFamily: 'poppins',
      fontSize: 10.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.02,
    ),
    micro700: TextStyle(
      fontFamily: 'poppins',
      fontSize: 10.0,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.02,
    ),
  ),
  radiuses: const Web3ModalRadiuses(
      radiusS: AppConstants.borderRadius, radiusM: AppConstants.borderRadius),
);

final walletConnectButtonTheme = Web3ModalThemeData(
    lightColors: Web3ModalColors.lightMode.copyWith(
  accent100: Colors.black,
));
