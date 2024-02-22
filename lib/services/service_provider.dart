import 'package:emr_005/services/ecobook/community_service.dart';
import 'package:emr_005/services/ecobook/feed_service.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/services/firebase_service.dart';
import 'package:emr_005/services/pinata_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ecomoto/vehicle_service.dart';
import 'ecomoto/wallet_service.dart';
import 'user_service.dart';

class RepositoriesProvider extends StatelessWidget {
  final Widget child;
  const RepositoriesProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserService>(
          lazy: true,
          create: (context) => UserService(),
        ),
        RepositoryProvider<WalletService>(
          lazy: true,
          create: (context) => WalletService(),
        ),
        RepositoryProvider<VehicleService>(
          lazy: true,
          create: (context) => VehicleService(),
        ),
        RepositoryProvider<PinataService>(
          lazy: true,
          create: (context) => PinataService(),
        ),
        RepositoryProvider<LocationService>(
          lazy: true,
          create: (context) => const LocationService(),
        ),
        RepositoryProvider<FeedService>(
          lazy: true,
          create: (context) => FeedService(),
        ),
        RepositoryProvider<CommunityService>(
          lazy: true,
          create: (context) => CommunityService(),
        ),
        RepositoryProvider<FirebaseService>(
          lazy: true,
          create: (context) => FirebaseService(),
        ),
      ],
      child: child,
    );
  }
}
