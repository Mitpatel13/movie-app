import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/cubit_bloc/view_all_movies_cubit/view_all_movie_state.dart';
import 'package:shinestreamliveapp/data/repository/language_repository.dart';
import 'package:shinestreamliveapp/data/repository/videoplayerrepository.dart';
import 'package:shinestreamliveapp/data/services/language_movie_service.dart';

import '../../di/locator.dart';


class MovieByLanguageCubit extends Cubit<LanguageMovieState> {
  final languageService = getIt<LanguageByMovieRepository>();
  MovieByLanguageCubit() : super(LanguageMovieLoading());
  getMovieByLanguage(jsonBody) async{
    try{
      emit(LanguageMovieLoading());
      var response = await languageService.getMovieByLanguage(jsonBody: jsonBody);
      // Logger().f(response);
      emit(LanguageMovieLoaded(response));

    } catch(error) {
      emit(LanguageMovieError(error.toString()));
    }
  }
}
