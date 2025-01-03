import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  static final HomeProvider _instance = HomeProvider._internal();

  factory HomeProvider() => _instance;

  HomeProvider._internal();

// Your methods and properties here
}
