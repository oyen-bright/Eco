part of 'community_bloc.dart';

@freezed
class CommunityEvent with _$CommunityEvent {
  const factory CommunityEvent.loadCommunities() = _LoadCommunities;
  const factory CommunityEvent.loadCommunityFeeds({
    required String communityId
}) = _LoadCommunityFeeds;
  const factory CommunityEvent.loadMembers({
    required String communityId
  }) = _LoadMembers;
  const factory CommunityEvent.loadCommunityFeedComments({
    required String postId,
    required String communityId,
}) = _LoadComments;
  const factory CommunityEvent.likeCommunityFeed({
    required String postId,
    required String communityId,
    required bool isLiked
}) = _LikePost;
  const factory CommunityEvent.createCommunityPost({
    required PostModel postModel,
    required String communityId
  }) = _CreatePost;
  const factory CommunityEvent.deleteCommunityPost(
  {
    required String postId,
    required String communityId
  }
      ) = _DeletePost;
  const factory CommunityEvent.editCommunityPost({
    required PostModel postModel,
    required String postId,
    required String communityId
  }) = _EditPost;
  const factory CommunityEvent.commentOnCommunityPost({required String postId,
    required String comment,
      required String communityId}) = _CreateComment;
  const factory CommunityEvent.createCommunity({
    required CommunityInput communityInput,
  }) = _CreateCommunity;

}