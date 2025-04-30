import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';

class RemoteCartRepository {
  final FirebaseFirestore _firestore;

  RemoteCartRepository(this._firestore);

  Future<Cart> fetchCart(String sessionId) async {
    final ref = _cartRef(sessionId);
    final snapshot = await ref.get();
    return snapshot.data() ?? const Cart();
  }

  Stream<Cart> watchCart(String sessionId) {
    final ref = _cartRef(sessionId);
    return ref.snapshots().map((snapshot) => snapshot.data() ?? const Cart());
  }

  Future<void> setCart(String sessionId, Cart cart) async {
    final ref = _cartRef(sessionId);
    await ref.set(cart);
  }

  DocumentReference<Cart> _cartRef(String sessionId) => _firestore
      .doc("cart/$sessionId")
      .withConverter(
        fromFirestore: (doc, _) => Cart.fromMap(doc.data()!),
        toFirestore: (cart, _) => cart.toMap(),
      );
}
