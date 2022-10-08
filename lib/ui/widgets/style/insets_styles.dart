import 'package:flutter/material.dart';

class InsetsStyles {
  static EdgeInsets globalPadding(BuildContext context, Orientation orientation) {
    double verticalMultiplier;
    double horizontalMultiplier;

    if (orientation == Orientation.portrait) {
      verticalMultiplier = 0.10;
      horizontalMultiplier = 0.05;
    } else {
      verticalMultiplier = 0.05;
      horizontalMultiplier = 0.02;
    }

    return EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * verticalMultiplier,
      horizontal: MediaQuery.of(context).size.width * horizontalMultiplier,
    );
  }
}
