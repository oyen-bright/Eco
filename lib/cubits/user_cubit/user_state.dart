part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const UserState._();

  const factory UserState.details({required User user}) = _Details;

  String get usernameInitials {
    return map(
      details: (state) {
        final user = state.user;
        if (user.username.isNotEmpty) {
          final nameParts = user.username.split(' ');
          if (nameParts.length > 1) {
            return '${nameParts[0][0]}${nameParts[1][0]}';
          } else {
            return nameParts[0][0];
          }
        } else {
          return '';
        }
      },
    );
  }

  String get userID {
    return map(
      details: (state) {
        return state.user.id;
      },
    );
  }

  bool get isFirstLogin {
    return map(
      details: (state) {
        final user = state.user;
        return user.userOnboardingStatus == null;
      },
    );
  }
}
