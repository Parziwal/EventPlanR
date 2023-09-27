import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_state_handler.dart';
import 'package:event_planr_app/ui/auth/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpTab extends StatelessWidget {
  const SignUpTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: authStateHandler,
          builder: (_, state) => SignUpForm(
            disabled: state == const AuthState.loading(),
          ),
        ),
      ),
    );
  }
}
