part of 'loading_cubit.dart';

@freezed
abstract class LoadingState with _$LoadingState {
  const factory LoadingState.initial() = _Initial;
  const factory LoadingState.loading({String? message}) = _Loading;
}
