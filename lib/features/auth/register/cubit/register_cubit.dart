import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventgo/features/auth/register/cubit/register_state.dart';
import 'package:eventgo/product/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GlobalKey<FormState> formKey;
  bool _isLoading = false;
  bool _isFailed = false;
  final auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  RegisterCubit(super.initialState, this.formKey);

  Future<void> _changeLoading() async {
    _isLoading = !_isLoading;

    emit(RegisterLoadingState(_isLoading));
  }

  Future<void> register(
      String name, String surname, String email, String password) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _isFailed = false;
      try {
        _changeLoading();
        var userResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (userResult.user != null) {
          CollectionReference users =
              FirebaseFirestore.instance.collection('Users');
          var user = UserModel(name: name, surname: surname, email: email);
          final docRef = users
              .withConverter(
                  fromFirestore: UserModel.fromFirestore,
                  toFirestore: (UserModel usermodel, options) =>
                      user.toFirestore())
              .doc(userResult.user?.uid);
          await docRef.set(user);
          _changeLoading();
          emit(const RegisterCompleteState());
        }
      } on FirebaseAuthException catch (e) {
        _isFailed = true;
        emit(RegisterFailState(e.message));
      }
    } else {
      _isFailed = true;
      emit(RegisterValidateState(_isFailed));
    }
  }
}
