import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/host_cubit/host_cubit.dart';
import 'package:emr_005/ecomoto/cubit/messaging_cubit/messaging_cubit.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/services/firebase_service.dart';
import 'package:emr_005/services/pinata_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_cubit/notification_cubit.dart';
import 'trips_cubit/trips_cubit.dart';
import 'vehicle_cubit/vehicle_cubit.dart';
import 'viewed_vehicle_cubit/viewed_vehicle_cubit.dart';
import 'wallet_cubit/wallet_cubit.dart';

class EcomotoCubitProvider extends StatelessWidget {
  final Widget child;
  const EcomotoCubitProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WalletCubit>(
          create: (context) => WalletCubit(context.read<WalletService>()),
        ),
        BlocProvider<VehicleCubit>(
          create: (context) => VehicleCubit(
              context.read<LoadingCubit>(),
              context.read<VehicleService>(),
              context.read<UserCubit>(),
              context.read<LocationService>(),
              context.read<WalletCubit>(),
              context.read<PinataService>()),
        ),
        BlocProvider<NotificationCubit>(
          lazy: false,
          create: (context) => NotificationCubit(context.read<UserCubit>()),
        ),
        BlocProvider<ViewedVehicleCubit>(
          create: (context) => ViewedVehicleCubit(),
        ),
        BlocProvider<MessagesCubit>(
          create: (context) => MessagesCubit(
            context.read<FirebaseService>(),
            context.read<UserCubit>(),
          ),
        ),
        BlocProvider<TripsCubit>(
          create: (context) => TripsCubit(
              context.read<VehicleService>(), context.read<UserCubit>()),
        ),
        BlocProvider<HostCubit>(
          create: (context) => HostCubit(
              context.read<VehicleService>(), context.read<UserCubit>()),
        ),
      ],
      child: child,
    );
  }
}
