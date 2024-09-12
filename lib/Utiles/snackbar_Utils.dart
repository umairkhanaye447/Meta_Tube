import 'package:flutter/material.dart';
import 'package:metatube/Utiles/App_themes.dart';

class SnackBarUtils {
  static void showSnackbar(BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(
          icon,
          color: AppTheme.accent,
        ),
        Text(message),
      ],
    )));
  }
}
