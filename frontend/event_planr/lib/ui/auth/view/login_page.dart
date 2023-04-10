import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/theme/theme_extension.dart';
import 'package:event_planr/utils/media_query_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.screenBodyHeight;
    final l10 = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(l10.authLoginToYourAccount),
            backgroundColor: context.theme.colorScheme.primaryContainer,
            expandedHeight: 120,
            //elevation: 40,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
              ),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/icon/icon.png',
                      height: bodyHeight / 5,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: InputDecoration(
                        hintText: l10.authEmail,
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: l10.authFieldRequired('Email'),
                          ),
                          FormBuilderValidators.email(
                            errorText: l10.authEmailNotValid,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: InputDecoration(
                        hintText: l10.authPassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: l10.authFieldRequired('Password'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: context.theme.textTheme.titleMedium,
                        padding: const EdgeInsets.all(16),
                        backgroundColor: context.theme.colorScheme.primary,
                        foregroundColor:
                            context.theme.colorScheme.primaryContainer,
                      ),
                      child: Text(l10.authLogin),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: Text(l10.authForgotYourPassword),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l10.authDontHaveAnAccount,
                      style: TextStyle(
                        color: context.theme.colorScheme.tertiary,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(l10.authSignUp),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
