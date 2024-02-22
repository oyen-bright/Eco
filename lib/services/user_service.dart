import 'dart:async';
import 'dart:convert';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/cubits/user_cubit/user_model.dart';
import 'package:emr_005/data/blockchain/blockchain_repository.dart';
import 'package:emr_005/data/graphql/graphql_exceptions.dart';
import 'package:emr_005/data/graphql/graphql_repository.dart';
import 'package:emr_005/data/http/http_exceptions.dart' as http_exceptions;
import 'package:emr_005/data/http/http_repository.dart';
import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/ecomoto/config/wallet_manager/waller_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../ecomoto/config/siwe_config/siwe_config.dart';
import '../ecomoto/config/wallet_connect/wallet_connect_modal/wallet_connect_modal_config.dart';
import '../utils/enums.dart';

class UserService {
  UserService();

  /// Initiates a login request with the provided [email] and [password].
  /// Returns a [Future] that resolves to a tuple containing an [error] message and a [bool] indicating whether the user is authenticated or not.
  /// If the login is successful, the [error] will be null, and [isAuthenticated] will be true. Otherwise, [isAuthenticated] will be false.
  Future<({String? error, ({String accessToken, String userID})? token})>
      login({
    required String email,
    required String password,
  }) async {
    try {
      // Initiating the login request with the provided [email] and [password]
      final response = await GraphQLRepository.login(email, password);

      // Extracting the accessToken and userId from the response
      final accessToken = response.data?['login']['accessToken'] as String;
      final userId = response.data?['login']['id'] as String;

      // Saving the accessToken and userId to the local storage
      await Future.wait([
        LocalStorage.saveAccessToken(accessToken),
        LocalStorage.saveUserId(userId),
      ]);

      // Return a tuple with no error and isAuthenticated set to true
      return (error: null, token: (accessToken: accessToken, userID: userId));
    } catch (e) {
      // In case of an error, return the error message as a string and set isAuthenticated to false
      return (error: e.toString(), token: null);
    }
  }

  Future<({String? error, String? nonce, bool isNewUser})> generateNonce(
      String walletAddress) async {
    try {
      final response = await GraphQLRepository.requestNonce(walletAddress);
      final nonce = response.data?["requestNonce"]["nonce"] as String?;

      return (error: null, nonce: nonce, isNewUser: false);
    } on NotFoundException catch (_) {
      return (
        error: "Wallet Connected, complete registration",
        nonce: null,
        isNewUser: true
      );
    } catch (e) {
      return (error: e.toString(), nonce: null, isNewUser: false);
    }
  }

  Future<
      ({
        String? error,
        String? walletAddress,
      })> connectAndGetWalletAddress(BuildContext context) async {
    try {
      final walletService = WalletConnectModal.service;
      final walletAddress = WalletConnectModal.walletAddress;

      if (await WalletManager.isAvailable) {
        final generatedWallet = await WalletManager.details;
        //TODO: testing for ios only for now
        if (generatedWallet != null) {
          return (
            error: null,
            walletAddress: generatedWallet.publicKey,
          );
        }
      }

      if (!walletService.isConnected || walletAddress == null) {
        //TODO: test for infinite loop
        return WalletConnectModal.service
            .openModal(context)
            .then((value) => connectAndGetWalletAddress(context));
      }
      return (
        error: null,
        walletAddress: walletAddress,
      );
    } on JsonRpcError catch (e) {
      return (
        error: e.toString(),
        walletAddress: null,
      );
    } catch (e) {
      return (
        error: e.toString(),
        walletAddress: null,
      );
    }
  }

  Future<({String? error, ({String accessToken, String userID})? token})>
      loginWithWallet({
    required String sIWENonce,
    required String walletAddress,
  }) async {
    try {
      final walletAddressHexEip55 =
          EthereumAddress.fromHex(walletAddress).hexEip55;
      final message = SIWEthereum.client.createMessage(
          walletAddress: walletAddressHexEip55, nonce: sIWENonce);
      late final dynamic signature;

      if (await WalletManager.isAvailable) {
        signature = await WalletManager.signMessage(
            message: message.message, chainId: 80001);
      } else {
        signature = await BlockChainRepository.authenticateUser(message.message)
            .timeout(AppConstants.transactionTimeout.seconds,
                onTimeout: () => throw TimeoutException(
                    "Connection to wallet timeout, ${AppConstants.appErrorMessage}"));
      }

      final verifySIWESignature = await GraphQLRepository.verifySIWESignature(
          signature.toString(), message.message);

      final accessToken = verifySIWESignature.data?['verifySIWESignature']
          ['accessToken'] as String;
      final userId =
          verifySIWESignature.data?['verifySIWESignature']['id'] as String;

      // Saving the accessToken and userId to the local storage
      await Future.wait([
        LocalStorage.saveAccessToken(accessToken),
        LocalStorage.saveUserId(userId),
      ]);

      return (error: null, token: (accessToken: accessToken, userID: userId));
    } on TimeoutException catch (e) {
      return (error: e.toString(), token: null);
    } on JsonRpcError catch (e) {
      return (error: e.toString(), token: null);
    } catch (e) {
      return (error: e.toString(), token: null);
    }
  }

