typedef UserID = String;

/// Simple class representing the user UID and name.
class User {
  const User({required this.uid, this.name});
  final UserID uid;
  final String? name;

  Future<bool> isCreator() {
    return Future.value(false);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.uid == uid && other.name == name;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode;

  @override
  String toString() => 'AppUser(uid: $uid, email: $name)';
}
