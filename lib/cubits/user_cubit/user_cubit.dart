import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_model.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/services/user_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_cubit.freezed.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;
  final VehicleService vehicleService;
  final WalletService walletService;
  final LoadingCubit loadingCubit;

  UserCubit(
    this.userService,
    this.loadingCubit,
    this.vehicleService,
    this.walletService,
  ) : super(UserState.details(user: User.initial()));

  void setUserID(String userID) async {
    emit(UserState.details(user: state.user.copyWith(id: userID)));
  }

  Future<({String? error})> getUserDetails() async {
    final response = await userService.getUserInformation(userId: state.userID);

    if (response.user != null) {
      emit(UserState.details(user: response.user!));
      return (error: null);
    } else {
      return (error: response.error);
    }
  }

  Future<({String? error})> createUserAccount(
      {required String email,
      required String phone,
      required String firstName,
      required String lastName}) async {
    final walletAddress =
        (await walletService.getAvailableWallet())?.walletAddress;
    final response = await userService.createAccount(
        email: email,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        walletAddress: walletAddress);

    if (response.isSent) {
      return (error: null);
    } else {
      return (error: response.error);
    }
  }

  Future<({String? error, String? password})> otpVerification(
      {required String otp}) async {
    final response = await userService.verifyOTP(otpToken: otp);
    return response;
  }

  Future<({String? error})> registerUser({
    required String oldPassword,
    required String newPassword,
    required String username,
  }) async {
    loadingCubit.loading();
    const userOnboardingStatus = UserOnboardingStatus.setKyc;
    final response = await userService.registerUser(
        userId: state.userID,
        username: username,
        oldPassword: oldPassword,
        userOnboardingStatus: userOnboardingStatus,
        newPassword: newPassword);
    emit(UserState.details(
        user: state.user.copyWith(
            username: username, userOnboardingStatus: userOnboardingStatus)));
    loadingCubit.loaded();
    if (response.isRegistered) {
      return (error: null);
    }
    return (error: response.error);
  }

  Future<({String? error})> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    loadingCubit.loading();
    final response = await userService.changePassword(
        userId: state.userID,
        oldPassword: oldPassword,
        newPassword: newPassword);
    loadingCubit.loaded();
    if (response.isChanged) {
      return (error: null);
    }
    return (error: response.error);
  }

  Future<({String? error})> changeEmail({
    required String password,
    required String newEmail,
  }) async {
    loadingCubit.loading();
    final response = await userService.changeEmail(
        userId: state.userID, password: password, newEmail: newEmail);
    loadingCubit.loaded();
    if (response.isChanged) {
      return (error: null);
    }
    return (error: response.error);
  }

  Future<({String? error})> updateGeneralInfo({
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    loadingCubit.loading();
    final response = await userService.updateUserInformation(
        userId: state.userID,
        username: username,
        firstName: firstName,
        lastName: lastName);
    loadingCubit.loaded();
    if (response.isUpdated) {
      return (error: null);
    }
    return (error: response.error);
  }

  Future<({String? error})> updateUserDriverKYC(
      {required String sessionId}) async {
    loadingCubit.loading();
    try {
      final responseAIPriseVerification =
          await userService.verifyUserKYC(sessionId: sessionId);

      if (responseAIPriseVerification.error != null) {
        return (error: responseAIPriseVerification.error);
      }

      Map<String, dynamic> extractValues(Map<dynamic, dynamic> jsonMap) {
        Map<String, dynamic> newMap = Map.from(jsonMap);
        newMap['id_info'] = Map.from(newMap['id_info'] ?? {});
        newMap['id_info'].remove('warnings');
        return {
          "aiprise_summary": newMap["aiprise_summary"],
          "client_reference_id": newMap["client_reference_id"],
          "created_at": newMap["created_at"],
          "environment": newMap["environment"],
          "face_liveness_info": newMap["face_liveness_info"] != null
              ? {
                  "result": newMap["face_liveness_info"]["result"].toString(),
                  "source": newMap["face_liveness_info"]["source"].toString(),
                  "status": newMap["face_liveness_info"]["status"].toString(),
                }
              : null,
          "face_match_info": newMap["face_match_info"] != null
              ? {
                  "face_match_score":
                      newMap["face_match_info"]["face_match_score"].toString(),
                  "result": newMap["face_match_info"]["result"].toString(),
                  "status": newMap["face_match_info"]["status"].toString(),
                }
              : null,
          "id_info": newMap["id_info"],
          "status": newMap["status"],
          "template_id": newMap["template_id"],
          "verification_session_id": newMap["verification_session_id"],
        };
      }

      final responseUpdateKYC = await userService.updateUserKYC(
        userId: state.userID,
        userOnboardingStatus: UserOnboardingStatus.verifyDriverLicense,
        userDriverKYC:
            extractValues(responseAIPriseVerification.verificationData!),
      );
      // if (responseUpdateKYC.error != null) {
      //   return (error: responseUpdateKYC.error);
      // }
      final verifyDriversLicense = await vehicleService.verifyDriversLicense();
      if (verifyDriversLicense.error != null) {
        return (error: verifyDriversLicense.error);
      }

      emit(UserState.details(
          user: state.user.copyWith(
              userOnboardingStatus: UserOnboardingStatus.verifyDriverLicense)));

      return (error: null);
    } finally {
      loadingCubit.loaded();
    }
  }

  Future<
      ({
        String? error,
        Map<String, dynamic>? walletDetails,
        bool hasWalletAlready
      })> generateWallet({bool forceGenerateWallet = false}) async {
    final userHasGeneratedWallet = await walletService.hasGeneratedWallet;
    if (userHasGeneratedWallet && !forceGenerateWallet) {
      return (error: null, hasWalletAlready: true, walletDetails: null);
    }
    loadingCubit.loading();
    final response = await walletService.generateWallet();
    if (response.error != null || response.data == null) {
      loadingCubit.loaded();
      return (
        error: response.error ?? AppConstants.appErrorMessage,
        walletDetails: null,
        hasWalletAlready: false
      );
    }
    final walletDetails = response.data!;
    loadingCubit.loaded();

    return (error: null, hasWalletAlready: false, walletDetails: walletDetails);
  }

  Future<({String? error, String? message})> forgetPassword(
      {required String email}) async {
    loadingCubit.loading();
    final response = await userService.forgetPassword(email: email);

    loadingCubit.loaded();
    return response;
  }

  Future<({String? error, String? message})> resetPassword(
      {required String email,
      required String token,
      required String password,
      required String confirmPassword}) async {
    loadingCubit.loading();
    final response = await userService.resetPassword(
        confirmPassword: confirmPassword,
        email: email,
        password: password,
        token: token);
    loadingCubit.loaded();
    return response;
  }
}
