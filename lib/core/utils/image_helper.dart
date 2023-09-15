import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  Future<List<XFile>> pickImage(
      {ImageSource source = ImageSource.gallery,
      int quantity = 100,
      bool multiple = false}) async {
    if (multiple) {
      return await _imagePicker.pickMultiImage(imageQuality: quantity);
    }
    final file =
        await _imagePicker.pickImage(source: source, imageQuality: quantity);
    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> crop(
          {required XFile xFile,
          CropStyle cropStyle = CropStyle.rectangle}) async =>
      await _imageCropper.cropImage(
          sourcePath: xFile.path, cropStyle: cropStyle, compressQuality: 100);
}
