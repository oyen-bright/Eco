// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedEventCopyWith<$Res> {
  factory $FeedEventCopyWith(FeedEvent value, $Res Function(FeedEvent) then) =
      _$FeedEventCopyWithImpl<$Res, FeedEvent>;
}

/// @nodoc
class _$FeedEventCopyWithImpl<$Res, $Val extends FeedEvent>
    implements $FeedEventCopyWith<$Res> {
  _$FeedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadFeedImplCopyWith<$Res> {
  factory _$$LoadFeedImplCopyWith(
          _$LoadFeedImpl value, $Res Function(_$LoadFeedImpl) then) =
      __$$LoadFeedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFeedImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$LoadFeedImpl>
    implements _$$LoadFeedImplCopyWith<$Res> {
  __$$LoadFeedImplCopyWithImpl(
      _$LoadFeedImpl _value, $Res Function(_$LoadFeedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadFeedImpl implements _LoadFeed {
  const _$LoadFeedImpl();

  @override
  String toString() {
    return 'FeedEvent.loadFeeds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFeedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return loadFeeds();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return loadFeeds?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (loadFeeds != null) {
      return loadFeeds();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return loadFeeds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return loadFeeds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (loadFeeds != null) {
      return loadFeeds(this);
    }
    return orElse();
  }
}

abstract class _LoadFeed implements FeedEvent {
  const factory _LoadFeed() = _$LoadFeedImpl;
}

/// @nodoc
abstract class _$$CommentOnPostImplCopyWith<$Res> {
  factory _$$CommentOnPostImplCopyWith(
          _$CommentOnPostImpl value, $Res Function(_$CommentOnPostImpl) then) =
      __$$CommentOnPostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String comment});
}

/// @nodoc
class __$$CommentOnPostImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$CommentOnPostImpl>
    implements _$$CommentOnPostImplCopyWith<$Res> {
  __$$CommentOnPostImplCopyWithImpl(
      _$CommentOnPostImpl _value, $Res Function(_$CommentOnPostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? comment = null,
  }) {
    return _then(_$CommentOnPostImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CommentOnPostImpl implements _CommentOnPost {
  const _$CommentOnPostImpl(this.postId, this.comment);

  @override
  final String postId;
  @override
  final String comment;

  @override
  String toString() {
    return 'FeedEvent.commentOnPost(postId: $postId, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentOnPostImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentOnPostImplCopyWith<_$CommentOnPostImpl> get copyWith =>
      __$$CommentOnPostImplCopyWithImpl<_$CommentOnPostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return commentOnPost(postId, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return commentOnPost?.call(postId, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (commentOnPost != null) {
      return commentOnPost(postId, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return commentOnPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return commentOnPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (commentOnPost != null) {
      return commentOnPost(this);
    }
    return orElse();
  }
}

abstract class _CommentOnPost implements FeedEvent {
  const factory _CommentOnPost(final String postId, final String comment) =
      _$CommentOnPostImpl;

  String get postId;
  String get comment;
  @JsonKey(ignore: true)
  _$$CommentOnPostImplCopyWith<_$CommentOnPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadFeedsByUserImplCopyWith<$Res> {
  factory _$$LoadFeedsByUserImplCopyWith(_$LoadFeedsByUserImpl value,
          $Res Function(_$LoadFeedsByUserImpl) then) =
      __$$LoadFeedsByUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFeedsByUserImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$LoadFeedsByUserImpl>
    implements _$$LoadFeedsByUserImplCopyWith<$Res> {
  __$$LoadFeedsByUserImplCopyWithImpl(
      _$LoadFeedsByUserImpl _value, $Res Function(_$LoadFeedsByUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadFeedsByUserImpl implements _LoadFeedsByUser {
  const _$LoadFeedsByUserImpl();

  @override
  String toString() {
    return 'FeedEvent.loadUserFeeds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFeedsByUserImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return loadUserFeeds();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return loadUserFeeds?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (loadUserFeeds != null) {
      return loadUserFeeds();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return loadUserFeeds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return loadUserFeeds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (loadUserFeeds != null) {
      return loadUserFeeds(this);
    }
    return orElse();
  }
}

abstract class _LoadFeedsByUser implements FeedEvent {
  const factory _LoadFeedsByUser() = _$LoadFeedsByUserImpl;
}

/// @nodoc
abstract class _$$LoadFeedPostCommentsImplCopyWith<$Res> {
  factory _$$LoadFeedPostCommentsImplCopyWith(_$LoadFeedPostCommentsImpl value,
          $Res Function(_$LoadFeedPostCommentsImpl) then) =
      __$$LoadFeedPostCommentsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$LoadFeedPostCommentsImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$LoadFeedPostCommentsImpl>
    implements _$$LoadFeedPostCommentsImplCopyWith<$Res> {
  __$$LoadFeedPostCommentsImplCopyWithImpl(_$LoadFeedPostCommentsImpl _value,
      $Res Function(_$LoadFeedPostCommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$LoadFeedPostCommentsImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadFeedPostCommentsImpl implements _LoadFeedPostComments {
  const _$LoadFeedPostCommentsImpl(this.postId);

  @override
  final String postId;

  @override
  String toString() {
    return 'FeedEvent.loadFeedPostComments(postId: $postId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadFeedPostCommentsImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadFeedPostCommentsImplCopyWith<_$LoadFeedPostCommentsImpl>
      get copyWith =>
          __$$LoadFeedPostCommentsImplCopyWithImpl<_$LoadFeedPostCommentsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return loadFeedPostComments(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return loadFeedPostComments?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (loadFeedPostComments != null) {
      return loadFeedPostComments(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return loadFeedPostComments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return loadFeedPostComments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (loadFeedPostComments != null) {
      return loadFeedPostComments(this);
    }
    return orElse();
  }
}

abstract class _LoadFeedPostComments implements FeedEvent {
  const factory _LoadFeedPostComments(final String postId) =
      _$LoadFeedPostCommentsImpl;

  String get postId;
  @JsonKey(ignore: true)
  _$$LoadFeedPostCommentsImplCopyWith<_$LoadFeedPostCommentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikeFeedPostImplCopyWith<$Res> {
  factory _$$LikeFeedPostImplCopyWith(
          _$LikeFeedPostImpl value, $Res Function(_$LikeFeedPostImpl) then) =
      __$$LikeFeedPostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, bool isLiked});
}

/// @nodoc
class __$$LikeFeedPostImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$LikeFeedPostImpl>
    implements _$$LikeFeedPostImplCopyWith<$Res> {
  __$$LikeFeedPostImplCopyWithImpl(
      _$LikeFeedPostImpl _value, $Res Function(_$LikeFeedPostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? isLiked = null,
  }) {
    return _then(_$LikeFeedPostImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LikeFeedPostImpl implements _LikeFeedPost {
  const _$LikeFeedPostImpl({required this.postId, required this.isLiked});

  @override
  final String postId;
  @override
  final bool isLiked;

  @override
  String toString() {
    return 'FeedEvent.likeFeedPost(postId: $postId, isLiked: $isLiked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeFeedPostImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, isLiked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeFeedPostImplCopyWith<_$LikeFeedPostImpl> get copyWith =>
      __$$LikeFeedPostImplCopyWithImpl<_$LikeFeedPostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return likeFeedPost(postId, isLiked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return likeFeedPost?.call(postId, isLiked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (likeFeedPost != null) {
      return likeFeedPost(postId, isLiked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return likeFeedPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return likeFeedPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (likeFeedPost != null) {
      return likeFeedPost(this);
    }
    return orElse();
  }
}

abstract class _LikeFeedPost implements FeedEvent {
  const factory _LikeFeedPost(
      {required final String postId,
      required final bool isLiked}) = _$LikeFeedPostImpl;

  String get postId;
  bool get isLiked;
  @JsonKey(ignore: true)
  _$$LikeFeedPostImplCopyWith<_$LikeFeedPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePostImplCopyWith<$Res> {
  factory _$$CreatePostImplCopyWith(
          _$CreatePostImpl value, $Res Function(_$CreatePostImpl) then) =
      __$$CreatePostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel postModel});
}

/// @nodoc
class __$$CreatePostImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$CreatePostImpl>
    implements _$$CreatePostImplCopyWith<$Res> {
  __$$CreatePostImplCopyWithImpl(
      _$CreatePostImpl _value, $Res Function(_$CreatePostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postModel = null,
  }) {
    return _then(_$CreatePostImpl(
      postModel: null == postModel
          ? _value.postModel
          : postModel // ignore: cast_nullable_to_non_nullable
              as PostModel,
    ));
  }
}

/// @nodoc

class _$CreatePostImpl implements _CreatePost {
  const _$CreatePostImpl({required this.postModel});

  @override
  final PostModel postModel;

  @override
  String toString() {
    return 'FeedEvent.createPost(postModel: $postModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostImpl &&
            (identical(other.postModel, postModel) ||
                other.postModel == postModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostImplCopyWith<_$CreatePostImpl> get copyWith =>
      __$$CreatePostImplCopyWithImpl<_$CreatePostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return createPost(postModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return createPost?.call(postModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (createPost != null) {
      return createPost(postModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return createPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return createPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (createPost != null) {
      return createPost(this);
    }
    return orElse();
  }
}

abstract class _CreatePost implements FeedEvent {
  const factory _CreatePost({required final PostModel postModel}) =
      _$CreatePostImpl;

  PostModel get postModel;
  @JsonKey(ignore: true)
  _$$CreatePostImplCopyWith<_$CreatePostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditPostImplCopyWith<$Res> {
  factory _$$EditPostImplCopyWith(
          _$EditPostImpl value, $Res Function(_$EditPostImpl) then) =
      __$$EditPostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel postModel, String postId});
}

/// @nodoc
class __$$EditPostImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$EditPostImpl>
    implements _$$EditPostImplCopyWith<$Res> {
  __$$EditPostImplCopyWithImpl(
      _$EditPostImpl _value, $Res Function(_$EditPostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postModel = null,
    Object? postId = null,
  }) {
    return _then(_$EditPostImpl(
      postModel: null == postModel
          ? _value.postModel
          : postModel // ignore: cast_nullable_to_non_nullable
              as PostModel,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditPostImpl implements _EditPost {
  const _$EditPostImpl({required this.postModel, required this.postId});

  @override
  final PostModel postModel;
  @override
  final String postId;

  @override
  String toString() {
    return 'FeedEvent.editPost(postModel: $postModel, postId: $postId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPostImpl &&
            (identical(other.postModel, postModel) ||
                other.postModel == postModel) &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postModel, postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditPostImplCopyWith<_$EditPostImpl> get copyWith =>
      __$$EditPostImplCopyWithImpl<_$EditPostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return editPost(postModel, postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return editPost?.call(postModel, postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (editPost != null) {
      return editPost(postModel, postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return editPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return editPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (editPost != null) {
      return editPost(this);
    }
    return orElse();
  }
}

abstract class _EditPost implements FeedEvent {
  const factory _EditPost(
      {required final PostModel postModel,
      required final String postId}) = _$EditPostImpl;

  PostModel get postModel;
  String get postId;
  @JsonKey(ignore: true)
  _$$EditPostImplCopyWith<_$EditPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePostImplCopyWith<$Res> {
  factory _$$DeletePostImplCopyWith(
          _$DeletePostImpl value, $Res Function(_$DeletePostImpl) then) =
      __$$DeletePostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$DeletePostImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$DeletePostImpl>
    implements _$$DeletePostImplCopyWith<$Res> {
  __$$DeletePostImplCopyWithImpl(
      _$DeletePostImpl _value, $Res Function(_$DeletePostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$DeletePostImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletePostImpl implements _DeletePost {
  const _$DeletePostImpl({required this.postId});

  @override
  final String postId;

  @override
  String toString() {
    return 'FeedEvent.deletePost(postId: $postId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePostImplCopyWith<_$DeletePostImpl> get copyWith =>
      __$$DeletePostImplCopyWithImpl<_$DeletePostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeeds,
    required TResult Function(String postId, String comment) commentOnPost,
    required TResult Function() loadUserFeeds,
    required TResult Function(String postId) loadFeedPostComments,
    required TResult Function(String postId, bool isLiked) likeFeedPost,
    required TResult Function(PostModel postModel) createPost,
    required TResult Function(PostModel postModel, String postId) editPost,
    required TResult Function(String postId) deletePost,
  }) {
    return deletePost(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeeds,
    TResult? Function(String postId, String comment)? commentOnPost,
    TResult? Function()? loadUserFeeds,
    TResult? Function(String postId)? loadFeedPostComments,
    TResult? Function(String postId, bool isLiked)? likeFeedPost,
    TResult? Function(PostModel postModel)? createPost,
    TResult? Function(PostModel postModel, String postId)? editPost,
    TResult? Function(String postId)? deletePost,
  }) {
    return deletePost?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeeds,
    TResult Function(String postId, String comment)? commentOnPost,
    TResult Function()? loadUserFeeds,
    TResult Function(String postId)? loadFeedPostComments,
    TResult Function(String postId, bool isLiked)? likeFeedPost,
    TResult Function(PostModel postModel)? createPost,
    TResult Function(PostModel postModel, String postId)? editPost,
    TResult Function(String postId)? deletePost,
    required TResult orElse(),
  }) {
    if (deletePost != null) {
      return deletePost(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeed value) loadFeeds,
    required TResult Function(_CommentOnPost value) commentOnPost,
    required TResult Function(_LoadFeedsByUser value) loadUserFeeds,
    required TResult Function(_LoadFeedPostComments value) loadFeedPostComments,
    required TResult Function(_LikeFeedPost value) likeFeedPost,
    required TResult Function(_CreatePost value) createPost,
    required TResult Function(_EditPost value) editPost,
    required TResult Function(_DeletePost value) deletePost,
  }) {
    return deletePost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeed value)? loadFeeds,
    TResult? Function(_CommentOnPost value)? commentOnPost,
    TResult? Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult? Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult? Function(_LikeFeedPost value)? likeFeedPost,
    TResult? Function(_CreatePost value)? createPost,
    TResult? Function(_EditPost value)? editPost,
    TResult? Function(_DeletePost value)? deletePost,
  }) {
    return deletePost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeed value)? loadFeeds,
    TResult Function(_CommentOnPost value)? commentOnPost,
    TResult Function(_LoadFeedsByUser value)? loadUserFeeds,
    TResult Function(_LoadFeedPostComments value)? loadFeedPostComments,
    TResult Function(_LikeFeedPost value)? likeFeedPost,
    TResult Function(_CreatePost value)? createPost,
    TResult Function(_EditPost value)? editPost,
    TResult Function(_DeletePost value)? deletePost,
    required TResult orElse(),
  }) {
    if (deletePost != null) {
      return deletePost(this);
    }
    return orElse();
  }
}

abstract class _DeletePost implements FeedEvent {
  const factory _DeletePost({required final String postId}) = _$DeletePostImpl;

  String get postId;
  @JsonKey(ignore: true)
  _$$DeletePostImplCopyWith<_$DeletePostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FeedState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<FeedPost>? feeds) loading,
    required TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)
        loaded,
    required TResult Function(String errorMessage, List<FeedPost>? feeds) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<FeedPost>? feeds)? loading,
    TResult? Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult? Function(String errorMessage, List<FeedPost>? feeds)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<FeedPost>? feeds)? loading,
    TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult Function(String errorMessage, List<FeedPost>? feeds)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedStateCopyWith<$Res> {
  factory $FeedStateCopyWith(FeedState value, $Res Function(FeedState) then) =
      _$FeedStateCopyWithImpl<$Res, FeedState>;
}

/// @nodoc
class _$FeedStateCopyWithImpl<$Res, $Val extends FeedState>
    implements $FeedStateCopyWith<$Res> {
  _$FeedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$FeedStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl extends _Initial {
  const _$InitialImpl() : super._();

  @override
  String toString() {
    return 'FeedState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<FeedPost>? feeds) loading,
    required TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)
        loaded,
    required TResult Function(String errorMessage, List<FeedPost>? feeds) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<FeedPost>? feeds)? loading,
    TResult? Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult? Function(String errorMessage, List<FeedPost>? feeds)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<FeedPost>? feeds)? loading,
    TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult Function(String errorMessage, List<FeedPost>? feeds)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends FeedState {
  const factory _Initial() = _$InitialImpl;
  const _Initial._() : super._();
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FeedPost>? feeds});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$FeedStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feeds = freezed,
  }) {
    return _then(_$LoadingImpl(
      feeds: freezed == feeds
          ? _value._feeds
          : feeds // ignore: cast_nullable_to_non_nullable
              as List<FeedPost>?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl extends _Loading {
  const _$LoadingImpl({final List<FeedPost>? feeds})
      : _feeds = feeds,
        super._();

  final List<FeedPost>? _feeds;
  @override
  List<FeedPost>? get feeds {
    final value = _feeds;
    if (value == null) return null;
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FeedState.loading(feeds: $feeds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality().equals(other._feeds, _feeds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_feeds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<FeedPost>? feeds) loading,
    required TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)
        loaded,
    required TResult Function(String errorMessage, List<FeedPost>? feeds) error,
  }) {
    return loading(feeds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<FeedPost>? feeds)? loading,
    TResult? Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult? Function(String errorMessage, List<FeedPost>? feeds)? error,
  }) {
    return loading?.call(feeds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<FeedPost>? feeds)? loading,
    TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult Function(String errorMessage, List<FeedPost>? feeds)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(feeds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends FeedState {
  const factory _Loading({final List<FeedPost>? feeds}) = _$LoadingImpl;
  const _Loading._() : super._();

  List<FeedPost>? get feeds;
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<FeedPost> feeds,
      List<FeedPost>? userFeed,
      List<FeedPost>? likePosts});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$FeedStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feeds = null,
    Object? userFeed = freezed,
    Object? likePosts = freezed,
  }) {
    return _then(_$LoadedImpl(
      feeds: null == feeds
          ? _value._feeds
          : feeds // ignore: cast_nullable_to_non_nullable
              as List<FeedPost>,
      userFeed: freezed == userFeed
          ? _value._userFeed
          : userFeed // ignore: cast_nullable_to_non_nullable
              as List<FeedPost>?,
      likePosts: freezed == likePosts
          ? _value._likePosts
          : likePosts // ignore: cast_nullable_to_non_nullable
              as List<FeedPost>?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl extends _Loaded {
  const _$LoadedImpl(
      {required final List<FeedPost> feeds,
      required final List<FeedPost>? userFeed,
      required final List<FeedPost>? likePosts})
      : _feeds = feeds,
        _userFeed = userFeed,
        _likePosts = likePosts,
        super._();

  final List<FeedPost> _feeds;
  @override
  List<FeedPost> get feeds {
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feeds);
  }

  final List<FeedPost>? _userFeed;
  @override
  List<FeedPost>? get userFeed {
    final value = _userFeed;
    if (value == null) return null;
    if (_userFeed is EqualUnmodifiableListView) return _userFeed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<FeedPost>? _likePosts;
  @override
  List<FeedPost>? get likePosts {
    final value = _likePosts;
    if (value == null) return null;
    if (_likePosts is EqualUnmodifiableListView) return _likePosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FeedState.loaded(feeds: $feeds, userFeed: $userFeed, likePosts: $likePosts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._feeds, _feeds) &&
            const DeepCollectionEquality().equals(other._userFeed, _userFeed) &&
            const DeepCollectionEquality()
                .equals(other._likePosts, _likePosts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_feeds),
      const DeepCollectionEquality().hash(_userFeed),
      const DeepCollectionEquality().hash(_likePosts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<FeedPost>? feeds) loading,
    required TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)
        loaded,
    required TResult Function(String errorMessage, List<FeedPost>? feeds) error,
  }) {
    return loaded(feeds, userFeed, likePosts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<FeedPost>? feeds)? loading,
    TResult? Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult? Function(String errorMessage, List<FeedPost>? feeds)? error,
  }) {
    return loaded?.call(feeds, userFeed, likePosts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<FeedPost>? feeds)? loading,
    TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult Function(String errorMessage, List<FeedPost>? feeds)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(feeds, userFeed, likePosts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded extends FeedState {
  const factory _Loaded(
      {required final List<FeedPost> feeds,
      required final List<FeedPost>? userFeed,
      required final List<FeedPost>? likePosts}) = _$LoadedImpl;
  const _Loaded._() : super._();

  List<FeedPost> get feeds;
  List<FeedPost>? get userFeed;
  List<FeedPost>? get likePosts;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage, List<FeedPost>? feeds});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$FeedStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
    Object? feeds = freezed,
  }) {
    return _then(_$ErrorImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      feeds: freezed == feeds
          ? _value._feeds
          : feeds // ignore: cast_nullable_to_non_nullable
              as List<FeedPost>?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl extends _Error {
  const _$ErrorImpl({required this.errorMessage, final List<FeedPost>? feeds})
      : _feeds = feeds,
        super._();

  @override
  final String errorMessage;
  final List<FeedPost>? _feeds;
  @override
  List<FeedPost>? get feeds {
    final value = _feeds;
    if (value == null) return null;
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FeedState.error(errorMessage: $errorMessage, feeds: $feeds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._feeds, _feeds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, errorMessage, const DeepCollectionEquality().hash(_feeds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<FeedPost>? feeds) loading,
    required TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)
        loaded,
    required TResult Function(String errorMessage, List<FeedPost>? feeds) error,
  }) {
    return error(errorMessage, feeds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<FeedPost>? feeds)? loading,
    TResult? Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult? Function(String errorMessage, List<FeedPost>? feeds)? error,
  }) {
    return error?.call(errorMessage, feeds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<FeedPost>? feeds)? loading,
    TResult Function(List<FeedPost> feeds, List<FeedPost>? userFeed,
            List<FeedPost>? likePosts)?
        loaded,
    TResult Function(String errorMessage, List<FeedPost>? feeds)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage, feeds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error extends FeedState {
  const factory _Error(
      {required final String errorMessage,
      final List<FeedPost>? feeds}) = _$ErrorImpl;
  const _Error._() : super._();

  String get errorMessage;
  List<FeedPost>? get feeds;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
