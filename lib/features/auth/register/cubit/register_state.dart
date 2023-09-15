import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();

  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;

  const RegisterLoadingState(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class RegisterCompleteState extends RegisterState {
  const RegisterCompleteState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterValidateState extends RegisterState {
  final bool isValidate;
  const RegisterValidateState(this.isValidate);
  @override
  List<Object?> get props => [isValidate];
}

class RegisterFailState extends RegisterState {
  final String? message;
  const RegisterFailState(this.message);
  @override
  List<Object?> get props => [message];
}
