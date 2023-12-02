part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable{
  const LoginState();
}
class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}
class  LoginLoaded extends LoginState {
  final response;

  const LoginLoaded(this.response);

  @override
  List<Object?> get props =>[response];
}
class LoginError extends LoginState {
  final error;
  LoginError(this.error);
  @override
  List<Object?> get props =>[error];
}