import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/auth_tab_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_forgot_password_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_sign_in_with_new_password_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_sign_up_page.dart';
import 'package:event_planr_app/ui/auth/view/forgot_password_page.dart';
import 'package:event_planr_app/utils/bloc_route.dart';
import 'package:go_router/go_router.dart';

final authRouter = ShellRoute(
  builder: (context, state, child) => child,
  routes: [
    BlocRoute<AuthCubit>(
      path: PagePaths.signIn,
      builder: (_) => const AuthTabPage(),
      init: (cubit, _) => cubit.autoLogin(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.signUp,
      builder: (_) => const AuthTabPage(),
      init: (cubit, _) => cubit.autoLogin(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.forgotPassword,
      builder: (_) => const ForgotPasswordPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.confirmSignUp,
      builder: (_) => const ConfirmSignUpPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.confirmSignUpWithPassword,
      builder: (_) => const ConfirmSignInWithNewPasswordPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.confirmForgotPassword,
      builder: (_) => const ConfirmForgotPasswordPage(),
    ),
  ],
);
