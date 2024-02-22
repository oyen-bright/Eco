import 'dart:async';
import 'dart:developer';

import 'package:emr_005/config/app_environment.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

/// The Web3 class provides functionality for interacting with a Web3 client,
/// specifically designed for handling transactions and verification.
///
/// Usage:
/// - Call init method to initialize the Web3 client with the specified RPC URL.
/// - Use verifyTransaction to check the status of a transaction by providing its hash.
///
/// Example:
/// ```dart
/// // Initialize the Web3 client
/// await Web3.init();
///
/// // Define a transaction hash to verify
/// final transactionHash = '0xabc123...';
///
/// // Verify the transaction
/// final verificationResult = await Web3.verifyTransaction(transactionHash);
/// if (verificationResult.isCompleted) {
///   print('Transaction was successful!');
/// } else {
///   print('Transaction failed. Error: ${verificationResult.error}');
/// }
/// ```
class Web3 {
  /// Private constructor to prevent direct instantiation.
  Web3._();

  /// The RPC URL for the Web3 client.
  static final rpcURL = AppEnvironment.rpcURL;

  /// The Web3 client instance.
  static late final Web3Client? _client;

  /// The delay between transaction verification attempts.
  static const _verificationDelay = Duration(milliseconds: 3000);

  /// The maximum time to wait for transaction verification (in seconds).
  static const _verificationTrialTime = 60;

  /// Get the Web3 client instance.
  static Web3Client get client {
    if (_client == null) {
      throw Exception('Web3 client has not been initialized. Call init first.');
    }

    return _client!;
  }

  /// Initialize the Web3 client.
  static Future<void> init() async {
    _client = Web3Client(rpcURL, http.Client());
  }

  /// Verify the status of a transaction using its hash.
  ///
  /// Parameters:
  /// - [transactionHash]: The hash of the transaction to be verified.
  ///
  /// Returns a Future with a Map containing the verification result.
  /// - [error]: A String indicating the error if the verification fails.
  /// - [isCompleted]: A boolean indicating whether the transaction was successfully verified.
  ///
  /// Example:
  /// ```dart
  /// final transactionHash = '0xabc123...';
  /// final verificationResult = await Web3.verifyTransaction(transactionHash);
  /// if (verificationResult.isCompleted) {
  ///   print('Transaction was successful!');
  /// } else {
  ///   print('Transaction failed. Error: ${verificationResult.error}');
  /// }
  /// ```
  static Future<
          ({String? error, bool isCompleted, TransactionReceipt? receipt})>
      verifyTransaction(
    String transactionHash,
  ) async {
    try {
      TransactionReceipt? receipt;

      final Stopwatch stopwatch = Stopwatch()..start();

      while (stopwatch.elapsed.inSeconds < _verificationTrialTime) {
        receipt = await client.getTransactionReceipt(transactionHash);

        if (receipt?.status != null) {
          stopwatch.stop();
          break;
        } else {
          await Future.delayed(_verificationDelay);
        }
      }

      if (receipt?.status == true) {
        log('Transaction verification Successful $transactionHash',
            name: "Web3");
        return (error: null, isCompleted: true, receipt: receipt);
      } else if (receipt?.status == false) {
        log('Transaction failed', name: "Web3");
        return (error: "Transaction Failed", isCompleted: false, receipt: null);
      } else {
        log('Transaction failed, response is NULL', name: "Web3");
        return (
          error:
              "We couldn't verify the transaction status. Please try again later.",
          isCompleted: false,
          receipt: null
        );
      }
    } catch (e) {
      log('Error on transaction verification $e', name: "Web3");
      return (error: e.toString(), isCompleted: false, receipt: null);
    }
  }

  static Stream<FilterEvent> listenToEvents({
    required DeployedContract contract,
    required ContractEvent contractEvent,
  }) {
    final ethFilter = FilterOptions.events(
      contract: contract,
      event: contractEvent,
    );

    return client.events(ethFilter).map((event) {
      // Assuming ContractEvent is a class with a named constructor
      // that can parse the event topics and data.
      // final decodedEvent = ContractEvent.fromRaw(
      //   event.topics,
      //   event.data,
      //   contractEvent,
      // );

      print('Event received: $event');

      return event; // Returning the decoded event.
    });
  }
}
