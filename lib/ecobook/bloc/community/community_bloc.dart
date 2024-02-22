import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:emr_005/ecobook/bloc/community/community_comment_model.dart';
import 'package:emr_005/ecobook/bloc/community/community_feed_model.dart';
import 'package:emr_005/ecobook/bloc/community/community_model.dart';
import 'package:emr_005/ecobook/models/create_community.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cubits/loading_cubit/loading_cubit.dart';
import '../../../cubits/user_cubit/user_cubit.dart';
import '../../../services/pinata_service.dart';
import '../../../services/ecobook/community_service.dart';
import '../../models/post_model.dart';
import 'members_model.dart';

part 'community_event.dart';
part 'community_state.dart';
part 'community_bloc.freezed.dart';


class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityService communityService;
  final LoadingCubit loadingCubit;
  final UserCubit userCubit;
  final PinataService pinataService;
  final Map<String, Completer<void>> _likeCompleters = {};
  final Map<String, Completer<void>> _commentCompleters = {};
  CommunityBloc(
      this.communityService,
      this.loadingCubit,
      this.pinataService,
      this.userCubit
      ) : super(const _Initial()) {
    on<CommunityEvent>((event, emit) async{
      await event.map(
        loadCommunities: (event) async => await _loadCommunities(event, emit),
        loadCommunityFeeds: (event) async => await _loadCommunityFeeds(event, emit),
        loadMembers: (event) async => await _loadMembers(event, emit),
        loadCommunityFeedComments: (event) async =>
        await _loadPostComments(event, emit),
        commentOnCommunityPost: (event) async => await _commentOnPost(event, emit),
        likeCommunityFeed: (event) async => await _likeUnlikeFeedPost(event, emit),
        editCommunityPost: (event) async => await _editPost(event, emit),
        createCommunityPost: (event) async => await _createPost(event, emit),
        deleteCommunityPost: (event) async => await _deletePost(event, emit),
        createCommunity: (event) async => await _createCommunity(event, emit),


      );
    });
  }

  Future<void> _loadCommunities(_LoadCommunities event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communities: state.communityData));
    final response = await communityService.loadCommunities();
    print(response.communities);
    if (response.error != null) {
      emit(CommunityState.error(
        errorMessage: response.error!,
        communities: state.communityData,
      ));
    } else {
      emit(
          CommunityState.loaded(communities: response.communities!, communityFeeds: state.communityFeeds ?? [], members: state.members ?? []));
    }
  }


  Future<void> _loadCommunityFeeds(
      _LoadCommunityFeeds event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communityFeeds: state.communityFeeds));
    try {
      final communityId = event.communityId;
      final feedResponse =
      await communityService.loadCommunityFeeds(communityId: event.communityId);

      if (feedResponse.error == null) {
        final List<CommunityPost> communityPosts
        = feedResponse.communityPosts ?? [];

        final communities = state.communityData.map((element) {
          if (element.id == communityId) {
            return element.copyWith(communityPost: communityPosts);
          }
          return element;
        }).toList();

        emit(CommunityState.loaded(communities: communities, communityFeeds: _updateFeedWithUserLikes(feedResponse.communityPosts!), members: state.members ?? []));
      } else {
        emit(CommunityState.error(
          errorMessage: feedResponse.error!, communities: state.communityData,));
      }
    } catch (_) {
      return;
    }
  }

  Future<void> _loadMembers(
      _LoadMembers event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(members: state.members));
    try {
      final communityId = event.communityId;
      final memberResponse =
      await communityService.loadMembers(communityId: event.communityId);
      print("Imp  : ${memberResponse.members}");

      if (memberResponse.error == null) {

        final communities = state.communityData.map((element) {
          if (element.id == communityId) {
            return element.copyWith(members: memberResponse.members);
          }
          return element;
        }).toList();

        emit(CommunityState.loaded(communities: communities, communityFeeds: state.communityFeeds ?? [], members: memberResponse.members!));
      } else {
        emit(CommunityState.error(
          errorMessage: memberResponse.error!, communities: state.communityData, communityFeeds: state.communityFeeds, members: state.members));
      }
    } catch (_) {
      return;
    }
  }
  // Future<void> _loadCommunityFeeds(_LoadCommunityFeeds event, Emitter<CommunityState> emit) async {
  //   emit(CommunityState.loading(state.communityData));
  //   print('COmmunity Data is : ${state.communityData}');
  //   final response = await communityService.loadCommunityFeeds(communityId: event.communityId);
  //   if (response.error != null) {
  //     emit(CommunityState.error(
  //       errorMessage: response.error!,
  //       communityFeeds: state.communityFeeds,
  //       communities: state.communityData
  //     ));
  //   } else {
  //
  //     print('COmmunity Data is : ${state.communityData}');
  //     print(state.communityFeeds);
  //     emit(
  //         CommunityState.loaded(communityFeeds: _updateFeedWithUserLikes(response.communityPosts ?? []), communities : state.communityData ));
  //   }
  // }


  Future<void> _loadPostComments(
      _LoadComments event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communityFeeds: state.communityFeeds));
    try {
      final postId = event.postId;

      final commentsResponse =
      await communityService.loadComments(feedId: postId);

      if (commentsResponse.error == null) {
        final List<Comment> comments = commentsResponse.feedComments ?? [];

        final posts = state.communityFeeds!.map((element) {
          if (element.id == postId) {
            return element.copyWith(comments: comments);
          }
          return element;
        }).toList();


        emit(CommunityState.loaded(communityFeeds: posts, communities: state.communityData, members: state.members ?? []));
      } else {
        print('COmmunity Data is : ${state.communityData}');
        print(state.communityFeeds);
        emit(CommunityState.error(
            errorMessage: commentsResponse.error!, communityFeeds: state.communityFeeds));
      }
    } catch (_) {
      return;
    }
  }


  Future<void> _createPost(_CreatePost event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communityFeeds: state.communityFeeds));
    try {
      loadingCubit.loading(message: 'Creating Post');
      final response = await communityService.createCommunityPost(postModel: event.postModel, communityId: event.communityId);
      print('Resonse : $response');
      loadingCubit.loaded();

      if (response.isCreated) {
        add( CommunityEvent.loadCommunityFeeds(communityId: event.communityId));
        emit(CommunityState.loaded(communities: state.communityData, communityFeeds: state.communityFeeds ?? [], members: state.members ?? []));
      } else {
        emit(CommunityState.error(errorMessage: response.error!, communityFeeds: state.communityFeeds, communities: state.communityData));
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> _createCommunity(_CreateCommunity event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communities: state.communityData));
    try {
      loadingCubit.loading(message: 'Creating Community');
      final response = await communityService.createCommunity(communityInput: event.communityInput);
      print('response : $response');
      loadingCubit.loaded();

      if (response.isCreated) {
        add( const CommunityEvent.loadCommunities());
      } else {
        emit(CommunityState.error(errorMessage: response.error!, communities: state.communityData));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _commentOnPost(
      _CreateComment event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communityFeeds: state.communityFeeds));
    try {
      final postId = event.postId;
      final commentText = event.comment;

      if (_commentCompleters.containsKey(postId) &&
          !_commentCompleters[postId]!.isCompleted) {
        return;
      }

      _commentCompleters[postId] = Completer<void>();

      loadingCubit.loading();
      final response = await communityService.createComment(
          postId: postId, comment: commentText);
      loadingCubit.loaded();
      print("Response is : $response");

      _commentCompleters[postId]!.complete();

      if (response.error == null) {
        final updatedPosts = state.communityFeeds!.map((element) {
          if (element.id == postId) {
            final updatedComments = List<Comment>.from(element.comments ?? []);
            updatedComments.add(response.commentDetails!);

            return element.copyWith(comments: updatedComments);
          }
          return element;
        }).toList();

        emit(CommunityState.loaded(communities: state.communityData, communityFeeds: updatedPosts, members: state.members ?? []));
      } else {
        emit(CommunityState.error(
            errorMessage: response.error.toString(), communityFeeds: state.communityFeeds, communities: state.communityData));
      }
    } catch (e) {
      print("Error during comment creation: $e");
    }
  }

  Future<void> _deletePost(_DeletePost event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communityFeeds: state.communityFeeds));
    try {
      loadingCubit.loading();

      final response = await communityService.deletePost(postId: event.postId);

      loadingCubit.loaded();

      if (response.isDeleted) {
        add( CommunityEvent.loadCommunityFeeds(communityId: event.communityId));
      } else {
        emit(CommunityState.error(errorMessage: response.error!, communityFeeds: state.communityFeeds));
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




  Future<void> _editPost(_EditPost event, Emitter<CommunityState> emit) async {
    emit(CommunityState.loading(communityFeeds: state.communityFeeds));
    try {
      loadingCubit.loading();

      final response = await communityService.editPost(
        postModel: event.postModel,
        postId: event.postId,
      );

      print("Response details : ${response.feedDetails}");
      loadingCubit.loaded();

      if (response.feedDetails != null) {
        List<String> updatedImageUrls = [];
        List<String> updatedVideoUrls = [];

        if (response.feedDetails?['mediaUrl']?.isNotEmpty ?? false) {
          final media = response.feedDetails?['mediaUrl'][0];

          if (media != null) {
            if (media['imageUrl'] != null) {
              updatedImageUrls = (media['imageUrl'] as List<dynamic>)
                  .cast<String>();
            }
            if (media['videoUrl'] != null) {
              updatedVideoUrls = (media['videoUrl'] as List<dynamic>)
                  .cast<String>();
            }
          }
        }

        final updatedPosts = state.communityFeeds!
            .map((post) {
          if (post.id == event.postId) {
            return post.copyWith(
              content: response.feedDetails?['content'] ?? post.content,
              imageUrl: updatedImageUrls,
              videoUrl: updatedVideoUrls,
              media: [...updatedImageUrls, ...updatedVideoUrls],
            );
          } else {
            return post;
          }
        })
            .toList();

        print('Updated post is : $updatedPosts');

        emit(CommunityState.loaded(communities: state.communityData, communityFeeds: updatedPosts, members: state.members ?? []));
      } else {
        emit(
          CommunityState.error(
            errorMessage: response.error!,
            communityFeeds: state.communityFeeds,
            communities: state.communityData
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }


  void simulateLike(String postID, bool likePost, Emitter<CommunityState> emit) {
    final posts = state.communityFeeds!.map((element) {
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

    emit(CommunityState.loaded(communities: state.communityData, communityFeeds: posts, members: state.members ?? []));
  }

  void removeSimulatedLike(
      String postID, bool likePost, Emitter<CommunityState> emit) {
    state.communityFeeds!.map((element) {
      if (element.id == postID) {
        element.feedLikes.removeWhere((data) => data['id'] == 'simulated_like');
        element = element.copyWith(isLiked: !likePost);
      }
      return element;
    }).toList();
  }


  List<CommunityPost> _updateFeedWithUserLikes(List<CommunityPost> initialFeeds) {
    final userId = userCubit.state.userID;
    return initialFeeds.map((communityFeed) {
      final isLiked = (communityFeed.feedLikes
          .map((e) => e['likedBy']['id'] == userId)
          .isNotEmpty);
      return communityFeed.copyWith(isLiked: isLiked);
    }).toList();
  }

  Future<void> _likeUnlikeFeedPost(
      _LikePost event, Emitter<CommunityState> emit) async {
    try {
      String getLikeId({required String postID, required String userID}) {
        final post = state.communityFeeds!.firstWhere((element) => (element.id == postID));

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

      simulateLike(postID, likePost, emit);

      if (_likeCompleters.containsKey(postID) &&
          !_likeCompleters[postID]!.isCompleted) {
        return;
      }

      _likeCompleters[postID] = Completer<void>();

      final response = likePost
          ? await communityService.likeCommunityFeed(feedId: postID)
          : await communityService.unLikeCommunityFeed(
          likeId: getLikeId(
              postID: event.postId, userID: userCubit.state.userID));
      _likeCompleters[postID]!.complete();

      removeSimulatedLike(postID, likePost, emit);

      if (response.likeDetails != null) {
        final posts = state.communityFeeds!.map((element) {
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

        emit(CommunityState.loaded(communityFeeds: posts, communities: state.communityData, members: state.members ?? []));
      } else {
        emit(CommunityState.error(errorMessage: response.error!, communityFeeds: state.communityFeeds, communities: state.communityData));
      }
    } catch (e) {
      print(e);
      return;
    }
   }
}
