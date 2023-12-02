import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/data/repository/seriesrepository.dart';

import '../../di/locator.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  final seriesRepo = getIt<SeriesRepository>();
  SeriesCubit() : super(SBLoading());
  seriesBanner() async{
    try{
      emit(SBLoading());
      var response = await seriesRepo.seriesBanner();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(SBLoaded(response));

    } catch(error) {
      emit(SBError(error));
    }
  }
  seriesList() async{
    try{
      emit(SeriesLoading());
      var response = await seriesRepo.seriesList();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(SeriesLoaded(response));

    } catch(error) {
      emit(SeriesError(error));
    }
  }
}
