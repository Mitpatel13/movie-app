import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/data/repository/loginrepository.dart';

import '../../data/repository/forgotpasswordrepository.dart';
import '../../di/locator.dart';
import '../../utils/validations.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final otpRepo = getIt<LoginRepository>();
  final forgotPassRepo = getIt<ForgotPasswordRepository>();
  OtpCubit() : super(OtpLoading());
  final smsOtpController = StreamController<bool>.broadcast();
  final emailOtpController = StreamController<bool>.broadcast();
  //STREAMS
  Stream<bool>get emailOtpStream => emailOtpController.stream;
  Stream<bool>get smsOtpStream => smsOtpController.stream;

  validateSmsOtp(String smsOtp){
    if(!smsOtpController.isClosed){
      if(ValidationConstants.isOtpValid(smsOtp)){
        smsOtpController.sink.add(false);
      }else {
        smsOtpController.sink.add(true);
      }
    }
  }
  otpLoad(var jsonBody) async{
    try{
      emit(OtpLoading());
      var response = await otpRepo.otpLoad(jsonBody);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(OtpLoaded(response));

    } catch(error) {
      emit(OtpError(error));
    }
  }
  verifyOtp(var session,var otp) async{
    try{
      emit(OtpVerifyLoading());
      var response = await otpRepo.verifyOtp(session,otp);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(OtpVerifyLoaded(response));

    } catch(error) {
      emit(OtpVerifyError(error));
    }
  }
  forgotPassword(var jsonBody) async{
    try{
      emit(OtpLoading());
      var response = await forgotPassRepo.forgotPassword(jsonBody);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(OtpLoaded(response));

    } catch(error) {
      emit(OtpError(error));
    }
  }

}

final otpCubit = OtpCubit();