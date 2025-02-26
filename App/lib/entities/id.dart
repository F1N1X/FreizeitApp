import 'package:uuid/uuid.dart';

class UniqueID {
  const UniqueID._(this.value);
  final String value;

  factory UniqueID() {
    return UniqueID._(const Uuid().v1());
  }

  factory UniqueID.fromUniqueString(String uniqueId) {
    return UniqueID._(uniqueId);
  }
}
