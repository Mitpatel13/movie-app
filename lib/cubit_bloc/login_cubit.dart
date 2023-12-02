import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../data/repository/changepasswordrepository.dart';
import '../data/repository/loginrepository.dart';
import '../di/locator.dart';
import '../utils/validations.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final loginRepo = getIt<LoginRepository>();
  final changePassRepo = getIt<ChangePasswordRepository>();
  LoginCubit() : super(LoginLoading());

  checkLogin(var jsonBody,context)async{
    try{
      emit(LoginLoading());
      dynamic response = await loginRepo.checkLogin(jsonBody,context);
      // Logger().d(response.toString());
      // if(response["statusCode"] == 200){

      // }
      print("Emiting the loaded");
      emit(LoginLoaded(response));

    } catch(error) {
      emit(LoginError(error));
    }
  }
  changePassword(var jsonBody,context)async{
    try{
      emit(LoginLoading());
      var response = await changePassRepo.changePassword(jsonBody,context);
      emit(LoginLoaded(response));
    } catch(error) {
      emit(LoginError(error));
    }
  }


  //CONTROLLERS
  final emailController = StreamController<bool>.broadcast();
  final passController = StreamController<bool>.broadcast();
  final phoneController = StreamController<bool>.broadcast();

//STREAMS
  Stream<bool>get emailStream => emailController.stream;
  Stream<bool>get passStream => passController.stream;
  Stream<bool>get phoneStream => phoneController.stream;

  validatePassword(String password) {
    if (!passController.isClosed) {
      // if (ValidationConstants.isValidUserName(userName)) {
      if (password.isNotEmpty) {
        log("Valid Password");
        passController.sink.add(false);
      }

      else {
      log("Invalid Password");

      passController.sink.add(true);
    }
    }


  }
  validatePhoneNumber(String phoneNumber){
    if(!phoneController.isClosed){
      if(ValidationConstants.isValidMobile(phoneNumber)){
        phoneController.sink.add(false);
      }else {
        phoneController.sink.add(true);
      }
    }
  }
}

final loginCubit = LoginCubit();
