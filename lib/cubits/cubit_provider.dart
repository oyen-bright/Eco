import 'package:emr_005/cubits/auth_cubit/auth_cubit.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_cubit/loading_cubit.dart';
import 'user_cubit/user_cubit.dart';

class AppCubitProvider extends StatelessWidget {
  final Widget child;
  const AppCubitProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadingCubit>(
          create: (context) => LoadingCubit(),
        ),
        BlocProvider<UserCubit>(
          lazy: false,
          create: (context) => UserCubit(
            context.read<UserService>(),
            context.read<LoadingCubit>(),
            context.read<VehicleService>(),
            context.read<WalletService>(),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            context.read<UserCubit>(),
            context.read<UserService>(),
            context.read<LoadingCubit>(),
            context.read<WalletService>(),
          ),
        )
      ],
      child: child,
    );
  }
}
