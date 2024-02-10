import 'package:dio/src/form_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinestreamliveapp/cubit_bloc/episode_cubit/episode_state.dart';
import 'package:shinestreamliveapp/cubit_bloc/shows_episode_cubit/shows_episode_state.dart';
import 'package:shinestreamliveapp/di/locator.dart';

import '../../data/repository/episoderepository.dart';
import '../../data/repository/shows_episode_repository.dart';

class ShowsEpisodeCubit extends Cubit<ShowsEpisodeState> {
  final webEpisodeRepo = getIt<ShowsEpisodeSeriesRepository>();
  ShowsEpisodeCubit() : super(ShowsDataLoading());
  getShowsSeriesData(FormData jsonData) async{
    try{
      emit(ShowsDataLoading());
      var response = await webEpisodeRepo.showSeriesDataGet(jsonData);
      emit(ShowsDataLoaded(response));

    } catch(error) {
      emit(ShowsDataError(error));
    }
  }
  getShowsEpisodesData(FormData jsonData) async{
    try{
      emit(ShowsEpisodesLoading());
      var response = await webEpisodeRepo.showsEpisodesGet(jsonData);
      emit(ShowsEpisodesLoaded(response));

    } catch(error) {
      emit(ShowsEpisodesError(error));
    }
  }
}