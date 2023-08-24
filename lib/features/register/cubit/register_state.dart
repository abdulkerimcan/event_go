import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;

  const RegisterLoadingState(this.isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
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
  List<Object?> get props => throw UnimplementedError();
}

class RegisterFailState extends RegisterState {
  final String? message;
  const RegisterFailState(this.message);
  @override
  List<Object?> get props => throw UnimplementedError();
}
