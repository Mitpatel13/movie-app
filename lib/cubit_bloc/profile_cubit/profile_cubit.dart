import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/repository/profilerepository.dart';
import '../../di/locator.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final profileRepo = getIt<ProfileRepository>();
  ProfileCubit() : super(RefundLoading());
  logoutDeviceDecrementApiCall({required jsonBody,required context }) async{
    try{
      emit(LogOutLoading());
      var response = await profileRepo.logoutDeviceDecrement(jsonBody, context);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(LogOutLoaded(response));

    } catch(error) {
      emit(LogOutError(error));
    }
  }
  getRefund() async{
    try{
      emit(RefundLoading());
      var response = await profileRepo.getRefund();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(RefundLoaded(response));

    } catch(error) {
      emit(RefundError(error));
    }
  }
  getPolicy() async{
    try{
      emit(PolicyLoading());
      var response = await profileRepo.getPolicy();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(PolicyLoaded(response));

    } catch(error) {
      emit(PolicyError(error));
    }
  }
  getAbout() async{
    try{
      emit(AboutLoading());
      var response = await profileRepo.getAbout();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(AboutLoaded(response));

    } catch(error) {
      emit(AboutError(error));
    }
  }
  getTerms() async{
    try{
      emit(TermsLoading());
      var response = await profileRepo.getTerms();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(TermsLoaded(response));

    } catch(error) {
      emit(TermsError(error));
    }
  }
}
final profileCubit = ProfileCubit();