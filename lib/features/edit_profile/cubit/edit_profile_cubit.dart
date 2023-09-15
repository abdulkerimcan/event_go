import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventgo/core/enums/gender_enum.dart';
import 'package:eventgo/core/extensions/string_extension.dart';
import 'package:eventgo/core/utils/image_helper.dart';
import 'package:eventgo/features/edit_profile/cubit/edit_profile_state.dart';
import 'package:eventgo/product/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(super.initialState);
  final db = FirebaseFirestore.instance;
  var storage = FirebaseStorage.instance;
  var isLoading = false;
  GenderEnum selectedGender = GenderEnum.Select;
  String selectedDate = "";
  final imageHelper = ImageHelper();
  File? image;
  void _changeLoading() {
    isLoading = !isLoading;
    emit(EditProfileLoadingState(isLoading));
  }

  Future<UserModel?> getUserInfo() async {
    final ref = db
        .collection("Users")
        .doc("wFpvu1sPPUaAQAoyLolIaaRt2he2")
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel user, _) => user.toFirestore());
    final docSnap = await ref.get();
    final user = docSnap.data();
    return user;
  }

  Future<void> update(String name, String surname) async {
    _changeLoading();
    var imageRef = storage.ref().child("images/wFpvu1sPPUaAQAoyLolIaaRt2he2");
    try {
      if (image != null) {
        await imageRef.putFile(image!);
        final imageUrl = await imageRef.getDownloadURL();
        final ref =
            db.collection("Users").doc("wFpvu1sPPUaAQAoyLolIaaRt2he2").update({
          "name": name,
          "surname": surname,
          "gender": selectedGender.name,
          "birthday": selectedDate,
          "image": imageUrl,
        });
        final docSnap = await ref.then((value) {
          _changeLoading();
          emit(const EditProfileComplete());
        }, onError: (e) => emit(EditProfileFailState(e)));
      }
    } on FirebaseException catch (e) {
      emit(EditProfileFailState(e.message));
    }
  }

  Future<void> changeGender(GenderEnum? gender) async {
    if (gender != null) {
      selectedGender = gender;
      emit(DropdownState(
          gender)); // Cinsiyet seçildiğinde doğrulama durumunu güncelleyebilirsiniz.
    }
  }

  Future<void> changeDate(String? date) async {
    if (date != null) {
      selectedDate = date;
      emit(DateState(date));
    }
  }

  Future<void> selectImage() async {
    final files = await imageHelper.pickImage();
    if (files.isNotEmpty) {
      final croppedFile = await imageHelper.crop(
          xFile: files.first, cropStyle: CropStyle.circle);
      if (croppedFile != null) {
        image = File(croppedFile.path);
        if (image != null) {
          emit(ImageSuccessState(image: image!));
        }
      }
    }
  }
}
