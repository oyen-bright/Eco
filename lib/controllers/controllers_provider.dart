import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_scaffold_controller.dart';

class ControllersProvider extends StatelessWidget {
  final Widget child;
  const ControllersProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppScaffoldController>(
          lazy: false,
          create: (context) => AppScaffoldController(),
        ),
        // RepositoryProvider<PermissionController>(
        //   create: (context) => PermissionController(),
        // ),
      ],
      child: child,
    );
  }
}
