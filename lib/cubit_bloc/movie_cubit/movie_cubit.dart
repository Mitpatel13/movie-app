import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/data/repository/movieRepository.dart';

import '../../di/locator.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final movieRepo = getIt<MovieRepository>();
  MovieCubit() : super(MoviePreviewLoading());


  moviePreview(var jsonBody) async{
    try{
      emit(MoviePreviewLoading());
      var response = await movieRepo.moviePreview(jsonBody);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(MoviePreviewLoaded(response));

    } catch(error) {
      emit(MoviePreviewError(error));
    }
  }
  allMovie() async{
    try{
      emit(AllMoviesLoading());
      var response = await movieRepo.allMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(AllMoviesLoaded(response));

    } catch(error) {
      emit(AllMoviesError(error));
    }
  }
}
final movieCubit = MovieCubit();