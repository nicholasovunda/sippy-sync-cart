import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';

typedef GuestId = String;

// Model class for session creation
class Session extends Equatable {
  final String sessionId;
  final GuestId creatorId;
  final Map<GuestId, String> guestNames;
  final Cart cart;

  const Session({
    required this.sessionId,
    required this.creatorId,
    required this.guestNames,
    required this.cart,
  });

  // Convert to Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'creatorId': creatorId,
      'guestNames': guestNames,
      'cart': cart.toMap(),
    };
  }

  // Convert from Map for deserialization
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['sessionId'],
      creatorId: map['creatorId'],
      guestNames: Map<String, String>.from(map['guestNames']),
      cart: Cart.fromMap(map['cart']),
    );
  }

  // Convert to JSON
  String toJson() => json.encode(toMap());

  // Convert from JSON
  factory Session.fromJson(String jsonStr) {
    return Session.fromMap(json.decode(jsonStr));
  }

  Session copyWith({
    String? sessionId,
    GuestId? creatorId,
    Map<GuestId, String>? guestNames,
    Cart? cart,
  }) {
    return Session(
      sessionId: sessionId ?? this.sessionId,
      creatorId: creatorId ?? this.creatorId,
      guestNames: guestNames ?? this.guestNames,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [sessionId, creatorId, guestNames, cart];

  @override
  bool? get stringify => true;
}
