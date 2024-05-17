// App Validator
// v.0.0.1
// by Elriz Wiraswara

class Validator {
  static RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp phoneNumberRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,14}$)');
  static RegExp uppercaseRegex = RegExp(r'[A-Z]');
  static RegExp numberRegex = RegExp(r'[0-9]');

  static bool isEmailValid(String email) {
    return emailRegex.hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return phoneNumberRegex.hasMatch(phoneNumber);
  }

  static bool isPasswordValid(String password) {
    return password.length >= 6 && isContainsUppercase(password) && isContainsNumber(password);
  }

  static bool isContainsUppercase(String string) {
    return uppercaseRegex.hasMatch(string);
  }

  static bool isContainsNumber(String string) {
    return numberRegex.hasMatch(string);
  }
}
