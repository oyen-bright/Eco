import 'dart:typed_data';

import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:eth_sig_util/eth_sig_util.dart';

class WalletManager {
  static Future<bool> get isAvailable async {
    return await (LocalStorage.generatedWallet) != null;
  }

  static Future<({String mnemonic, String privateKey, String publicKey})?>
      get details async {
    return await LocalStorage.generatedWallet;
  }

  static Future<String> signMessage(
      {required String message, int? chainId}) async {
    try {
      if (!await isAvailable) {
        throw "no wallet found";
      }

      final walletDetails = await details;
      if (walletDetails == null) {
        throw "no wallet found";
      }
      String privateKeyHex = walletDetails.privateKey;
      String signature = EthSigUtil.signPersonalMessage(
          privateKey: privateKeyHex,
          message: _convertStringToUint8List(message));

      return signature;
    } catch (e) {
      rethrow;
    }
  }

  static Uint8List _convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
