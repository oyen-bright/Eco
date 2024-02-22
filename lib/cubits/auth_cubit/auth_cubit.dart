import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserService userService;
  final LoadingCubit loadingCubit;
  final WalletService walletService;

  final UserCubit userCubit;
  AuthCubit(
      this.userCubit, this.userService, this.loadingCubit, this.walletService)
      : super(const AuthState.unauthenticated());

  Future<void> authenticateUser(
      {required String email, required String password}) async {
    emit(const AuthState.unauthenticated());
    loadingCubit.loading();
    final loginResponse =
        await userService.login(email: email, password: password);

    if (loginResponse.token != null) {
      final accessToken = loginResponse.token!.accessToken;
      final userID = loginResponse.token!.userID;
      userCubit.setUserID(userID);

      final getUserDetailsResponse = await userCubit.getUserDetails();
      loadingCubit.loaded();

      if (getUserDetailsResponse.error != null) {
        emit(AuthState.error(
          errorMessage: getUserDetailsResponse.error!,
        ));
        return;
      } else {
        emit(AuthState.authenticated(
          token: accessToken,
          userId: userID,
          isFistLogin: userCubit.state.isFirstLogin,
        ));
        return;
      }
    } else {
      loadingCubit.loaded();
      emit(AuthState.error(errorMessage: loginResponse.error!));
      return;
    }
  }

  Future<void> authenticateUserWithWallet(
      {required BuildContext context, String? sIWENonce}) async {
    final connectWalletResponse =
        await userService.connectAndGetWalletAddress(context);

    if (connectWalletResponse.error != null ||
        connectWalletResponse.walletAddress == null) {
      emit(AuthState.error(errorMessage: connectWalletResponse.error!));
      return;
    }

    loadingCubit.loading();
    final generateNonceResponse =
        await userService.generateNonce(connectWalletResponse.walletAddress!);
    loadingCubit.loaded();

    if (generateNonceResponse.error != null ||
        generateNonceResponse.nonce == null) {
      emit(AuthState.error(
          errorMessage: generateNonceResponse.error!,
          isNewUser: generateNonceResponse.isNewUser));
      return;
    }

    loadingCubit.loading();
    final loginResponse = await userService.loginWithWallet(
        sIWENonce: generateNonceResponse.nonce ?? "",
        walletAddress: connectWalletResponse.walletAddress ?? "");

    if (loginResponse.token != null) {
      final accessToken = loginResponse.token!.accessToken;
      final userID = loginResponse.token!.userID;
      userCubit.setUserID(userID);
      final getUserDetailsResponse = await userCubit.getUserDetails();
      loadingCubit.loaded();

      if (getUserDetailsResponse.error != null) {
        emit(AuthState.error(errorMessage: getUserDetailsResponse.error!));
        return;
      } else {
        emit(AuthState.authenticated(
            userId: userID,
            isFistLogin: userCubit.state.isFirstLogin,
            token: accessToken));
        return;
      }
    } else {
      emit(const AuthState.unauthenticated());

      loadingCubit.loaded();
      return;
    }
  }
}
