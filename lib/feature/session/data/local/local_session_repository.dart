import 'package:flutter/material.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_repository.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';
import 'package:sippy_cart_sharing/feature/session/domain/mutable_session.dart';
import 'package:sippy_cart_sharing/utils/generate_session_id.dart';

class LocalSessionRepositoryImpl extends ChangeNotifier
    implements LocalSessionRepository {
  Session? _session;

  Session? get session => _session;

  @override
  Future<Session> fetchSession() async {
    if (_session != null) return _session!;
    throw Exception('No session found');
  }

  @override
  Future<void> startSession({required String creatorId}) async {
    _session = Session(
      sessionId: generateSessionId(),
      creatorId: creatorId,
      guestNames: {},
      cart: const Cart(),
    );
    mockSessionStore[_session!.sessionId] = _session!;
    notifyListeners();
  }

  @override
  Future<void> setSession(Session session) async {
    _session = session;
    mockSessionStore[session.sessionId] = session;
    notifyListeners();
  }

  @override
  Future<void> addGuest({
    required String guestId,
    required String guestName,
  }) async {
    _session = _session?.addGuest(guestId, guestName);
    notifyListeners();
  }

  @override
  Future<void> removeGuest({required String guestId}) async {
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
  Future<void> endSession() async {
    if (_session != null) {
      _session = _session!.endSession();
      mockSessionStore.remove(_session!.sessionId);
      notifyListeners();
    }
  }

  // New: Get a session by sessionId (used by JoinModal)
  Future<Session> getSessionById(String id) async {
    final session = mockSessionStore[id];
    if (session == null) throw Exception("Session not found");
    _session = session;
    return session;
  }
}

// local storage for sessions
final Map<String, Session> mockSessionStore = {};
