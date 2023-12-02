part of 'videoplayer_cubit.dart';

@immutable
abstract class VideoplayerState {}

class VideoPlayerLoading extends VideoplayerState {
  @override
  List<Object?> get props => [];
}
class  VideoPlayerLoaded extends VideoplayerState {
  final response;
  VideoPlayerLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class VideoPlayerError extends VideoplayerState {
  final error;
  VideoPlayerError(this.error);
  @override
  List<Object?> get props =>[error];
}
// class GetRelatedMovieLoading extends VideoplayerState {
//   @override
//   List<Object?> get props => [];
// }
// class  GetRelatedMovieLoaded extends VideoplayerState {
//   final response;
//   VideoPlayerLoaded(this.response);
//   @override
//   List<Object?> get props =>[response];
// }
// class GetRelatedMovieError extends VideoplayerState {
//   final error;
//   VideoPlayerError(this.error);
//   @override
//   List<Object?> get props =>[error];
// }

