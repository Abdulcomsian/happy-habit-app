import 'package:hive/hive.dart';

import '../services/logger.dart';

class HiveDBService {
  /// Opens a Hive box if it isn't already open.
  Future<Box> _openBox(String boxKey) async {
    if (!Hive.isBoxOpen(boxKey)) {
      await Hive.openBox(boxKey);
    }
    return Hive.box(boxKey);
  }

  /// Gets data from the given [boxKey].
  Future<dynamic> loadData({required String boxKey, String? valueKey}) async {
    if (boxKey.isEmpty) return null;

    final box = await _openBox(boxKey);

    return valueKey != null ? box.get(valueKey) : box.values.toList();
  }

  /// Stores data in the given [boxKey].
  Future<dynamic> storeData({required dynamic object, required String boxKey}) async {
    final box = await _openBox(boxKey);
    await box.put(boxKey, object);
    return box.get(boxKey);
  }

  /// Resets the content of a box with the [boxKey].
  Future<void> resetBox({required String boxKey}) async {
    if (boxKey.isEmpty) return;

    final box = await _openBox(boxKey);
    final response = await box.clear();
    Logger.logInfo('Box $boxKey cleared. Cleared items: $response');
  }

  /// Removes the value stored at [valueKey] from a box with the [boxKey].
  Future<void> removeValueFromBox({required String boxKey, required dynamic valueKey}) async {
    if (boxKey.isEmpty) return;

    final box = await _openBox(boxKey);
    await box.delete(valueKey);
    Logger.logInfo('Value at $valueKey from box $boxKey removed');
  }
}

// class HiveDBServiceV2 {
//   /// gets data of type [T] from the given [boxKey]
//   Future<dynamic> loadData<T>({
//     required String boxKey,
//     String? valueKey,
//   }) async {
//     if (boxKey.isNotEmpty) {
//       if (!Hive.isBoxOpen(boxKey)) {
//         await Hive.openBox<T>(boxKey);
//       }
//
//       final box = Hive.box<T>(boxKey);
//
//       if (valueKey != null) {
//         dynamic data = box.get(valueKey);
//         return data;
//       } else {
//         List<dynamic> data = box.values.toList();
//         return data;
//       }
//
//     } else {
//       return null;
//     }
//   }
//
//   Future<T?> storeData<T>({
//     required T object,
//     required String boxKey,
// }) async {
//     // Open the box if it's not already open
//       if (!Hive.isBoxOpen(boxKey)) {
//         await Hive.openBox<T>(boxKey);
//       }
//
//       final box = Hive.box<T>(boxKey);
//
//       // Store the object using a unique key
//       await box.put(boxKey, object);
//
//       // Return the stored object
//       return box.get(boxKey);
//   }
//
//   /// resets the content of a box with the [boxKey]
//   Future<void> resetBox<T>({
//     required String boxKey,
//   }) async {
//     if (boxKey.isNotEmpty) {
//       if (!Hive.isBoxOpen(boxKey)) {
//         await Hive.openBox<T>(boxKey);
//       }
//
//       final box = Hive.box<T>(boxKey);
//       var response = await box.clear();
//       Logger.logInfo(response.toString());
//     }
//   }
//
//   /// removes the value stored at [valueKey] from a box with the [boxKey]
//   Future<void> removeValueFromBox<T>({
//     required String boxKey,
//     required dynamic valueKey,
//   }) async {
//     if (boxKey.isNotEmpty) {
//       if (!Hive.isBoxOpen(boxKey)) {
//         await Hive.openBox<T>(boxKey);
//       }
//
//       final box = Hive.box<T>(boxKey);
//       await box.delete(valueKey);
//       Logger.logInfo('HiveDBService: value at $valueKey from box $boxKey removed');
//     }
//   }
// }
