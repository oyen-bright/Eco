import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/ui/components/wrappers/profile_view_wrapper.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ecomoto/mixins/wallet_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard/components/header/profile_header.dart';
import 'components/wallet_connect.dart';
import 'components/wallet_connect_modal.dart';
import 'constants/strings.dart';

class PaymentView extends StatelessWidget with WalletUtils {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileViewWrapper(
        automaticallyImplyLeading: true,
        title: Strings.viewTitle,
        actions: [
          ProfileHeader(
            foregroundColor: context.colorScheme.onPrimary,
          )
        ],
        body: Column(
          children: [
            (AppEnvironment.useWalletConnectModal)
                ? const WalletConnectModalView()
                : const WalletConnectView(),
            // TextButton(
            //     onPressed: () async {
            //       try {
            //         final StreamController<TransakEvent> transaction =
            //             StreamController();
            //         await PaymentGateway.client.initiateTransactionWithStream(
            //             TransactionParams.forBuy(
            //                 fiatAmount: 36.50,
            //                 email: "oyenbrihight@gmail.com",
            //                 walletAddress:
            //                     "0x9ABbDFE98A3f89c493831E1c8f3146378CF49f7E",
            //                 fiatCurrency: "USD",
            //                 cryptoCurrencyCode: "ETH"),
            //             streamController: transaction);

            //         transaction.stream.listen((event) {
            //           if (event.transactionEventName != null) {
            //             switch (event.transactionEventName) {
            //               case null:
            //                 break;
            //               case TransactionEventName.orderPaymentVerifying:
            //               case TransactionEventName.orderCreated:
            //               case TransactionEventName
            //                     .orderProcessingPendingDeliveryFromTransak:
            //               case TransactionEventName.orderProcessing:
            //                 context.showSnackBar(
            //                     event.transactionEventName!.value,
            //                     BarType.loading);
            //                 break;
            //               case TransactionEventName.orderFailedExpired:
            //               case TransactionEventName.orderFailedCardDeclined:
            //               case TransactionEventName.orderFailedUserCancelled:
            //                 context.showSnackBar(
            //                     event.transactionEventName!.value,
            //                     BarType.error);
            //                 break;
            //               case TransactionEventName.orderCompleted:
            //                 context.showSnackBar(
            //                   event.transactionEventName!.value,
            //                 );
            //                 transaction.close();
            //                 break;
            //             }
            //           }
            //         });
            //       } on TransakException catch (e) {
            //         if (context.mounted) {
            //           context.showSnackBar(
            //             e.errorMessage,
            //           );
            //         }
            //       } catch (e) {
            //         if (context.mounted) {
            //           context.showSnackBar(e.toString(), BarType.error);
            //         }
            //       }
            //     },
            //     child: const Text("Transak Buy")),
            // TextButton(
            //     onPressed: () async {
            //       try {
            //         final StreamController<TransakEvent> transaction =
            //             StreamController();
            //         await PaymentGateway.client.initiateTransactionWithStream(
            //             TransactionParams.forSell(
            //                 cryptoAmount: 11,
            //                 email: "oyenbrihight@gmail.com",
            //                 network: null,
            //                 fiatCurrency: "",
            //                 cryptoCurrencyCode: ""),
            //             streamController: transaction);

            //         transaction.stream.listen((event) {
            //           if (event.transactionEventName != null) {
            //             switch (event.transactionEventName) {
            //               case null:
            //                 break;
            //               case TransactionEventName.orderPaymentVerifying:
            //               case TransactionEventName.orderCreated:
            //               case TransactionEventName
            //                     .orderProcessingPendingDeliveryFromTransak:
            //               case TransactionEventName.orderProcessing:
            //                 context.showSnackBar(
            //                     event.transactionEventName!.value,
            //                     BarType.loading);
            //                 break;
            //               case TransactionEventName.orderFailedExpired:
            //               case TransactionEventName.orderFailedCardDeclined:
            //               case TransactionEventName.orderFailedUserCancelled:
            //                 context.showSnackBar(
            //                     event.transactionEventName!.value,
            //                     BarType.error);
            //                 break;
            //               case TransactionEventName.orderCompleted:
            //                 context.showSnackBar(
            //                   event.transactionEventName!.value,
            //                 );
            //                 transaction.close();
            //                 break;
            //             }
            //           }
            //         });
            //       } on TransakException catch (e) {
            //         if (context.mounted) {
            //           context.showSnackBar(
            //             e.errorMessage,
            //           );
            //         }
            //       } catch (e) {
            //         if (context.mounted) {
            //           context.showSnackBar(e.toString(), BarType.error);
            //         }
            //       }
            //     },
            //     child: const Text("test sell transact")),
            // TextButton(
            //     onPressed: () async {
            //       final response = await context
            //           .read<LocationService>()
            //           .distanceBetweenGeoLocations(
            //         useCache: false,
            //         destination: (long: "3.379205", lat: "6.7243783"),
            //       );
            //       print(response);
            //     },
            //     child: const Text("Distance Matrix")),
            // TextButton(
            //     onPressed: () async {
            //       final response = await context
            //           .read<LocationService>()
            //           .getCurrentLocation();
            //       print(response);
            //     },
            //     child: const Text("get location Matrix")),
            // TextButton(
            //     onPressed: () async {
            //       const Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           CupertinoNavigationBar(
            //             transitionBetweenRoutes: false,
            //           )
            //         ],
            //       ).asBottomSheet(context);
            //     },
            //     child: const Text("Modal sheet")),
            // TextButton(
            //     onPressed: () async {
            //       final response =
            //           await BlockChainRepository.getERC20Approval();
            //       print(response);
            //     },
            //     child: const Text("Rpc 20Approval")),
            // TextButton(
            //     onPressed: () async {
            //       // print(WalletConnectModal.walletAddress);
            //       print("Transaction Hash");
            //       final response = await BlockChainRepository.setApprovalForAll(
            //           WalletConnectModal.walletAddress!);
            //       print("Transaction Hash");
            //       print(response);
            //       print(WalletConnectModal.walletAddress!);
            //       print("Transaction Hash");
            //     },
            //     child: const Text("set Approval")),
            // TextButton(
            //     onPressed: () async {
            //       final response = await BlockChainRepository.rentVehicle(
            //           "0x3635373332343666633662666164636365326538633831610000000000000000",
            //           DateTime.now(),
            //           DateTime.now(),
            //           "1");
            //       // epoch time
            //       log(response.toString());

            //       // print(WalletConnectModal.walletAddress);
            //     },
            //     child: const Text("Test Vehicle Rental")),
            // TextButton(
            //     onPressed: () async {
            //       print("verify xx");
            //       final response =
            //           await BlockChainRepository.verifyDriversLicense(
            //               WalletConnectModal.walletAddress!);
            //       // epoch time
            //       log(response.toString());

            //       // print(WalletConnectModal.walletAddress);
            //     },
            //     child: const Text("verify Driver")),
            // TextButton(
            //     onPressed: () async {
            //       final response = await BlockChainRepository.listVehicle(
            //           "12949123134321", "oy@gmail.com", "123");
            //       // epoch time
            //       log(response.toString());

            //       // print(WalletConnectModal.walletAddress);
            //     },
            //     child: const Text("List Vehicle"))
          ],
        ));
  }
}
