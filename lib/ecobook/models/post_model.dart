class PostModel {
  String? content;
  List<String>? imageUrl;
  List<String>? videoUrl;

  PostModel({
    this.content,
    this.imageUrl,
    this.videoUrl,
  });

  PostModel copyWith({
    String? content,
    List<String>? imageUrl,
    List<String>? videoUrl,
  }) {
    return PostModel(
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  String toString() {
    return 'PostCreateInput('
        'content: $content, '
        'image : $imageUrl'
        ')';
  }
}
