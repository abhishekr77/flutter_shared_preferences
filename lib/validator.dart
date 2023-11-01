class Validator{

  static String? empty(String value, [String? message]) {
    if (value.trim().isEmpty) {
      return message ?? "Field cannot be empty";
    } else {
      return null;
    }
  }
}