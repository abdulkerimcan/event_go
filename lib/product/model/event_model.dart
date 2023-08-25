import 'package:eventgo/product/model/user_model.dart';

class EventModel {
  final String? name;
  final String? category;
  final String? location;
  final String? image;
  final List<UserModel?>? participants;
  EventModel(
      {this.name, this.location, this.image, this.participants, this.category});
}
