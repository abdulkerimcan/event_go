import 'package:eventgo/core/enums/gender_enum.dart';

extension StringToGenderEnum on String? {
  GenderEnum stringToGender() {
    switch (this) {
      case "Male":
        return GenderEnum.Male;
      case "Female":
        return GenderEnum.Female;
      default:
        return GenderEnum.Select;
    }
  }
}
