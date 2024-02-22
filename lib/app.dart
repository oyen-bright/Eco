import 'package:emr_005/blocs/bloc_provider.dart';
import 'package:emr_005/controllers/controllers_provider.dart';
import 'package:emr_005/cubits/cubit_provider.dart';
import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/ecobook/bloc/bloc_provider.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/service_provider.dart';
import 'package:emr_005/themes/app_theme.dart';
import 'package:emr_005/themes/wallet_connect_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'ecomoto/cubit/cubit_provider.dart';
import 'ui/components/overlays/loading_overlay.dart';
import 'ui/components/wrappers/keyboard_dismiss_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoriesProvider(
      child: AppCubitProvider(
        child: AppBlocProvider(
          child: EcobookBlocProvider(
            child: EcomotoCubitProvider(
              child: ControllersProvider(
                child: KeyBoardDismissWrapper(
                  child: Web3ModalTheme(
                    isDarkMode: false,
                    themeData: walletConnectModalTheme,
                    child: MaterialApp.router(
                      theme: AppTheme.theme,
                      debugShowCheckedModeBanner: false,
                      routerConfig: AppRouter.router,
                      builder: (context, child) {
                        final loadingState =
                            context.watch<LoadingCubit>().state;
                        return _buildApp(context, child, loadingState);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApp(
      BuildContext context, Widget? child, LoadingState loadingState) {
    final isLoading =
        loadingState.when(initial: () => false, loading: (_, __, ___) => true);
    return WillPopScope(
      onWillPop: () async {
        return isLoading;
      },
      child: Stack(
        children: [
          if (child != null) child,
          loadingState.when(
            initial: SizedBox.shrink,
            loading: (String? message, (String, void Function(), int?)? action1,
                    (String, void Function(), int?)? action2) =>
                Positioned.fill(
              child: LoadingOverlay(
                message: message,
                action1: action1,
                action2: action2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
