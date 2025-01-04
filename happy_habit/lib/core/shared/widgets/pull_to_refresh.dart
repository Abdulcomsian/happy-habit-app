import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:happy_habit/core/shared/helper_functions/file_manager_helper.dart';

class PullToRefresh extends StatefulWidget {
  final Widget child;
  final Function()? tryAgain;
  final bool isOnRefreshOnInit;

  const PullToRefresh({
    Key? key,
    this.tryAgain,
    required this.child,
    this.isOnRefreshOnInit = true,
  }) : super(key: key);

  @override
  State<PullToRefresh> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  ValueNotifier<bool> connectionAvailable = ValueNotifier(true);

  @override
  void initState() {
    super.initState();

    _subscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      connectionAvailable.value = result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.vpn);
    });

    if (widget.isOnRefreshOnInit) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => checkConnection(),
      );
    }
  }

  Future<void> checkConnection({bool showToast = false}) async {
    connectionAvailable.value = await FileManagerHelper.hasInternetConnection(showToast: showToast);
    if (connectionAvailable.value && widget.tryAgain != null) {
      await widget.tryAgain!();
    }
  }

  @override
  void dispose() {
    connectionAvailable.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: connectionAvailable,
      builder: (context, connected, _) {
        return connected
            ? RefreshIndicator(
                onRefresh: checkConnection,
                child: widget.child,
              )
            : Center(
                child: Text('No internet connection'),
              );
      },
    );
  }
}
