import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/loginrepository.dart';
import '../../di/locator.dart';
import '../../utils/validations.dart';

part 'new_user_state.dart';

class NewUserCubit extends Cubit<NewUserState> {
  final registerRepo = getIt<LoginRepository>();
  NewUserCubit() : super(RegisterLoading());
  final emailController = StreamController<bool>.broadcast();
  final passController = StreamController<bool>.broadcast();
  final phoneController = StreamController<bool>.broadcast();
  final nameController = StreamController<bool>.broadcast();
  final passConController = StreamController<bool>.broadcast();

//STREAMS
  Stream<bool>get emailStream => emailController.stream;
  Stream<bool>get passStream => passController.stream;
  Stream<bool>get phoneStream => phoneController.stream;
  Stream<bool>get passConStream => passConController.stream;
  Stream<bool>get nameStream => nameController.stream;
  register(var jsonBody,context)async{
    try{
      emit(RegisterLoading());
      var response = await registerRepo.register(jsonBody,context);
      print("Emiting the loaded");
      emit(RegisterLoaded(response));

    } catch(error) {
      emit(RegisterError(error));
    }
  }
  validatePassword(String password) {
    if (!passController.isClosed) {
      // if (ValidationConstants.isValidUserName(userName)) {
      if (password.isNotEmpty) {
        log("Valid Password");
        passController.sink.add(false);
      } else {
        log("Invalid Password");

        passController.sink.add(true);
      }
    }
  }
  validateName(String name) {
    if (!passController.isClosed) {
      // if (ValidationConstants.isValidUserName(userName)) {
      if (name.isNotEmpty) {
        log("Valid Password");
        nameController.sink.add(false);
      } else {
        log("Invalid Password");

        nameController.sink.add(true);
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
  validateEmail(String email){
    if(!emailController.isClosed){
      if(ValidationConstants.isValidEmail(email)){
        emailController.sink.add(false);
      }else {
        emailController.sink.add(true);
      }
    }
  }
}
final newUserCubit = NewUserCubit();