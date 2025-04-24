import 'package:flutter/material.dart';

Widget priceIndicator(num value) {
  return (value ?? 0) > 0
      ? Icon(
          Icons.arrow_drop_up,
          color: Colors.green,
        )
      : Icon(
          Icons.arrow_drop_down,
          color: Colors.red,
        );
}

MaterialColor indicatorColor(num value) {
  return (value ?? 0) > 0 ? Colors.green : Colors.red;
}
