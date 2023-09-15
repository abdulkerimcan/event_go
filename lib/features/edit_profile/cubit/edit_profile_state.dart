import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:eventgo/core/enums/gender_enum.dart';


abstract class EditProfileState extends Equatable {
  const EditProfileState();
}

class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState();
  @override
  List<Object?> get props => [];
}

class EditProfileLoadingState extends EditProfileState {
  final bool isLoading;
  const EditProfileLoadingState(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class EditProfileComplete extends EditProfileState {
  const EditProfileComplete();

  @override
  List<Object?> get props => [];
}

class EditProfileValidateState extends EditProfileState {
  final bool isValidate;
  const EditProfileValidateState(this.isValidate);

  @override
  List<Object?> get props => [isValidate];
}

class EditProfileFailState extends EditProfileState {
  final String? message;
  const EditProfileFailState(this.message);

  @override
  List<Object?> get props => [message];
}

class DropdownState extends EditProfileState {
  final GenderEnum genderEnum;
  const DropdownState(this.genderEnum);

  @override
  List<Object?> get props => [genderEnum];
}

class DateState extends EditProfileState {
  final String date;
  const DateState(this.date);

  @override
  List<Object?> get props => [date];
}

class ImageSuccessState extends EditProfileState {
  final File image;
  const ImageSuccessState({required this.image});

  @override
  List<Object?> get props => [image];
  ImageSuccessState copyWith({File? image}) {
    return ImageSuccessState(image: image ?? this.image);
  }
}
class ImageFailedState extends EditProfileState {
  final File image;
  const ImageFailedState({required this.image});

  @override
  List<Object?> get props => [image];
  ImageFailedState copyWith({File? image}) {
    return ImageFailedState(image: image ?? this.image);
  }
}
