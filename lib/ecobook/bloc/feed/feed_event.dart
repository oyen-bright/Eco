part of 'feed_bloc.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const factory FeedEvent.loadFeeds() = _LoadFeed;
  const factory FeedEvent.commentOnPost(String postId, String comment) =
      _CommentOnPost;
  const factory FeedEvent.loadUserFeeds() = _LoadFeedsByUser;
  const factory FeedEvent.loadFeedPostComments(String postId) =
      _LoadFeedPostComments;
  const factory FeedEvent.likeFeedPost(
      {required String postId, required bool isLiked}) = _LikeFeedPost;
  const factory FeedEvent.createPost(
      {required PostModel postModel}) = _CreatePost;
  const factory FeedEvent.editPost(
      {required PostModel postModel, required String postId}) = _EditPost;
  const factory FeedEvent.deletePost(
      {required String postId}) = _DeletePost;




}
