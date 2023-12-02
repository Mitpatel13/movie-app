import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../data/models/homebannermodel.dart';


abstract class LanguageMovieState extends Equatable {
  const LanguageMovieState();
}

class LanguageMovieInitial extends LanguageMovieState {
  @override
  List<Object> get props => [];
}

class LanguageMovieLoading extends LanguageMovieState {
  @override
  List<Object> get props => [];
}

// class  RefundLoaded extends ProfileState {
//   final response;
//   const RefundLoaded(this.response);
//   @override
//   List<Object?> get props =>[response];
// }
class LanguageMovieLoaded extends LanguageMovieState {
  final List<ActionMovieModel> movies;
  LanguageMovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class LanguageMovieError extends LanguageMovieState {
  final String error;

  LanguageMovieError(this.error);

  @override
  List<Object> get props => [error];
}
