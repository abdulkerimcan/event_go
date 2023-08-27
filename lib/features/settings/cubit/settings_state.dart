import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState();

  @override
  List<Object?> get props => [];
}
class SettingsLoadingState extends SettingsState {
  const SettingsLoadingState();
  
  @override
  List<Object?> get props => [];
}
class SettingsCompleteState extends SettingsState {
  const SettingsCompleteState();
  @override
  List<Object?> get props => [];
}
class SettingsFailedState extends SettingsState {
  final String? message;
  const SettingsFailedState(this.message);
  @override
  List<Object?> get props => [];
}
