import 'package:happy_habit/core/constants/asset_paths.dart';

import 'package:happy_habit/core/constants/asset_paths.dart';

import 'package:happy_habit/core/constants/asset_paths.dart';

class StoreItem {
  final num price;
  final String tag, name, label, imageUrl;

  const StoreItem({
    required this.tag,
    required this.price,
    required this.name,
    required this.label,
    required this.imageUrl,
  });

  factory StoreItem.fromJson(Map<String, dynamic> json) {
    return StoreItem(
      tag: json['tag'],
      name: json['name'],
      price: json['price'],
      label: json['label'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<StoreItem> accessories = [
    StoreItem(tag: 'SALE', price: 55, name: 'Accu-check Active', label: 'Test Strip', imageUrl: DummyIcons.glasses),
    StoreItem(tag: '15% OFF', price: 55, name: 'Omron HEM-8712', label: 'BP Monitor', imageUrl: DummyIcons.glasses),
    StoreItem(tag: 'SALE', price: 55, name: 'Accu-check Active', label: 'Test Strip', imageUrl: DummyIcons.glasses),
    ];

  static List<StoreItem> outfits = [
    StoreItem(tag: 'SALE', price: 55, name: 'Accu-check Active', label: 'Test Strip', imageUrl: DummyIcons.suit),
    StoreItem(tag: '15% OFF', price: 55, name: 'Omron HEM-8712', label: 'BP Monitor', imageUrl: DummyIcons.suit),
  ];
  static List<StoreItem> wallpapers = [
    StoreItem(tag: 'SALE', price: 55, name: 'Accu-check Active', label: 'Test Strip', imageUrl: DummyIcons.wallpaper),
    StoreItem(tag: '15% OFF', price: 55, name: 'Omron HEM-8712', label: 'BP Monitor', imageUrl: DummyIcons.wallpaper),
  ];
}
