import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

extension AssetLoader on String {
  Future<ByteData> loadAssetData() async {
    return await rootBundle.load(this);
  }
}

extension RiveArtboardLoader on String {
  Future<Artboard> loadArtboard() async {
    return RiveFile.import(await rootBundle.load(this)).mainArtboard;
  }
}
