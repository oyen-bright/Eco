part of 'community_bloc.dart';

@freezed
class CommunityState with _$CommunityState {
  const CommunityState._();
  const factory CommunityState.initial() = _Initial;
  const factory CommunityState.loading({ List<Community>? communities, List<CommunityPost>? communityFeeds, List<Member>? members}) = _CommunityLoading;
  const factory CommunityState.loaded({required List<Community> communities, required List<CommunityPost> communityFeeds, required List<Member> members}) = _CommunityLoaded;
  const factory CommunityState.error({
    required String errorMessage,
    List<Community>? communities,
    List<CommunityPost>? communityFeeds,
    List<Member>? members
  }) = _Error;

  List<CommunityPost>? get communityFeeds {
    return maybeWhen(
      orElse: () => [],
      loaded: (_,communityFeeds, ___) => communityFeeds,
      loading: (_, communityFeeds, ___) => [],
      error: (errorMessage, _, communityFeeds, ___) =>  [],
    );
  }

  List<Community> get communityData {
    return maybeWhen(
      orElse: () => [],
      loaded: (communities, __, ___) => communities,
      loading: (communities, __, ___) =>  [],
      error: (errorMessage, communities, __, ___) =>  [],
    );
  }

  List<Member>? get members {
    return maybeWhen(
      orElse: () => [],
      loaded: (_, __, members) => members,
      loading: (_, __, members) =>  [],
      error: (errorMessage, _, __, members) =>  [],
    );
  }
}
