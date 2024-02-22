import 'package:emr_005/app.dart';
import 'package:emr_005/config/app_config.dart';
import 'package:emr_005/data/blockchain/contracts/rental_smart_contract.dart';
import 'package:emr_005/data/graphql/graphql_client.dart';
import 'package:emr_005/data/http/http_client.dart';
import 'package:emr_005/firebase_options.dart';
import 'package:emr_005/observer/bloc_observer.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'config/app_environment.dart';
import 'data/blockchain/contracts/erc_20_smart_contract.dart';
import 'data/blockchain/contracts/vehicle_smart_contract.dart';
import 'data/local_storage/local_storage.dart';
import 'ecomoto/config/cache_manager/cache_manager_config.dart';
import 'ecomoto/config/siwe_config/siwe_config.dart';
import 'ecomoto/config/smart_car_config/smart_car_config.dart';
import 'ecomoto/config/transak/transak_config.dart';
import 'ecomoto/config/wallet_connect/wallet_connect/wallet_connect.dart';
import 'ecomoto/config/wallet_connect/wallet_connect_modal/wallet_connect_modal_config.dart';
import 'ecomoto/config/web3/web3_config.dart';
import 'utils/enums.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppRouter.instance;
  GoogleFonts.config.allowRuntimeFetching = true;
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  await Hive.initFlutter();
  await AppEnvironment.init(Environment.development,
      useWalletConnectModal: true);
  await AppConfig.init();
  await LocalStorage.init();
  await SmartCar.init();
  await CacheManager.init();
  AppEnvironment.useWalletConnectModal
      ? await WalletConnectModal.init()
      : await WalletConnect.init();
  await Web3.init();
  await VehicleContract.instance.init();
  await RentalContract.instance.init();
  await ERC20Contract.instance.init();

  HttpClient.init();
  SIWEthereum.init();
  TransakPayment.init();
  GraphQLConfig.initClient();
  // debugPaintSizeEnabled = true;

  runApp(const MyApp());
}
