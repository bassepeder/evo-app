extension EmailValidation on String {
  static final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  bool isValidEmail() {
    return _emailRegex.hasMatch(this);
  }
}
