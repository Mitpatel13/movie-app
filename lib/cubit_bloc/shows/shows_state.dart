
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ShowsState extends Equatable{
  const ShowsState();
}

class ShowsBannerLoading extends ShowsState {
  @override
  List<Object?> get props => [];
}
class  ShowsBannerLoaded extends ShowsState {
  final response;
  ShowsBannerLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ShowsBannerError extends ShowsState {
  final error;
  ShowsBannerError(this.error);
  @override
  List<Object?> get props =>[error];
}
class ShowsListLoading extends ShowsState {
  @override
  List<Object?> get props => [];
}
class  ShowsListLoaded extends ShowsState {
  final response;
  ShowsListLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ShowsListError extends ShowsState {
  final error;
  ShowsListError(this.error);
  @override
  List<Object?> get props =>[error];
}