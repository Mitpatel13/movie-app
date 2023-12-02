import 'dart:developer';
import '../../../di/locator.dart';
import '../services/forgotpasswordservice.dart';

class ForgotPasswordRepository {
  var forgotPass = getIt<ForgotPasswordService>();
  Future<dynamic> forgotPassword(var jsonBody) async {
    try {
      var response = await forgotPass.forgotPassword(jsonBody);
      return response;
    } catch (e) {
      log("Forgot Password API EXCEPTION : $e");
      throw e;
    }
  }
}