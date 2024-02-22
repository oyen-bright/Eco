class Comment {
  final String? id;
  final String? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? creatorUsername;
  final String? creatorId;

  Comment({
    required this.id,
    required this.comments,
    this.createdAt,
    this.updatedAt,
    this.creatorId,
    this.creatorUsername,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      comments: map['comments'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      creatorUsername: map['creator']['username'] as String,
      creatorId: map['creator']['id'] as String,
    );
  }

  factory Comment.dummy() {
    return Comment(
        id: 'id',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        comments: 'Comments',
     );
  }
  Comment copyWith({
    String? id,
    String? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? creatorUsername,
  }) {
    return Comment(
        id: id ?? this.id,
        comments: comments ?? this.comments,
        createdAt: createdAt ?? this.createdAt,
        creatorUsername: creatorUsername ?? this.creatorUsername,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
