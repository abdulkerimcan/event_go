import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();

  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  const LoginLoadingState(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class LoginCompleteState extends LoginState {
  const LoginCompleteState();

  @override
  List<Object?> get props => [];
}

class LoginValidateState extends LoginState {
  final bool isValidate;
  const LoginValidateState(this.isValidate);

  @override
  List<Object?> get props => [isValidate];
}

class LoginFailState extends LoginState {
  final String? message;
  const LoginFailState(this.message);

  @override
  List<Object?> get props => [message];
}
