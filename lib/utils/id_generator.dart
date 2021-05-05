import 'package:uuid/uuid.dart';

class Generator {
  static String generateId() {
    Uuid uuid = Uuid();
    return uuid.v4();
  }
}
