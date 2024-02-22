part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated({
    required String userId,
    required String token,
    required bool isFistLogin,
  }) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error({
    required String errorMessage,
    @Default(false) bool isNewUser,
  }) = _Error;
}
