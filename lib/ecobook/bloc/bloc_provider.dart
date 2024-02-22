import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecobook/bloc/community/community_bloc.dart';
import 'package:emr_005/services/ecobook/community_service.dart';
import 'package:emr_005/ecobook/bloc/feed/feed_bloc.dart';
import 'package:emr_005/services/ecobook/feed_service.dart';
import 'package:emr_005/services/pinata_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EcobookBlocProvider extends StatelessWidget {
  final Widget child;
  const EcobookBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context,) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            context.read<FeedService>(),
            context.read<LoadingCubit>(),
            context.read<PinataService>(),
            context.read<UserCubit>(), )
            ..add(const FeedEvent.loadFeeds()),
        ),

        BlocProvider<CommunityBloc>(

          create: (context) => CommunityBloc(
            context.read<CommunityService>(),
            context.read<LoadingCubit>(),
            context.read<PinataService>(),
            context.read<UserCubit>(),
          )..add(const CommunityEvent.loadCommunities()),

        ),

      ],
      child: child,

    );
  }
}
