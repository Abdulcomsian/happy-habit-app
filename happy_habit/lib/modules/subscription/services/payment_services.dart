import 'package:flutter/material.dart';

class PaymentServices extends ChangeNotifier {
  static final PaymentServices _instance = PaymentServices._internal();

  factory PaymentServices() => _instance;

  PaymentServices._internal();

// Your methods and properties here
}
