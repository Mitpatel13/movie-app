import 'package:dio/src/form_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinestreamliveapp/cubit_bloc/episode_cubit/episode_state.dart';
import 'package:shinestreamliveapp/di/locator.dart';

import '../../data/repository/episoderepository.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final webEpisodeRepo = getIt<WebEpisodeSeriesRepository>();
  EpisodeCubit() : super(SeriesDataLoading());
  getWebSeriesData(FormData jsonData) async{
    try{
      emit(SeriesDataLoading());
      var response = await webEpisodeRepo.webSeriesDataGet(jsonData);
      emit(SeriesDataLoaded(response));

    } catch(error) {
      emit(SeriesDataError(error));
    }
  }
  getEpisodesData(FormData jsonData) async{
    try{
      emit(EpisodesLoading());
      var response = await webEpisodeRepo.episodesGet(jsonData);
      emit(EpisodesLoaded(response));

    } catch(error) {
      emit(EpisodesError(error));
    }
  }
}