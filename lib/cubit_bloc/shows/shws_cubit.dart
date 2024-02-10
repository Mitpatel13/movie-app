import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/cubit_bloc/shows/shows_state.dart';
import 'package:shinestreamliveapp/data/repository/seriesrepository.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../data/repository/shows_repository.dart';
import '../../di/locator.dart';


class ShowsCubit extends Cubit<ShowsState> {
  final showsRepo = getIt<ShowsRepository>();
  ShowsCubit() : super(ShowsBannerLoading());
  showsBanner() async{
    try{
      emit(ShowsBannerLoading());
      var response = await showsRepo.showsBanner();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(ShowsBannerLoaded(response));

    } catch(error) {
      emit(ShowsBannerError(error));
    }
  }
  showsList() async{
    try{
      emit(ShowsListLoading());
      var response = await showsRepo.showsList();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(ShowsListLoaded(response));

    } catch(error) {
      emit(ShowsListError(error));
    }
  }
}
