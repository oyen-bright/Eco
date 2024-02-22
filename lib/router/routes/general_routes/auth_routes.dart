import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/ui/views/authentication/complete_profile/complete_profile_view.dart';
import 'package:emr_005/ui/views/authentication/login/login_view.dart';
import 'package:emr_005/ui/views/authentication/reset_password/create_password/create_password_view.dart';
import 'package:emr_005/ui/views/authentication/reset_password/forget_password/forget_password_view.dart';
import 'package:emr_005/ui/views/authentication/reset_password/forget_password_otp/forget_password_otp_view.dart';
import 'package:go_router/go_router.dart';

class Auth {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.login,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const LoginView(),
          state: state,
        );
      },
    ),

    // GoRoute(
    //   parentNavigatorKey: AppRouter.parentNavigatorKey,
    //   path: AppRoutes.signUp,
    //   pageBuilder: (context, state) {
    //     return AppRouter.setupPage(
    //       child: const SignUpView(),
    //       state: state,
    //     );
    //   },
    // ),

    // GoRoute(
    //   parentNavigatorKey: AppRouter.parentNavigatorKey,
    //   path: AppRoutes.activateAccount,
    //   redirect: (context, state) {
    //     final code = state.extra;
    //     if (code == null) {
    //       return AppRoutes.signUp;
    //     }
    //     return null;
    //   },
    //   pageBuilder: (context, state) {
    //     final generatedPassword = state.extra;
    //     return AppRouter.setupPage(
    //       child: ActivateAccountView(
    //         generatedPassword: generatedPassword.toString(),
    //       ),
    //       state: state,
    //     );
    //   },
    // ),
    // GoRoute(
    //   parentNavigatorKey: AppRouter.parentNavigatorKey,
    //   path: AppRoutes.otpVerification,
    //   pageBuilder: (context, state) {
    //     final enteredEmail = state.extra;
    //     final enteredPhone = state.extra;

    //     return AppRouter.setupPage(
    //       child: OtpVerificationView(
    //         enteredEmail: enteredEmail.toString(),
    //         enteredPhone: enteredPhone.toString(),
    //       ),
    //       state: state,
    //     );
    //   },
    // ),
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.completeProfile,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const CompleteProfileView(),
          state: state,
        );
      },
    ),

    ///Forget Password Routes///

    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.forgetPasswordChangeView,
      pageBuilder: (context, state) {
        final enteredEmail = state.extra as String?;
        return AppRouter.setupPage(
          child: CreatePasswordView(email: enteredEmail ?? ""),
          state: state,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.forgetPasswordOtpView,
      pageBuilder: (context, state) {
        final enteredEmail = state.extra;
        return AppRouter.setupPage(
          child: ForgetPasswordOtpView(enteredEmail: enteredEmail.toString()),
          state: state,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.forgetPassword,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const ForgetPasswordView(),
          state: state,
        );
      },
    ),
  ];
}
