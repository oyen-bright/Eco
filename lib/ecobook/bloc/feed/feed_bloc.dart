import 'dart:async';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecobook/bloc/feed/feed_comment_model.dart';
import 'package:emr_005/services/ecobook/feed_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../cubits/loading_cubit/loading_cubit.dart';
import '../../../services/pinata_service.dart';
import '../../models/post_model.dart';
import 'feed_model.dart';

part 'feed_bloc.freezed.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedService feedService;
  final LoadingCubit loadingCubit;
  final UserCubit userCubit;
  final PinataService pinataService;
  final Map<String, Completer<void>> _likeCompleters = {};
  final Map<String, Completer<void>> _commentCompleters = {};

  FeedBloc(
    this.feedService,
    this.loadingCubit,
    this.pinataService,
    this.userCubit,
  ) : super(const _Initial()) {
    on<FeedEvent>((event, emit) async {
        await event.map(
          loadFeeds: (event) async => await _loadFeeds(event, emit),
          loadUserFeeds: (event) async => await _loadFeedsByUser(event, emit),
          // loadLikeFeeds: (event) async => await _loadLikedFeeds(event, emit),
          commentOnPost: (event) async => await _commentOnPost(event, emit),
          loadFeedPostComments: (event) async =>
              await _loadFeedPostComments(event, emit),
          likeFeedPost: (event) async => await _likeUnlikeFeedPost(event, emit),
          editPost: (event) async => await _editPost(event, emit),
          createPost: (event) async => await _createPost(event, emit),
          deletePost: (event) async => await _deletePost(event, emit),


        );
      },
    );
  }

  Future<void> _loadFeeds(_LoadFeed event, Emitter<FeedState> emit) async {
    emit(FeedState.loading(feeds: state.data));
    final response = await Future.wait([feedService.loadUserFeeds(), feedService.loadFeedsByUserId(), feedService.loadLikedFeeds()]);
    if (response[0].error != null) {
      emit(FeedState.error(
        errorMessage: response[0].error!,
        feeds: state.data,
      ));
    } else {
      final userFeeds = response[1].error ==null ? _updateFeedWithUserLikes(response[1].feedPosts ?? []) : null;
      final List<FeedPost> allFeeds = response[0].error ==null ? _updateFeedWithUserLikes(response[0].feedPosts ?? []) : [];
      final likedFeeds = response[2].error ==null ? _updateFeedWithUserLikes(response[2].feedPosts ?? []) : null;

      print("Res  : ${response[0].feedPosts}");
      print("AllFeeds are : $allFeeds");
      print("userFeeds are : $userFeeds");
      print("Like are : $likedFeeds");

      emit(
          FeedState.loaded(feeds: allFeeds,
              userFeed :userFeeds
          , likePosts: likedFeeds));
    }
  }

  Future<void> _loadFeedsByUser(_LoadFeedsByUser event,  Emitter<FeedState> emit) async {
    emit(FeedState.loading(feeds: state.data));
    final response = await Future.wait([ feedService.loadFeedsByUserId(), feedService.loadLikedFeeds()]);
    if (response[0].error !=null || response[1].error  != null) {
      emit(FeedState.error(
        errorMessage: response[0].error ?? response[1].error! ,
        feeds: state.data,
      ));
    } else {
      final userFeeds =  _updateFeedWithUserLikes(response[0].feedPosts ?? []);
      final likedFeeds =  _updateFeedWithUserLikes(response[1].feedPosts ?? []);
      print('likes : $likedFeeds');

      emit(
          FeedState.loaded(feeds: _updateFeedWithUserLikes(state.data), userFeed: userFeeds,
          likePosts: likedFeeds,));
    }
  }

  // Future<void> _loadLikedFeeds(_LoadLikedFeeds event, Emitter<FeedState> emit) async {
  //   emit(FeedState.loading(feeds: state.data));
  //   final response = await feedService.loadLikedFeeds();
  //   if (response.error != null) {
  //     emit(FeedState.error(
  //       errorMessage: response.error!,
  //       feeds: state.data,
  //     ));
  //   } else {
  //     emit(
  //         FeedState.loaded(_updateFeedWithUserLikes(response.feedPosts ?? [])));
  //   }
  // }



  Future<void> _createPost(_CreatePost event, Emitter<FeedState> emit) async {
    try {


      loadingCubit.loading(message: 'Creating Post');
      final response = await feedService.createFeedPost(postModel: event.postModel);
      loadingCubit.loaded();

      if (response.isCreated) {
        add(const FeedEvent.loadFeeds());
      } else {
        emit(FeedState.error(errorMessage: response.error!, feeds: state.data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deletePost(_DeletePost event, Emitter<FeedState> emit) async {
    try {
      loadingCubit.loading();

      final response = await feedService.deleteFeedPost(postId: event.postId);

      loadingCubit.loaded();

      if (response.isDeleted) {
        add(const FeedEvent.loadFeeds());
      } else {
        emit(FeedState.error(errorMessage: response.error!, feeds: state.data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<({String? error, List imageCids, List videoCids})> uploadMedia({
     List<XFile>? imageFiles,
    List<XFile>? videoFiles,
  }) async {
    try {
      loadingCubit.loading(message: 'Uploading Media');
      final mediaResponse = await PinataService().uploadMedia(images: imageFiles, videos: videoFiles);
      return (error: null,
      imageCids: mediaResponse.ipfsHashImages?.toList() ?? [],
      videoCids : mediaResponse.ipfsHashVideos?.toList() ?? []);

    } catch (e) {
      return (error: e.toString(), imageCids: [], videoCids: []);
    }
  }

  Future<void> _editPost(_EditPost event, Emitter<FeedState> emit) async {
    try {
      loadingCubit.loading();

      final response = await feedService.editPost(
        postModel: event.postModel,
        postId: event.postId,
      );
      loadingCubit.loaded();

      if (response.feedDetails != null) {
        final updatedUserFeeds = state.userFeeds
            .map((post) => post.id == event.postId
            ? post.copyWith(
          content: response.feedDetails?['content'] ?? post.content,
          imageUrl: (response.feedDetails?['media']?[0]['imageUrl'] as List<dynamic>?)?.cast<String>() ?? post.imageUrl,
        )
            : post)
            .toList();

        final updatedLikedFeeds = state.likedFeeds
            .map((post) => post.id == event.postId
            ? post.copyWith(
          content: response.feedDetails?['content'] ?? post.content,
          imageUrl: (response.feedDetails?['media']?[0]['imageUrl'] as List<dynamic>?)?.cast<String>() ?? post.imageUrl,
        )
            : post)
            .toList();

        final updatedPosts = state.data
            .map((post) => post.id == event.postId
            ? post.copyWith(
          content: response.feedDetails?['content'] ?? post.content,
          imageUrl: (response.feedDetails?['media']?[0]['imageUrl'] as List<dynamic>?)?.cast<String>() ?? post.imageUrl,
        )
            : post)
            .toList();

        emit(FeedState.loaded(feeds: updatedPosts, userFeed: updatedUserFeeds, likePosts: updatedLikedFeeds));
      } else {
        emit(
          FeedState.error(
            errorMessage: response.error!,
            feeds: state.data,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _commentOnPost(
      _CommentOnPost event, Emitter<FeedState> emit) async {
    try {
      final postId = event.postId;
      final commentText = event.comment;

      if (_commentCompleters.containsKey(postId) &&
          !_commentCompleters[postId]!.isCompleted) {
        return;
      }

      _commentCompleters[postId] = Completer<void>();

      loadingCubit.loading();
      final response = await feedService.createCommentOnUserFeed(
          postId: postId, comment: commentText);
      loadingCubit.loaded();
      print("Response is : $response");

      _commentCompleters[postId]!.complete();

      if (response.error == null) {
        final updatedUserFeed = state.userFeeds.map((element) {
          if (element.id == postId) {
            final updatedComments = List<Comment>.from(element.comments ?? []);
            updatedComments.add(response.commentDetails!);

            return element.copyWith(comments: updatedComments);
          }
          return element;
        }).toList();

        final updateLikedFeed = state.likedFeeds.map((element) {
          if (element.id == postId) {
            final updatedComments = List<Comment>.from(element.comments ?? []);
            updatedComments.add(response.commentDetails!);

            return element.copyWith(comments: updatedComments);
          }
          return element;
        }).toList();

        final updatedPosts = state.data.map((element) {
          if (element.id == postId) {
            final updatedComments = List<Comment>.from(element.comments ?? []);
            updatedComments.add(response.commentDetails!);

            return element.copyWith(comments: updatedComments);
          }
          return element;
        }).toList();

        emit(FeedState.loaded(feeds: updatedPosts, userFeed: updatedUserFeed, likePosts: updateLikedFeed));
      } else {
        emit(FeedState.error(
            errorMessage: response.error.toString(), feeds: state.data));
      }
    } catch (e) {
      print("Error during comment creation: $e");
    }
  }

  Future<void> _loadFeedPostComments(
      _LoadFeedPostComments event, Emitter<FeedState> emit) async {
    try {
      final postId = event.postId;

      final commentsResponse =
          await feedService.loadFeedComments(feedId: postId);

      if (commentsResponse.error == null) {
        final List<Comment> comments = commentsResponse.feedComments ?? [];

        final posts = state.data.map((element) {
          if (element.id == postId) {
            return element.copyWith(comments: comments);
          }
          return element;
        }).toList();

        final userFeeds = state.userFeeds.map((element) {
          if (element.id == postId) {
            return element.copyWith(comments: comments);
          }
          return element;
        }).toList();
        final likedFeeds = state.likedFeeds.map((element) {
          if (element.id == postId) {
            return element.copyWith(comments: comments);
          }
          return element;
        }).toList();

        emit(FeedState.loaded(feeds: posts, userFeed: userFeeds, likePosts: likedFeeds));
      } else {
        emit(FeedState.error(
            errorMessage: commentsResponse.error!, feeds: state.data,));
      }
    } catch (_) {
      return;
    }
  }

  void simulateLike(String postID, bool likePost, Emitter<FeedState> emit) {
    final posts = state.data.map((element) {
      if (element.id == postID) {
        likePost
            ? element.feedLikes.add({
                'id': 'simulated_like',
                'likedBy': {'id': userCubit.state.userID}
              })
            : null;

        element = element.copyWith(isLiked: likePost);
      }
      return element;
    }).toList();

    emit(FeedState.loaded(feeds: posts, userFeed: state.userFeeds, likePosts: state.likedFeeds));
  }

  void removeSimulatedLike(
      String postID, bool likePost, Emitter<FeedState> emit) {
    state.data.map((element) {
      if (element.id == postID) {
        element.feedLikes.removeWhere((data) => data['id'] == 'simulated_like');
        element = element.copyWith(isLiked: !likePost);
      }
      return element;
    }).toList();
    state.userFeeds.map((element) {
      if (element.id == postID) {
        element.feedLikes.removeWhere((data) => data['id'] == 'simulated_like');
        element = element.copyWith(isLiked: !likePost);
      }
      return element;
    }).toList();
    state.likedFeeds.map((element) {
      if (element.id == postID) {
        element.feedLikes.removeWhere((data) => data['id'] == 'simulated_like');
        element = element.copyWith(isLiked: !likePost);
      }
      return element;
    }).toList();
  }

  Future<void> _likeUnlikeFeedPost(
      _LikeFeedPost event, Emitter<FeedState> emit) async {
    try {
      String getLikeId({required String postID, required String userID}) {
        final post = state.data.firstWhere((element) => (element.id == postID));

        final likeDetails = post.feedLikes
            .where((element) => element['likedBy']['id'] == userID)
            .firstOrNull;

        if (likeDetails == null) {
          throw "like details not found";
        }

        return likeDetails['id'];
      }

      final postID = event.postId;
      final likePost = !event.isLiked;

      if (_likeCompleters.containsKey(postID) &&
          !_likeCompleters[postID]!.isCompleted) {
        return;
      }
      simulateLike(postID, likePost, emit);

      _likeCompleters[postID] = Completer<void>();

      final response = likePost
          ? await feedService.likeUserFeed(feedId: postID)
          : await feedService.unLikeUserFeed(
              likeId: getLikeId(
                  postID: event.postId, userID: userCubit.state.userID));
      _likeCompleters[postID]!.complete();

      removeSimulatedLike(postID, likePost, emit);

      if (response.likeDetails != null) {
        final posts = state.data.map((element) {
          if (element.id != postID) {
            return element;
          }

          likePost
              ? element.feedLikes.add(response.likeDetails!)
              : element.feedLikes.removeWhere(
                  (data) => data['id'] == response.likeDetails?['id']);
          element = element.copyWith(isLiked: likePost);
          return element;
        }).toList();

        final userFeeds = state.userFeeds.map((element) {
          if (element.id != postID) {
            return element;
          }

          likePost
              ? element.feedLikes.add(response.likeDetails!)
              : element.feedLikes.removeWhere(
                  (data) => data['id'] == response.likeDetails?['id']);
          element = element.copyWith(isLiked: likePost);
          return element;
        }).toList();

        final likedFeeds = state.likedFeeds.map((element) {
          if (element.id != postID) {
            return element;
          }

          likePost
              ? element.feedLikes.add(response.likeDetails!)
              : element.feedLikes.removeWhere(
                  (data) => data['id'] == response.likeDetails?['id']);
          element = element.copyWith(isLiked: likePost);
          return element;
        }).toList();



        emit(FeedState.loaded(feeds: posts, userFeed: userFeeds, likePosts: likedFeeds));
      } else {
        emit(FeedState.error(errorMessage: response.error!, feeds: state.data));
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  List<FeedPost> _updateFeedWithUserLikes(List<FeedPost> initialFeeds) {
    final userId = userCubit.state.userID;

    return initialFeeds.map((feed) {
      print((feed.feedLikes
          .map((e) => e['likedBy']['id'] == userId).toString()));

      print((feed.feedLikes
          .map((e) => e['likedBy']['id'] == userId)
          .firstOrNull).toString());

      final isLiked = (feed.feedLikes
              .map((e) => e['likedBy']['id'] == userId)
              ).isNotEmpty;
      return feed.copyWith(isLiked: isLiked);
    }).toList();
  }

  @override
  void onEvent(FeedEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onChange(Change<FeedState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<FeedEvent, FeedState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
