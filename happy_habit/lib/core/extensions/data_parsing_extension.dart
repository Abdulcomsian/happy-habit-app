extension JsonListMapper<T> on Map<String, dynamic> {
  List<T>? toList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final list = this[key];
    // Now map the list of dynamic objects to a List<T> using the fromJson method
    return (list as List<dynamic>?)?.map((x) => fromJson(x as Map<String, dynamic>)).toList();
  }
}

extension JsonMapExtension on Map<String, dynamic> {
  T? fromJsonDynamic<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    if (this[key] != null) {
      return fromJson(this[key]);
    }
    return null;
  }
}
