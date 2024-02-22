import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log("from:${change.currentState.runtimeType} to:${change.nextState.runtimeType}.",
        name: "Bloc change: ${bloc.runtimeType}");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log("$bloc", name: "Bloc Created");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log("$error $stackTrace", name: "Bloc error");
  }
}
