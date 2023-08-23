import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String surname;
  final String email;
  UserModel({required this.name, required this.surname, required this.email});

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
        name: data?['name'], surname: data?['surname'], email: data?['email']);
  }

   Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (surname != null) "surname": surname,
      if (email != null) "email": email,
    };
  }
}
