// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'community_comment_model.dart';

class CommunityPost {
  final String? id;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String creatorUsername;
  final List<String>? imageUrl;
  final List<String>? videoUrl;
  final List<Comment>? comments;
  final List<Map<String, dynamic>> feedLikes;
  final String creatorId;
  final List<String>? media;
  final bool isLiked;

  CommunityPost({
    required this.id,
    required this.feedLikes,
    required this.creatorId,
    required this.creatorUsername,
    this.imageUrl,
    this.videoUrl,
    this.media,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isLiked = false,
    this.comments,
  });



  factory CommunityPost.fromMap(Map<String, dynamic> map) {
    List<String>? imageUrls = [];
    List<String>? videoUrls = [];

    if (map['mediaUrl'] != null) {
      for (final mediaItem in map['mediaUrl'] as List<Object?>) {
        if (mediaItem is Map<String, dynamic> &&
            mediaItem['__typename'] == 'FeedMedia') {
          final imageUrlsFromMedia = mediaItem['imageUrl'] as List<dynamic>?;
          if (imageUrlsFromMedia != null) {
            imageUrls.addAll(imageUrlsFromMedia
                .map((imageUrl) => imageUrl as String)
                .toList());
          }

          final videoUrlsFromMedia = mediaItem['videoUrl'] as List<dynamic>?;
          if (videoUrlsFromMedia != null) {
            videoUrls.addAll(videoUrlsFromMedia
                .map((videoUrl) => videoUrl as String)
                .toList());
          }
        }
      }}

    List<Comment>? postComments = _extractComments(map['comments']);

    List<String>? media = [];
    media.addAll(imageUrls);
      media.addAll(videoUrls);


    return CommunityPost(
      id: map['id'] as String,
      creatorUsername: map['creator']['username'] != null
          ? map['creator']['username'] as String
          : 'Unknown',

      creatorId: map['creator']['id'] as String,
      imageUrl: imageUrls,
      videoUrl: videoUrls,
      media : media,
      content: map['content'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),

      updatedAt: DateTime.parse(map['updatedAt'] as String),
      comments: postComments,
      feedLikes: List.from(map['feedLikes'] ?? []),
    );
  }

  static List<Comment>? _extractComments(List<dynamic>? commentsList) {
    if (commentsList == null) return null;

    final comments = <Comment>[];
    for (final commentObj in commentsList) {
      if (commentObj is Map<String, dynamic>) {
        final comment = Comment.fromMap(commentObj);
        comments.add(comment);
      }
    }
    return comments;
  }

  factory CommunityPost.fromJson(String source) =>
      CommunityPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityPost(id: $id,'
        'comments : $comments'
        // 'username : $creatorUsername, '
        'createdAt: $createdAt,'
        ' updatedAt: $updatedAt,'
        ' comments: $comments,'
        'content : $content)';
  }

  factory CommunityPost.dummy() {
    return CommunityPost(
        id: 'id',
        creatorId: 'creatorId',
        content: 'content',
        createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      feedLikes: [],
        creatorUsername: 'username',
        );
  }


  CommunityPost copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? creatorUserName,
    String? creatorId,
    List<Map<String, dynamic>>? feedLikes,
    List<Comment>? comments,
    List<String>? media,
    bool? isLiked,
    List<String>? imageUrl,
    List<String>? videoUrl,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      creatorUsername: creatorUsername,
      creatorId: creatorId ?? this.creatorId,
      media : media ?? this.media,
      feedLikes: feedLikes ?? this.feedLikes,
      imageUrl: imageUrl ?? this.imageUrl,
      comments: comments ?? this.comments,
      videoUrl: videoUrl ?? this.videoUrl,
      isLiked: isLiked ?? this.isLiked,
    );
  }

}

