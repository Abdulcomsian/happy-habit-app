import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  void popUntil(String name) {
    Navigator.popUntil(this, ModalRoute.withName(name));
  }
}
