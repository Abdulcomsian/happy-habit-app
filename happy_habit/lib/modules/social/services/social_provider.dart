import 'package:flutter/material.dart';
import 'package:happy_habit/modules/social/services/social_networking.dart';
import 'package:happy_habit/modules/social/shared/models/other_user.dart';

class SocialProvider extends ChangeNotifier {
  static final SocialProvider _instance = SocialProvider._internal();

  factory SocialProvider() => _instance;

  SocialProvider._internal();

  // Your methods and properties here
  final _networkingLayer = SocialNetworking();

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<OtherUser> get friends => _friends;
  List<OtherUser> _friends = [];

  Future<void> getFriends() async {
    final friends = await _networkingLayer.getFriends();
    if (friends != null) {
      _friends = List.from(friends);
    }
  }

  List<OtherUser> get pendingRequest => _pendingRequest;
  List<OtherUser> _pendingRequest = [];

  Future<void> getPendingRequest() async {
    final pendingRequest = await _networkingLayer.getPendingRequests();
    if (pendingRequest != null) {
      _pendingRequest = List.from(pendingRequest);
    }
  }

  Future<void> getData() async {
    _isLoading = false;
    notifyListeners();

    await Future.wait([
      getFriends(),
      getPendingRequest(),
    ]);

    _isLoading = false;
    notifyListeners();
  }
}