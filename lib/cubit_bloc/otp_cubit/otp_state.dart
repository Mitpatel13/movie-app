part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}


class OtpLoading extends OtpState {
  @override
  List<Object?> get props => [];
}
class  OtpLoaded extends OtpState {
  final response;
  OtpLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class OtpError extends OtpState {
  final error;
  OtpError(this.error);
  @override
  List<Object?> get props =>[error];
}
class OtpVerifyLoading extends OtpState {
  @override
  List<Object?> get props => [];
}
class  OtpVerifyLoaded extends OtpState {
  final response;
  OtpVerifyLoaded(this.response);
  @override
  List<Object?> get props =>[this.response];
}
class OtpVerifyError extends OtpState {
  final error;
  OtpVerifyError(this.error);
  @override
  List<Object?> get props =>[error];
}