part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}


class MoviePreviewLoading extends MovieState {
  @override
  List<Object?> get props => [];
}
class  MoviePreviewLoaded extends MovieState {
  final response;
  MoviePreviewLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class MoviePreviewError extends MovieState {
  final error;
  MoviePreviewError(this.error);
  @override
  List<Object?> get props =>[error];
}

class AllMoviesLoading extends MovieState {
  @override
  List<Object?> get props => [];
}
class  AllMoviesLoaded extends MovieState {
  final response;
  AllMoviesLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class AllMoviesError extends MovieState {
  final error;
  AllMoviesError(this.error);
  @override
  List<Object?> get props =>[error];
}
