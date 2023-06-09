import 'package:flutter/material.dart';

class CustomLinearGradient {
  final Color Primary, Secondary;
  CustomLinearGradient({required this.Primary, required this.Secondary});
  LinearGradient Custom() {
    return LinearGradient(
        colors: [Primary, Secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
  }
}
