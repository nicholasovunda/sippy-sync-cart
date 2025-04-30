import 'package:flutter/material.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/generate_session_id.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_repository.dart';
import 'package:sippy_cart_sharing/feature/session/domain/mutable_session.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

class LocalSessionRepositoryImpl extends ChangeNotifier
    implements LocalSessionRepository {
  Session? _session;

  Session? get session => _session;

  @override
  Future<Session> fetchSession() async {
    return _session ??
        const Session(
          sessionId: "",
          creatorId: "John",
          guestNames: {},
          cart: Cart(),
        );
  }

  @override
  Future<void> startSession({required String creatorId}) async {
    _session = Session(
      sessionId: generateSessionId(),
      creatorId: creatorId,
      guestNames: {},
      cart: const Cart(),
    );
    notifyListeners();
  }

  @override
  Future<void> addGuest({
    required GuestId guestId,
    required String guestName,
  }) async {
    _session = _session?.addGuest(guestId, guestName);
    notifyListeners();
  }

  @override
  Future<void> removeGuest({required GuestId guestId}) async {
    _session = _session?.removeGuest(guestId);
    notifyListeners();
  }

  @override
  Future<void> addItemToCart({required Item item}) async {
    _session = _session?.updateCart(item);
    notifyListeners();
  }

  @override
  Future<void> removeItemFromCart({required String productId}) async {
    _session = _session?.deleteFromCart(productId);
    notifyListeners();
  }

  @override
  Future<void> setSession(Session session) async {
    _session = session;
  }

  @override
  Future<void> endSession() async {
    _session = _session?.endSession();
    notifyListeners();
  }
}
