import 'dart:math';

String generateSessionId() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(6, (i) => chars[Random().nextInt(chars.length)]).join();
}