  Future<({String? error, bool isSent})> createAccount(
      {required String email,
      required String phone,
      required String firstName,
      required String? walletAddress,
      required String lastName}) async {
    try {
      if (walletAddress == null) {
        return (
          error: "no wallet found please connect or generate a waller first",
          isSent: false
        );
      }
      await GraphQLRepository.signUpUser(
          email.trim(), phone, firstName, lastName, walletAddress.trim());
      return (error: null, isSent: true);
    } catch (e) {
      return (error: e.toString(), isSent: false);
    }
  }

  Future<({String? error, bool isRegistered})> registerUser(
      {required String? userId,
      required String oldPassword,
      required String newPassword,
      required UserOnboardingStatus userOnboardingStatus,
      required String username}) async {
    try {
      await GraphQLRepository.registerUser(
          userId, oldPassword, newPassword, username, userOnboardingStatus);

      return (error: null, isRegistered: true);
    } catch (e) {
      return (error: e.toString(), isRegistered: false);
    }
  }

  Future<({String? error, bool isChanged})> changePassword(
      {required String? userId,
      required String oldPassword,
      required String newPassword}) async {
    try {
      await GraphQLRepository.changePassword(userId, oldPassword, newPassword);

      return (error: null, isChanged: true);
    } catch (e) {
      return (error: e.toString(), isChanged: false);
    }
  }

  Future<({String? error, bool isChanged})> changeEmail(
      {required String? userId,
      required String password,
      required String newEmail}) async {
    try {
      await GraphQLRepository.changeEmail(userId, password, newEmail);

      return (error: null, isChanged: true);
    } catch (e) {
      return (error: e.toString(), isChanged: false);
    }
  }

  Future<({String? error, bool isUpdated})> updateUserInformation(
      {required String? userId,
      required String username,
      required String firstName,
      required String lastName}) async {
    try {
      await GraphQLRepository.updateGeneralSettings(
          userId, username, firstName, lastName);

      return (error: null, isUpdated: true);
    } catch (e) {
      return (error: e.toString(), isUpdated: false);
    }
  }

  Future<({String? error, String? password})> verifyOTP({
    required String otpToken,
  }) async {
    try {
      final response = await GraphQLRepository.verifyOtp(otpToken.trim());
      final dynamic verifyEmailData = response.data?['verifyEmail'];
      final String password = verifyEmailData['password'];

      return (error: null, password: password);
    } catch (e) {
      return (error: e.toString(), password: null);
    }
  }

  Future<({String? error, User? user})> getUserInformation(
      {required String userId}) async {
    try {
      final response = await GraphQLRepository.getUserDetails(userId);

      final user = User.fromMap(response.data!['user']);
      return (error: null, user: user);
    } catch (e) {
      return (error: e.toString(), user: null);
    }
  }

  Future<({String? error, Map? verificationData})> verifyUserKYC(
      {required String sessionId}) async {
    try {
      final response = await HttpRepository.verifyAIpriseSessionID(sessionId);

      final verificationData =
          jsonDecode(response.body) as Map<String, dynamic>;

      print(verificationData);

      if (verificationData['aiprise_summary']['verification_result'] ==
              "APPROVED" ||
          verificationData['aiprise_summary']['verification_result'] ==
              "UNKNOWN") {
        return (error: null, verificationData: verificationData);
      } else {
        final errorResponse = verificationData['status_reasons'] != null
            ? verificationData['status_reasons'][0]['message'].toString()
            : verificationData['status'].toString();
        return (error: errorResponse, verificationData: null);
      }
    } on http_exceptions.BadRequestException catch (_) {
      return (error: AppConstants.appErrorMessage, verificationData: null);
    } catch (e) {
      return (error: e.toString(), verificationData: null);
    }
  }

  Future<({String? error})> updateUserKYC(
      {required String userId,
      required Map userDriverKYC,
      required UserOnboardingStatus userOnboardingStatus}) async {
    try {
      await GraphQLRepository.updateUserDriverKYC(
          userId, userDriverKYC, userOnboardingStatus);

      // await GraphQLRepository.updateUserOnboardingStatus(
      //     userId, userOnboardingStatus);

      return (error: null);
    } catch (e) {
      return (error: e.toString());
    }
  }

  Future<({String? error, String? message})> forgetPassword(
      {required String email}) async {
    try {
      final response = await GraphQLRepository.forgetPassword(email);
      final message = response.data?['forgetPassword']?['message'] as String?;

      return (error: null, message: message);
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }

  Future<({String? error, String? message})> resetPassword(
      {required String email,
      required String password,
      required String confirmPassword,
      required String token}) async {
    try {
      if (password != confirmPassword) {
        return (error: "passwords do not match", message: "");
      }
      final response = await GraphQLRepository.resetPassword(
          email, password, confirmPassword, token);

      final message = response.data?['resetPassword']?['message'] as String?;

      return (error: null, message: message);
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }
}
