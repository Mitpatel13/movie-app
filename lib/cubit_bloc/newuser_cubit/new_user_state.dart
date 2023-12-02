part of 'new_user_cubit.dart';

@immutable
abstract class NewUserState {}

class RegisterLoading extends NewUserState {
  @override
  List<Object?> get props => [];
}
class  RegisterLoaded extends NewUserState {
  final response;
  RegisterLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class RegisterError extends NewUserState {
  final error;
  RegisterError(this.error);
  @override
  List<Object?> get props =>[error];
}
