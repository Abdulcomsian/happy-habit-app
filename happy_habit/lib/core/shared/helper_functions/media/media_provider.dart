import 'package:flutter/material.dart';
import 'package:happy_habit/core/shared/helper_functions/media/media_networking.dart';

class MediaProvider extends ChangeNotifier {
  static final MediaProvider _instance = MediaProvider._internal();

  factory MediaProvider() => _instance;

  MediaProvider._internal();

  // Your methods and properties here
  final _networkingLayer = MediaNetworking();

  Map<String, String> get musics => _musics;
  Map<String, String> _musics = {};

  Future<void> getMusics() async {
    _musics = await _networkingLayer.getMusics() ?? {};
  }
}
