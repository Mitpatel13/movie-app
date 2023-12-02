import 'dart:developer';
import '../../../di/locator.dart';
import '../services/changepasswordservice.dart';

class ChangePasswordRepository {
  var changePass = getIt<ChangePasswordService>();
  Future<dynamic> changePassword(var jsonBody,context) async {
    try {
      var response = await changePass.changePassword(jsonBody,context);
      return response;
    } catch (e) {
      log("Change Password API EXCEPTION : $e");
      throw e;
    }
  }
}