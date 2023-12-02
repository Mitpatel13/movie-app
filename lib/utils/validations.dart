class ValidationConstants {
  static bool isValidMobile(String mobile) {
    return RegExp(r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$').hasMatch(mobile);
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool isValidUserName(String userName) {
    return RegExp(r'^[A-Za-z 0-9$&+,:;=?@#|<>.^*()%!-]{3,15}$').hasMatch(userName);
  }

  static bool isOtpValid(String userName) {
    return RegExp(r'^[0-9]{6}$').hasMatch(userName);
  }
}
