// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'feed_comment_model.dart';

class FeedPost {
  final String? id;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String username;
  final String creatorId;
  final List<String>? imageUrl;
  final List<String>? videoUrl;
  final List<Map<String, dynamic>> feedLikes;
  final List<Comment>? comments;
  final List? media;
  final bool isLiked;

  FeedPost({
    required this.id,
    required this.content,
    required this.creatorId,
    required this.createdAt,
    required this.updatedAt,
    this.media,
    this.comments,
    this.isLiked = false,
    required this.feedLikes,
    required this.username,
    required this.imageUrl,
    required this.videoUrl,
  });

  factory FeedPost.fromMap(Map<String, dynamic> map) {
    List<Comment>? postComments = _extractComments(map['comments']);
    List<String>? imageUrls = [];
    List<String>? videoUrls = [];

    if (map['media'] != null) {
      for (final mediaItem in map['media'] as List<Object?>) {
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
      }
    }

    return FeedPost(
      id: map['id'] as String,
      imageUrl: imageUrls,
      videoUrl: videoUrls,
      username: (map['creator'] != null && map['creator']['username'] != null)
          ? map['creator']['username'] as String
          : 'Unknown',
      creatorId: map['creator']['id'] as String,
      content: map['content'] != null ? map['content'] as String : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      media: [imageUrls , videoUrls],
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      feedLikes: List.from(map['feedLikes'] ?? []),
      comments: postComments,
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

  factory FeedPost.fromJson(String source) =>
      FeedPost.fromMap(json.decode(source) as Map<String, dynamic>);

  factory FeedPost.dummy() {
    return FeedPost(
        id: 'id',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        content: 'Caption',
        username: 'Creator',
        creatorId: 'Id',
        imageUrl: [],
        comments: [],
        isLiked: false,
        feedLikes: [],
        videoUrl: []);
  }

  @override
  String toString() {
    return 'FeedPost(id: $id, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, username: $username, creatorId: $creatorId, imageUrl: $imageUrl, videoUrl: $videoUrl, feedLikes: $feedLikes, comments: $comments, media: $media, isLiked: $isLiked)';
  }

  FeedPost copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    String? creatorId,
    List<String>? imageUrl,
    List<String>? videoUrl,
    List<Map<String, dynamic>>? feedLikes,
    List<Comment>? comments,
    List<Object?>? media,
    bool? isLiked,
  }) {
    return FeedPost(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      creatorId: creatorId ?? this.creatorId,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      feedLikes: feedLikes ?? this.feedLikes,
      comments: comments ?? this.comments,
      media: media ?? this.media,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
