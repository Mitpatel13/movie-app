part of 'profile_cubit.dart';

@immutable
abstract class ProfileState extends Equatable{
  const ProfileState();
}

class RefundLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}
class  RefundLoaded extends ProfileState {
  final response;
  const RefundLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class RefundError extends ProfileState {
  final error;
  RefundError(this.error);
  @override
  List<Object?> get props =>[error];
}


class PolicyLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}
class  PolicyLoaded extends ProfileState {
  final response;
  const PolicyLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class PolicyError extends ProfileState {
  final error;
  PolicyError(this.error);
  @override
  List<Object?> get props =>[error];
}

class TermsLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}
class  TermsLoaded extends ProfileState {
  final response;
  const TermsLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class TermsError extends ProfileState {
  final error;
  TermsError(this.error);
  @override
  List<Object?> get props =>[error];
}
class AboutLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}
class  AboutLoaded extends ProfileState {
  final response;
  const AboutLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class AboutError extends ProfileState {
  final error;
  AboutError(this.error);
  @override
  List<Object?> get props =>[error];
}