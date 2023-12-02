part of 'series_cubit.dart';

@immutable
abstract class SeriesState extends Equatable{
  const SeriesState();
}

class SBLoading extends SeriesState {
  @override
  List<Object?> get props => [];
}
class  SBLoaded extends SeriesState {
  final response;
  SBLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class SBError extends SeriesState {
  final error;
  SBError(this.error);
  @override
  List<Object?> get props =>[error];
}
class SeriesLoading extends SeriesState {
  @override
  List<Object?> get props => [];
}
class  SeriesLoaded extends SeriesState {
  final response;
  SeriesLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class SeriesError extends SeriesState {
  final error;
  SeriesError(this.error);
  @override
  List<Object?> get props =>[error];
}