import 'dart:convert';
import 'dart:io' as io;

class Base64ImageHandler {
  Future<String> convertToBase64(io.File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    String extension = imageFile.path.split('.').last;

    String base64WithExtension = 'data:image/$extension;base64,$base64Image';

    return base64WithExtension;
  }
}
