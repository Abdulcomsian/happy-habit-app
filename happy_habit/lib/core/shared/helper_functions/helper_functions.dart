import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:happy_habit/core/shared/widgets/app_toast.dart';

class HelperFunctions {
  static Future<bool> hasInternetConnection({bool showToast = true}) async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    bool hasConnection = result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.vpn);
    if (!hasConnection && showToast) {
      AppToast.show('Looks like you’re offline. Please check your internet connection and try again');
    }
    return hasConnection;
  }
}