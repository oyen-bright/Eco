part of 'feed_bloc.dart';

@freezed
class FeedState with _$FeedState {
  const FeedState._();

  const factory FeedState.initial() = _Initial;
  const factory FeedState.loading({List<FeedPost>? feeds}) = _Loading;
  const factory FeedState.loaded({
    required List<FeedPost> feeds,
    required List<FeedPost>? userFeed,
    required List<FeedPost>? likePosts
}) = _Loaded;
  const factory FeedState.error({
    required String errorMessage,
    List<FeedPost>? feeds,
  }) = _Error;


  List<FeedPost> get data {
    return maybeWhen(
        orElse: () => [],
        loaded: (feeds,_,__) => feeds,
        loading: (feeds) => feeds ?? [],
        error: (errorMessage, feeds) => feeds ?? []);
  }

  List<FeedPost> get userFeeds {
    return maybeWhen(
        orElse: () => [],
        loaded: (_,feeds,__) => feeds!,
        loading: (_) => [],
        error: (errorMessage, _) => []);
  }

  List<FeedPost> get likedFeeds {
    return maybeWhen(
        orElse: () => [],
        loaded: (_,__,feeds) => feeds!,
        loading: (_) => [],
        error: (errorMessage, _) => []);
  }
}
