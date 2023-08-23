abstract class RegisterState {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;

  RegisterLoadingState(this.isLoading);
}

class RegisterCompleteState extends RegisterState {
  const RegisterCompleteState();
}

class RegisterValidateState extends RegisterState {
  final bool isValidate;
  final String? message;
  const RegisterValidateState({required this.isValidate, this.message});
}

class RegisterFailState extends RegisterState {
  const RegisterFailState();
}
