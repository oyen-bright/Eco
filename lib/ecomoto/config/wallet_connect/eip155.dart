import 'package:emr_005/extensions/transaction.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'ethereum_transaction.dart';

class EIP155 {
  /// Methods for different EIP-155 requests.
  static final Map<EIP155Methods, String> methods = {
    EIP155Methods.personalSign: 'personal_sign',
    EIP155Methods.ethSign: 'eth_sign',
    EIP155Methods.ethSignTransaction: 'eth_signTransaction',
    EIP155Methods.ethSignTypedData: 'eth_signTypedData',
    EIP155Methods.ethSendTransaction: 'eth_sendTransaction',
  };

  /// Events for EIP-155.
  static final Map<EIP155Events, String> events = {
    EIP155Events.chainChanged: 'chainChanged',
    EIP155Events.accountsChanged: 'accountsChanged',
  };

  /// Sign personal data using the WalletConnect client.
  static Future<dynamic> personalSign(
      {required IWeb3App web3App,
      required String topic,
      required String chainId,
      required String address,
      required String data}) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.personalSign]!,
        params: [data, address],
      ),
    );
  }

  /// Sign Ethereum data using the WalletConnect client.
  static Future<dynamic> ethSign(
      {required IWeb3App web3App,
      required String topic,
      required String chainId,
      required String address,
      required String data}) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSign]!,
        params: [address, data],
      ),
    );
  }

  /// Sign typed data using the WalletConnect client.
  static Future<dynamic> ethSignTypedData(
      {required IWeb3App web3App,
      required String topic,
      required String chainId,
      required String address,
      required String data}) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSignTypedData]!,
        params: [address, data],
      ),
    );
  }

  /// Sign Ethereum transaction using the WalletConnect client.
  static Future<dynamic> ethSignTransaction({
    required IWeb3App web3App,
    required String topic,
    required String chainId,
    required String address,
    required EthereumTransaction transaction,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSignTransaction]!,
        params: [transaction.toJson()],
      ),
    );
  }

  /// Send Ethereum transaction using the WalletConnect client.
  static Future<dynamic> ethSendTransaction({
    required IWeb3App web3App,
    required String topic,
    required String chainId,
    required String address,
    required EthereumTransaction transaction,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSendTransaction]!,
        params: [transaction.toJson()],
      ),
    );
  }

  /// Send Ethereum contract transaction using the WalletConnect client.
  static Future<dynamic> ethSendTransactionContract({
    required Web3App web3App,
    required String topic,
    required String chainId,
    required String address,
    required Transaction transaction,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSendTransaction]!,
        params: [transaction.toJson(fromAddress: address)],
      ),
    );
  }
}
