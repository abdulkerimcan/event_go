import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventgo/core/enums/local_keys_enum.dart';
import 'package:eventgo/core/init/cache/local_manager.dart';
import 'package:eventgo/features/auth/login/cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  bool isLoading = false;
  bool _isFailed = false;
  final auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  LoginCubit(super.initialState, this.emailController, this.passwordController,
      this.formKey);

  Future<void> _changeLoading() async {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }

  Future<void> login(String email, String password) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _changeLoading();
      try {
        var user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        _changeLoading();
        LocalManager.instance
            .setStringValue(PreferencesKeys.TOKEN, user.user?.uid ?? "");
            

        emit(const LoginCompleteState());
      } on FirebaseAuthException catch (e) {
        _isFailed = true;
        emit(LoginFailState(e.message));
      }
    } else {
      _isFailed = true;
      emit(LoginValidateState(_isFailed));
    }
  }
}
