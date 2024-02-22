import 'dart:core';

class CommentModel {
   String? comment;
   String? feedId;

  @override
  String toString() {
    return 'CommentCreateInput('
        'comment: $comment,'
        'feedId : $feedId '
        ')';
  }
}


class LikeModel {
  String? feedId;
  String? likeId;
  @override
  String toString() {
    return 'LikeCreateInput('
        'feedId : $feedId '
    'likedId : $likeId '
        ')';
  }
}
