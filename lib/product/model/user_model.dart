import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? gender;
  final String? birthday;
  final String? image;
  UserModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      this.gender, this.birthday, this.image,});

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
        name: data?['name'],
        surname: data?['surname'],
        email: data?['email'],
        id: data?['id'],
        gender: data?["gender"],
        birthday: data?["birthday"],
        image: data?["image"],);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "surname": surname,
      "email": email,
    };
  }
}
