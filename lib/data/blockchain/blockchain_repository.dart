import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/ecomoto/config/wallet_connect/eip155.dart';
import 'package:emr_005/ecomoto/config/wallet_connect/wallet_connect/wallet_connect.dart';
import 'package:emr_005/ecomoto/config/wallet_connect/wallet_connect_modal/wallet_connect_modal_config.dart';
import 'package:emr_005/ecomoto/config/web3/web3_config.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:hex/hex.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/web3dart.dart';

import 'contracts/erc_20_smart_contract.dart';
import 'contracts/rental_smart_contract.dart';
import 'contracts/vehicle_smart_contract.dart';

class BlockChainRepository {
  BlockChainRepository._();

  static ({
    WalletType? walletType,
    String? address,
    String chainId,
    String topic,
    Web3App? web3App
  }) get walletConnectConfig => ((
        walletType: WalletConnect.currentWalletProvider,
        web3App: WalletConnect.client,
        chainId: WalletConnect.chainId,
        address: WalletConnect.walletAddress,
        topic: WalletConnect.topic
      ));

  static ({String? address, String chainId, String topic, IWeb3App? web3App})
      get walletConnectModalConfig => ((
            web3App: WalletConnectModal.service.web3App,
            chainId: WalletConnectModal.chainId,
            address: WalletConnectModal.walletAddress,
            topic: WalletConnectModal.topic
          ));

  static Future<List<dynamic>> getAllVehicles() async {
    final function = VehicleContract.getListedVehicles;

    return await Web3.client.call(
        contract: VehicleContract.contract, function: function, params: []);
  }

  static void openConnectedWallet() {
    WalletConnectModal.service.launchConnectedWallet();
  }

  static Future authenticateUser(String message) async {
    final future = EIP155.ethSign(
      web3App: walletConnectModalConfig.web3App! as Web3App,
      topic: walletConnectModalConfig.topic,
      chainId: walletConnectModalConfig.chainId,
      address: walletConnectModalConfig.address!,
      data: message,
    );
    WalletConnectModal.service.launchConnectedWallet();
    return await future;
  }

  static Future getERC20Approval() async {
    final transaction = Transaction.callContract(
        contract: ERC20Contract.contract,
        function: ERC20Contract.approval,
        parameters: [RentalContract.contract.address, BigInt.from(10000)]);
    final future = EIP155.ethSendTransactionContract(
      web3App: walletConnectModalConfig.web3App! as Web3App,
      topic: walletConnectModalConfig.topic,
      chainId: walletConnectModalConfig.chainId,
      address: walletConnectModalConfig.address!,
      transaction: transaction,
    );
    WalletConnectModal.service.launchConnectedWallet();
    return await future;
  }

  static Future setApprovalForAll() async {
    print(RentalContract.contract.address);
    final transaction = Transaction.callContract(
        contract: VehicleContract.contract,
        function: VehicleContract.setApproval,
        parameters: [RentalContract.contract.address, true]);
    final future = EIP155.ethSendTransactionContract(
      web3App: walletConnectModalConfig.web3App! as Web3App,
      topic: walletConnectModalConfig.topic,
      chainId: walletConnectModalConfig.chainId,
      address: walletConnectModalConfig.address!,
      transaction: transaction,
    );
    WalletConnectModal.service.launchConnectedWallet();
    return await future;
  }

  static Future rentVehicle(String vehicleId, DateTime startTime,
      DateTime endTime, String rentalDays) async {
    final transaction = Transaction.callContract(
        contract: RentalContract.contract,
        function: RentalContract.rentVehicle,
        parameters: [
          HEX.decode(vehicleId.substring(2)),
          BigInt.from(startTime.microsecondsSinceEpoch),
          BigInt.from(endTime.microsecondsSinceEpoch),
          BigInt.from(int.parse(rentalDays)),
        ]);
    final future = EIP155.ethSendTransactionContract(
      web3App: walletConnectModalConfig.web3App! as Web3App,
      topic: walletConnectModalConfig.topic,
      chainId: walletConnectModalConfig.chainId,
      address: walletConnectModalConfig.address!,
      transaction: transaction,
    );
    WalletConnectModal.service.launchConnectedWallet();
    return await future;
  }

  static Future verifyDriversLicense(
    String walletAddress,
  ) async {
    final transaction = Transaction.callContract(
        contract: RentalContract.contract,
        function: RentalContract.verifyDriverLicense,
        parameters: [
          EthereumAddress.fromHex(walletAddress),
        ]);
    final future = EIP155.ethSendTransactionContract(
      web3App: walletConnectModalConfig.web3App! as Web3App,
      topic: walletConnectModalConfig.topic,
      chainId: walletConnectModalConfig.chainId,
      address: walletConnectModalConfig.address!,
      transaction: transaction,
    );
    WalletConnectModal.service.launchConnectedWallet();
    return await future;
  }

  static Future<dynamic> listVehicle(
      String vehicleId, String email, String pricePerHour,
      [String testMetaURL = ""]) async {
    final transaction = Transaction.callContract(
        contract: VehicleContract.contract,
        function: VehicleContract.listVehicle,
        parameters: [
          testMetaURL,
          vehicleId,
          email,
          BigInt.from(int.parse(pricePerHour))
        ]);

    if (AppEnvironment.useWalletConnectModal) {
      final future = EIP155.ethSendTransactionContract(
        web3App: walletConnectModalConfig.web3App! as Web3App,
        topic: walletConnectModalConfig.topic,
        chainId: walletConnectModalConfig.chainId,
        address: walletConnectModalConfig.address!,
        transaction: transaction,
      );
      WalletConnectModal.service.launchConnectedWallet();
      return await future;
    } else {
      final future = EIP155.ethSendTransactionContract(
          web3App: walletConnectConfig.web3App!,
          topic: walletConnectConfig.topic,
          chainId: walletConnectConfig.chainId,
          address: walletConnectConfig.address!,
          transaction: transaction);
      WalletConnectHelpers.goToWallet(null, walletConnectConfig.walletType!);
      return await future;
    }
  }
}
