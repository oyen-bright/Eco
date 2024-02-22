import 'package:emr_005/ui/components/overlays/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/loading_cubit.dart';
import 'email_verification/email_verification_view.dart';
import 'register_account/register_account_view.dart';
import 'router/navigator.dart';
import 'router/routes.dart';
import 'verification_success/verification_success_view.dart';

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthLoadingCubit(),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return context.read<AuthLoadingCubit>().state.maybeWhen(
                  loading: (_) => false,
                  orElse: () => true,
                )!;
          },
          child: Stack(
            children: [
              Navigator(
                key: AuthRouter.navigatorKey,
                initialRoute: AuthRoutes.registerAccount,
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case AuthRoutes.registerAccount:
                      return MaterialPageRoute(
                        builder: (_) => const RegisterAccountView(),
                      );

                    case AuthRoutes.activateAccount:
                      return MaterialPageRoute(
                        builder: (_) => EmailVerificationView(
                          userData: settings.arguments as Map<String, String>,
                        ),
                      );

                    case AuthRoutes.verificationSuccess:
                      return MaterialPageRoute(
                        builder: (_) => VerificationSuccessView(
                          generatedPassword: settings.arguments as String,
                        ),
                      );

                    default:
                      return null;
                  }
                },
              ),
              BlocBuilder<AuthLoadingCubit, LoadingState>(
                builder: (context, state) {
                  return state.when(
                    initial: SizedBox.shrink,
                    loading: (String? message) => Positioned.fill(
                      child: LoadingOverlay(
                        message: message,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
