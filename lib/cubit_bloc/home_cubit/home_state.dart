part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable{
  const HomeState();
}

class HBLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  HBLoaded extends HomeState {
  final response;
  const HBLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class HBError extends HomeState {
  final error;
  HBError(this.error);
  @override
  List<Object?> get props =>[error];
}
class ActionLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  ActionLoaded extends HomeState {
  final response;
  const ActionLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ActionError extends HomeState {
  final error;
  ActionError(this.error);
  @override
  List<Object?> get props =>[error];
}
class ClassicLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  ClassicLoaded extends HomeState {
  final response;
  const ClassicLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ClassicError extends HomeState {
  final error;
  ClassicError(this.error);
  @override
  List<Object?> get props =>[error];
}
class ComedyLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  ComedyLoaded extends HomeState {
  final response;
  const ComedyLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class ComedyError extends HomeState {
  final error;
  ComedyError(this.error);
  @override
  List<Object?> get props =>[error];
}
class CrimeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  CrimeLoaded extends HomeState {
  final response;
  const CrimeLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class CrimeError extends HomeState {
  final error;
  CrimeError(this.error);
  @override
  List<Object?> get props =>[error];
}
class RomanticLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  RomanticLoaded extends HomeState {
  final response;
  const RomanticLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class RomanticError extends HomeState {
  final error;
  RomanticError(this.error);
  @override
  List<Object?> get props =>[error];
}
class TeluguFavLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  TeluguFavLoaded extends HomeState {
  final response;
  const TeluguFavLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class TeluguFavError extends HomeState {
  final error;
  TeluguFavError(this.error);
  @override
  List<Object?> get props =>[error];
}
class DramaLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  DramaLoaded extends HomeState {
  final response;
  const DramaLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class DramaError extends HomeState {
  final error;
  DramaError(this.error);
  @override
  List<Object?> get props =>[error];
}
class KidsLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  KidsLoaded extends HomeState {
  final response;
  const KidsLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class KidsError extends HomeState {
  final error;
  KidsError(this.error);
  @override
  List<Object?> get props =>[error];
}
class SportsLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  SportsLoaded extends HomeState {
  final response;
  const SportsLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class SportsError extends HomeState {
  final error;
  SportsError(this.error);
  @override
  List<Object?> get props =>[error];
}
class DevotionalLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  DevotionalLoaded extends HomeState {
  final response;
  const DevotionalLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class DevotionalError extends HomeState {
  final error;
  DevotionalError(this.error);
  @override
  List<Object?> get props =>[error];
}
class FolkLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  FolkLoaded extends HomeState {
  final response;
  const FolkLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class FolkError extends HomeState {
  final error;
  FolkError(this.error);
  @override
  List<Object?> get props =>[error];
}
class OldIsGoldLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  OldIsGoldLoaded extends HomeState {
  final response;
  const OldIsGoldLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class OldIsGoldError extends HomeState {
  final error;
  OldIsGoldError(this.error);
  @override
  List<Object?> get props =>[error];
}
class BestHollyLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  BestHollyLoaded extends HomeState {
  final response;
  const BestHollyLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class BestHollyError extends HomeState {
  final error;
  BestHollyError(this.error);
  @override
  List<Object?> get props =>[error];
}
class BestSouthLoading extends HomeState {
  @override
  List<Object?> get props => [];
}
class  BestSouthLoaded extends HomeState {
  final response;
  const BestSouthLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class BestSouthError extends HomeState {
  final error;
  BestSouthError(this.error);
  @override
  List<Object?> get props =>[error];
}