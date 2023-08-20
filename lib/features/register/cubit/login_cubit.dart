import 'package:eventgo/features/register/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  bool _isLoading = false;
  bool _isFailed = false;
  LoginCubit(super.initialState, this.emailController, this.passwordController,
      this.formKey);

  Future<void> _changeLoading() async {
    _isLoading = !_isLoading;

    emit(LoginLoadingState(_isLoading));
  }

  Future<void> login() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _isFailed = false;

      _changeLoading();
      await Future.delayed(const Duration(seconds: 3));
      _changeLoading();
      emit(const LoginCompleteState());

    } else {
      _isFailed = true;
      emit(LoginValidateState(_isFailed));
    }
  }
}
