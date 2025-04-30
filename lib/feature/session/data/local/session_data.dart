import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';

class SessionDTO {
  final String sessionId;
  final String creatorId;
  final Map<String, String> guestNames;
  final Cart cart;

  SessionDTO({
    required this.sessionId,
    required this.creatorId,
    required this.guestNames,
    required this.cart,
  });

  // Map/Json serialization
  // factory Session.fromMap(Map<String, dynamic> map) {
  //   return Session(
  //     sessionId: map['sessionId'],
  //     creatorId: map['creatorId'],
  //     guestNames: Map<String, String>.from(map['guestNames']),
  //     cart: Cart.fromMap(map['cart']),
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'creatorId': creatorId,
      'guestNames': guestNames,
      'cart': cart.toMap(),
    };
  }
}
