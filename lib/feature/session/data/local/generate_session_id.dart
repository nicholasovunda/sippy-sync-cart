import 'package:uuid/uuid.dart';

final _uuid = Uuid();

String generateSessionId() {
  return _uuid.v4(); // generates a random UUID
}
