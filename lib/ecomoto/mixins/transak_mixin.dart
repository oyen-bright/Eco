import 'dart:async';

import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:transak/transak.dart';

import '../config/transak/transak_config.dart';

mixin TransakTransactionHandler<T extends StatefulWidget> on State<T> {
  final StreamController<TransakEvent> _transakStreamController =
      StreamController<TransakEvent>();

  Transak get transakInstance => TransakPayment.client;

  StreamController<TransakEvent> get transakStreamController =>
      _transakStreamController;

  @override
  void dispose() {
    _transakStreamController.close();
    super.dispose();
  }

  void initiateTransaction(BuildContext context) async {
    try {
      await transakInstance.initiateTransactionWithStream(
          TransactionParams.forBuy(
              fiatAmount: 32.50,
              email: "oyenbrihight@gmail.com",
              walletAddress: "0x9ABbDFE98A3f89c493831E1c8f3146378CF49f7E",
              fiatCurrency: "USD",
              cryptoCurrencyCode: "ETH"),
          streamController: _transakStreamController);

      _transakStreamController.stream.listen((event) {
        if (event.transactionEventName != null) {
          switch (event.transactionEventName) {
            case null:
              break;
            case TransactionEventName.orderPaymentVerifying:
            case TransactionEventName.orderCreated:
            case TransactionEventName.orderProcessingPendingDeliveryFromTransak:
            case TransactionEventName.orderProcessing:
              _showSnackBar(
                  context, event.transactionEventName!.value, BarType.loading);
              break;
            case TransactionEventName.orderFailedExpired:
            case TransactionEventName.orderFailedCardDeclined:
            case TransactionEventName.orderFailedUserCancelled:
              _showSnackBar(
                  context, event.transactionEventName!.value, BarType.error);
              break;
            case TransactionEventName.orderCompleted:
              _showSnackBar(context, event.transactionEventName!.value);
              break;
          }
        }
      });
    } on TransakException catch (e) {
      if (context.mounted) {
        _showSnackBar(context, e.errorMessage);
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, e.toString(), BarType.error);
      }
    }
  }

  void _showSnackBar(BuildContext context, String message,
      [BarType type = BarType.success]) {
    context.showSnackBar(message, type);
  }
}
