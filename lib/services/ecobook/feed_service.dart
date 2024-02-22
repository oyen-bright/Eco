
import 'package:emr_005/ecobook/bloc/feed/feed_comment_model.dart';
import '../../data/graphql/graphql_repository.dart';
import '../../ecobook/bloc/feed/feed_model.dart';
import '../../ecobook/models/post_model.dart';

class FeedService {
  FeedService();

  Future<({String? error, List<FeedPost>? feedPosts})> loadUserFeeds() async {
    try {
      final response = await GraphQLRepository.fetchFeeds();
      print('Response is here : $response');
      final feedPost = response.data!['userFeeds'] as List;
      final feedPosts = feedPost.map((e) => FeedPost.fromMap(e)).toList();
      print("Feedposts : $feedPosts");
      return (error: null, feedPosts: feedPosts);
    } catch (e) {
      return (error: e.toString(), feedPosts: null);
    }
  }

  Future<({String? error, List<FeedPost>? feedPosts})> loadFeedsByUserId() async {
    try {
      final response = await GraphQLRepository.fetchFeedsByUser();

      final feedPost = response.data!['userFeeds'] as List;
      final feedPosts = feedPost.map((e) => FeedPost.fromMap(e)).toList();
      return (error: null, feedPosts: feedPosts);
    } catch (e) {
      return (error: e.toString(), feedPosts: null);
    }
  }

  Future<({String? error, List<FeedPost>? feedPosts})> loadLikedFeeds() async {
    try {
      final response = await GraphQLRepository.fetchLikedFeeds();
      final feedLikes = response.data!['feedLikes'] as List;
      final feedPosts = feedLikes
          .where((feed) => feed['userFeed'] != null)
          .map<FeedPost>((feed) => FeedPost.fromMap(feed['userFeed']))
          .toList();

      return (error: null, feedPosts: feedPosts);
    } catch (e) {
      return (error: e.toString(), feedPosts: null);
    }
  }



  Future<({String? error, Map<String, dynamic>? likeDetails})> likeUserFeed({
    required String feedId,
  }) async {
    try {
      final response = await GraphQLRepository.likeUserFeed(feedId);
      final data = response.data?['createFeedLike'] as Map<String, dynamic>;

      return (error: null, likeDetails: data);
    } catch (e) {
      return (error: e.toString(), likeDetails: null);
    }
  }

  Future<({String? error, Comment? commentDetails})> createCommentOnUserFeed({
    required String postId,
    required String comment,
  }) async {
    try {
      final response = await GraphQLRepository.createCommentOnUserFeed(
          postId: postId, comment: comment);
      final data = response.data?['createComment'];
      return (error: null, commentDetails: Comment.fromMap(data));
    } catch (e) {
      return (error: e.toString(), commentDetails: null);
    }
  }

  Future<({String? error, Map<String, dynamic>? likeDetails})> unLikeUserFeed({
    required String likeId,
  }) async {
    try {
      final response = await GraphQLRepository.deleteUserFeedLike(likeId);

      final data = response.data?['deleteFeedLike'] as Map<String, dynamic>;

      return (error: null, likeDetails: data);
    } catch (e) {
      return (error: e.toString(), likeDetails: null);
    }
  }

  Future<({String? error, List<Comment>? feedComments})> loadFeedComments(
      {required String feedId}) async {
    try {
      final response =
          await GraphQLRepository.fetchFeedComments(feedId: feedId);

      final comment = response.data!['comments'] as List;
      final feedComments = comment.map((e) => Comment.fromMap(e)).toList();
      return (error: null, feedComments: feedComments);
    } catch (e) {
      return (error: e.toString(), feedComments: null);
    }
  }

  Future<({String? error, bool isCreated})> createFeedPost(
      {required PostModel postModel}) async {
    try {
      await GraphQLRepository.createPost(postModel);
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
      final response = await GraphQLRepository.editPost(postModel, postId);
      final updatedFeed = response.data?['updateUserFeed'] as Map<String, dynamic>?;
      if (updatedFeed == null) {
        return (error: 'updateUserFeed is null', feedDetails: null);
      }
      return (error: null, feedDetails: updatedFeed);
    } catch (e) {
      return (error: e.toString(), feedDetails: null);
    }
  }

  Future<({String? error, bool isDeleted})> deleteFeedPost(
      {required String postId}) async {
    try {
      final response = await GraphQLRepository.deleteUserPost(postId);
      print("Response is : $response");
      return (error: null, isDeleted: true);
    } catch (e) {
      return (error: e.toString(), isDeleted: false);
    }
  }







  // Future<({String? error, bool isCreated})> createCommentOnCommunityFeed({
  //   required CommentModel commentModel,
  // }) async {
  //   try {
  //     await GraphQLRepository.createCommentOnCommunityFeed(commentModel);
  //     return (error: null, isCreated: true);
  //   } catch (e) {
  //     return (error: e.toString(), isCreated: false);
  //   }
  // }
  //
  // Future<({String? error, bool isCreated})> likeCommunityFeed({
  //   required LikeModel likeModel,
  // }) async {
  //   try {
  //     await GraphQLRepository.likeCommunityFeed(likeModel);
  //     return (error: null, isCreated: true);
  //   } catch (e) {
  //     return (error: e.toString(), isCreated: false);
  //   }
  // }
}
