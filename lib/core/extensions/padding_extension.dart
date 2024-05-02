import 'package:flutter/material.dart';

extension PaddingWidget on Widget {
  Widget padding(double horizontal, double vertical) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }
}
