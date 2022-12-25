class Validators {
  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9-]$',
  );
  static final RegExp _schoolRegExp = RegExp(
    r'^[A-Z0-9-]$',
  );
  static final RegExp _kelasRegExp = RegExp(
    r'^[A-Z0-9-]$',
  );
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidUsername(String username) {
    return _usernameRegExp.hasMatch(username);
  }

  static isValidSchool(String school) {
    return _schoolRegExp.hasMatch(school);
  }

  static isValidKelas(String kelas) {
    return _kelasRegExp.hasMatch(kelas);
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
