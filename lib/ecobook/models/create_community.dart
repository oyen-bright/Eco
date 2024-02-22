import 'package:image_picker/image_picker.dart';

class CommunityInput {
  XFile? imageFile;
  String? name;
  String? headerImage;
  String? description;

  CommunityInput({
    this.name,
    this.imageFile,
    this.headerImage,
    this.description,
  });

  CommunityInput copyWith({
    String? name,
    XFile? imageFile,
    String? headerImage,
    String? description,
  }) {
    return CommunityInput(
      name: name ?? this.name,
      imageFile : imageFile ?? this.imageFile,
      headerImage: headerImage ?? this.headerImage,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'CommunityCreateInput('
        'name: $name, '
        'image : $headerImage'
        ')';
  }
}
