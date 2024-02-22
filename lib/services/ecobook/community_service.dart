import 'package:emr_005/ecobook/bloc/community/community_feed_model.dart';
import 'package:emr_005/ecobook/bloc/community/community_model.dart';
import 'package:emr_005/ecobook/bloc/community/members_model.dart';
import 'package:emr_005/ecobook/models/create_community.dart';
import '../../data/graphql/graphql_repository.dart';
import '../../ecobook/bloc/community/community_comment_model.dart';
import '../../ecobook/models/post_model.dart';

class CommunityService {
  CommunityService();


  Future<({String? error, List<Community>? communities})> loadCommunities() async {
    try {
      final response = await GraphQLRepository.fetchCommunities();
      final list = response.data!['communities'] as List;
      final communities = list.map((e) => Community.fromMap(e)).toList();
      print(communities);

      return (error: null, communities: communities);
    } catch (e) {
      return (error: e.toString(), communities: null);
    }
  }

  Future<({String? error, List<CommunityPost>? communityPosts})> loadCommunityFeeds({
    required String communityId
}) async {
    try {
      final response = await GraphQLRepository.communityFeeds(communityId: communityId);
      print('Response from service : $response');
      final list = response.data!['communityFeeds'] as List;
      final communityPosts = list.map((e) => CommunityPost.fromMap(e)).toList();

      return (error: null, communityPosts: communityPosts);
    } catch (e) {
      return (error: e.toString(), communityPosts: null);
    }
  }

  Future<({String? error, List<Member>? members})> loadMembers({
    required String communityId
  }) async {
    try {
      final response = await GraphQLRepository.fetchCommunityMembers(communityId: communityId);
      print('Response from service : $response');
      final data = response.data!['community']['members'] as List;
      final members = data.map((e) => Member.fromMap(e)).toList();


      return (error: null, members: members);
    } catch (e) {
      return (error: e.toString(), members: null);
    }
  }


  Future<({String? error, Map<String, dynamic>? likeDetails})> likeCommunityFeed({
    required String feedId,
  }) async {
    try {
      final response = await GraphQLRepository.likeCommunityFeed(feedId);
      final data = response.data?['createFeedLike'] as Map<String, dynamic>;

      return (error: null, likeDetails: data);
    } catch (e) {
      return (error: e.toString(), likeDetails: null);
    }
  }

  Future<({String? error, Comment? commentDetails})> createComment({
    required String postId,
    required String comment,
  }) async {
    try {
      final response = await GraphQLRepository.createCommentOnCommunityFeed(
          postId: postId, comment: comment);
      final data = response.data?['createComment'];
      return (error: null, commentDetails: Comment.fromMap(data));
    } catch (e) {
      return (error: e.toString(), commentDetails: null);
    }
  }


  Future<({String? error, Map<String, dynamic>? likeDetails})> unLikeCommunityFeed({
    required String likeId,
  }) async {
    try {
      final response = await GraphQLRepository.deleteCommunityFeedLike(likeId);

      final data = response.data?['deleteFeedLike'] as Map<String, dynamic>;

      return (error: null, likeDetails: data);
    } catch (e) {
      return (error: e.toString(), likeDetails: null);
    }
  }

  Future<({String? error, List<Comment>? feedComments})> loadComments(
      {required String feedId}) async {
    try {
      final response =
      await GraphQLRepository.fetchCommunityFeedComments(feedId: feedId);

      final comment = response.data!['comments'] as List;
      final feedComments = comment.map((e) => Comment.fromMap(e)).toList();
      return (error: null, feedComments: feedComments);
    } catch (e) {
      return (error: e.toString(), feedComments: null);
    }
  }

  Future<({String? error, bool isCreated})> createCommunityPost(
      {required PostModel postModel,
      required String communityId}) async {
    try {
      await GraphQLRepository.createCommunityPost(postModel , communityId);
      return (error: null, isCreated: true);
    } catch (e) {
      return (error: e.toString(), isCreated: false);
    }
  }


  Future<({String? error, bool isCreated})> createCommunity(
      {required CommunityInput communityInput}) async {
    try {
      await GraphQLRepository.createCommunity(communityInput);
      return (error: null, isCreated: true);
    } catch (e) {
      return (error: e.toString(), isCreated: false);
    }
  }

  Future<({String? error, Map<String, dynamic>? feedDetails})> editPost({
    required PostModel postModel,
    required String postId,
  }) async {
    try {
      final response = await GraphQLRepository.editCommunityPost(postModel, postId);
      final updatedFeed = response.data?['updateCommunityFeed'] as Map<String, dynamic>?;
      if (updatedFeed == null) {
        return (error: 'updateCommunityFeed is null', feedDetails: null);
      }
      return (error: null, feedDetails: updatedFeed);
    } catch (e) {
      return (error: e.toString(), feedDetails: null);
    }
  }

  Future<({String? error, bool isDeleted})> deletePost(
      {required String postId}) async {
    try {
      final response = await GraphQLRepository.deleteCommunityPost(postId);
      print("Response is : $response");
      return (error: null, isDeleted: true);
    } catch (e) {
      return (error: e.toString(), isDeleted: false);
    }
  }

}
