import 'package:connectivity_plus/connectivity_plus.dart';

import '../widgets/app_toast.dart';

class FileManagerHelper {
  static Future<bool> hasInternetConnection({bool showToast = true}) async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    bool hasConnection = result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.vpn);
    if (!hasConnection && showToast) {
      AppToast.show('no internet connection');
    }
    return hasConnection;
  }
}
