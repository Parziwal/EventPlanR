import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_state_handler.dart';
import 'package:event_planr_app/ui/auth/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInTab extends StatelessWidget {
  const SignInTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Image.asset(
            'assets/icon/icon.png',
            height: 150,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: authStateHandler,
            builder: (_, state) => SignInForm(
              disabled: state == const AuthState.loading(),
            ),
          ),
        ],
      ),
    );
  }
}
