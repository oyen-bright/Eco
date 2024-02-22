import 'package:emr_005/controllers/app_scaffold_controller.dart';
import 'package:emr_005/ui/components/banners/notification_banner.dart';
import 'package:emr_005/ui/components/snackbars/notification_snackBar.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtention on BuildContext {
  void showSnackBar(message,
      [BarType snackBarType = BarType.success, SnackBarAction? action]) {
    if (mounted) {
      ScaffoldMessenger.of(this).removeCurrentSnackBar();
      switch (snackBarType) {
        case BarType.error:
          ScaffoldMessenger.of(this).showSnackBar(errorSnackBar(message));
        case BarType.success:
          ScaffoldMessenger.of(this).showSnackBar(successSnackBar(message));
        case BarType.loading:
          ScaffoldMessenger.of(this)
              .showSnackBar(loadingSnackBar(message, null));
        case BarType.action:
          ScaffoldMessenger.of(this)
              .showSnackBar(actionSnackBar(message, action));
      }
    }
  }

  void showBanner(String data, List<Widget> actions) {
    var scaffoldMessenger =
        ScaffoldMessenger.of(read<AppScaffoldController>().key.currentContext!);
    scaffoldMessenger.removeCurrentMaterialBanner();
    scaffoldMessenger.showMaterialBanner(informationBanner(data, actions));
  }

  /// Retrieve the current theme data from the context.
  ///
  /// Usage:
  /// ```dart
  /// ColorScheme colorScheme = context.colorScheme;
  /// ```
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Retrieve the current theme data from the context.˚
  ///
  /// Usage:
  /// ```dart
  /// ThemeData colorScheme = context.colorScheme;
  /// ```
  ThemeData get theme => Theme.of(this);

  /// Retrieve the current text theme from the context.
  ///
  /// Usage:
  /// ```dart
  /// ColorScheme colorScheme = context.theme;
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  dynamic get focus => FocusScope.of(this).nextFocus();
  dynamic get removeFocus => FocusScope.of(this).unfocus();

  Size get viewSize => MediaQuery.of(this).size;
}
