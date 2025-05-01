import 'dart:math';

String generateSessionId() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final code =
      List.generate(6, (i) => chars[Random().nextInt(chars.length)]).join();
  return 'app://shop/session/$code';
}
