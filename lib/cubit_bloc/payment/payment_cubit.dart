import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/data/repository/paymentrepository.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../di/locator.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final paymentRepo = getIt<PaymentRepository>();
  PaymentCubit() : super(TokenLoading());
  tokenApi(String uid,String pid,String amount) async{
    try{
      emit(TokenLoading());
      var response = await paymentRepo.tokenApi(uid, pid, amount);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(TokenLoaded(response));

    } catch(error,t) {
      emit(TokenError(error));
      AppLog.e("tarce in token api$t");

    }
  }
  planDetails() async{
    try{
      emit(PlanLoading());
      var response = await paymentRepo.planDetails();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(PlanLoaded(response));

    } catch(error) {
      emit(PlanError(error));
    }
  }


}
