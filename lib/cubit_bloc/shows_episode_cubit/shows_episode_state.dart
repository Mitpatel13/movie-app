

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ShowsEpisodeState extends Equatable{
  const ShowsEpisodeState();
}

class ShowsDataLoading extends ShowsEpisodeState {
  @override
  List<Object?> get props => [];
}
class  ShowsDataLoaded extends ShowsEpisodeState {
  final response;
  ShowsDataLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ShowsDataError extends ShowsEpisodeState {
  final error;
  ShowsDataError(this.error);
  @override
  List<Object?> get props =>[error];
}
class ShowsEpisodesLoading extends ShowsEpisodeState {
  @override
  List<Object?> get props => [];
}
class  ShowsEpisodesLoaded extends ShowsEpisodeState {
  final response;
  ShowsEpisodesLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ShowsEpisodesError  extends ShowsEpisodeState {
  final error;
  ShowsEpisodesError(this.error);
  @override
  List<Object?> get props =>[error];
}