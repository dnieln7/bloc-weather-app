import 'package:flutter/material.dart';

class AppTexts {

  // Display

  static TextStyle displayMedium(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium ??
        const TextStyle(fontSize: 45, fontWeight: FontWeight.w400);
  }

  // Headline

  static TextStyle headlineLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge ??
        const TextStyle(fontSize: 32, fontWeight: FontWeight.w400);
  }

  static TextStyle headlineMedium(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium ??
        const TextStyle(fontSize: 28, fontWeight: FontWeight.w400);
  }

  static TextStyle headlineSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall ??
        const TextStyle(fontSize: 24, fontWeight: FontWeight.w400);
  }

  // Title

  static TextStyle titleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge ??
        const TextStyle(fontSize: 22, fontWeight: FontWeight.w400);
  }

  static TextStyle titleMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  }

  static TextStyle titleSmall(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  }
}
