part of 'payment_cubit.dart';

@immutable
abstract class PaymentState extends Equatable{
  const PaymentState();
}

class TokenLoading extends PaymentState {
  @override
  List<Object?> get props => [];
}
class  TokenLoaded extends PaymentState {
  final response;
  const TokenLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class TokenError extends PaymentState {
  final error;
  TokenError(this.error);
  @override
  List<Object?> get props =>[error];
}
class PlanLoading extends PaymentState {
  @override
  List<Object?> get props => [];
}
class  PlanLoaded extends PaymentState {
  final response;
  const PlanLoaded(this.response);
  @override
  List<Object?> get props =>[response];
}
class PlanError extends PaymentState {
  final error;
  PlanError(this.error);
  @override
  List<Object?> get props =>[error];
}