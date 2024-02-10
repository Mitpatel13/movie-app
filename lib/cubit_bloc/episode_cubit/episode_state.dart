

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class EpisodeState extends Equatable{
  const EpisodeState();
}

class SeriesDataLoading extends EpisodeState {
  @override
  List<Object?> get props => [];
}
class  SeriesDataLoaded extends EpisodeState {
  final response;
  SeriesDataLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class SeriesDataError extends EpisodeState {
  final error;
  SeriesDataError(this.error);
  @override
  List<Object?> get props =>[error];
}
class EpisodesLoading extends EpisodeState {
  @override
  List<Object?> get props => [];
}
class  EpisodesLoaded extends EpisodeState {
  final response;
  EpisodesLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class EpisodesError  extends EpisodeState {
  final error;
  EpisodesError(this.error);
  @override
  List<Object?> get props =>[error];
}