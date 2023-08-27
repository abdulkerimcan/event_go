import 'package:eventgo/features/settings/cubit/settings_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(super.initialState);
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

  Future<void> _changeLoading() async {
    _isLoading = !_isLoading;
    emit(const SettingsLoadingState());
  }

  Future<void> logout() async {
    try {
      _changeLoading();
      emit(SettingsLoadingState());
      await auth.signOut();
      await Future.delayed(Duration(seconds: 2));
      _changeLoading();
      emit(const SettingsCompleteState());
    } catch (e) {
      emit(SettingsFailedState(e.toString()));
    }
  }
}
