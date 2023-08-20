abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}

class LoginCompleteState extends LoginState {
  const LoginCompleteState();
}

class LoginValidateState extends LoginState {
  final bool isValidate;
  const LoginValidateState(this.isValidate);
}

class LoginFailState extends LoginState {
  const LoginFailState();
}
