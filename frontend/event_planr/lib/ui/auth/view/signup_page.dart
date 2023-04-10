import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(l10.authCreateYourAccount),
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
                    FormBuilderTextField(
                      name: 'fullName',
                      decoration: InputDecoration(
                        hintText: l10.authFullName,
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                      ),
                      keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: l10.authFieldRequired(l10.authFullName),
                          ),
                          FormBuilderValidators.maxLength(
                            128,
                            errorText:
                                l10.authFieldMaxLength(l10.authFullName, 128),
                          ),
                        ],
                      ),
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
                            errorText: l10.authFieldRequired(l10.authEmail),
                          ),
                          FormBuilderValidators.email(
                            errorText: l10.authEmailNotValid,
                          ),
                          FormBuilderValidators.maxLength(
                            128,
                            errorText:
                                l10.authFieldMaxLength(l10.authEmail, 128),
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
                            errorText: l10.authFieldRequired(l10.authPassword),
                          ),
                          FormBuilderValidators.minLength(
                            8,
                            errorText:
                                l10.authFieldMinLength(l10.authPassword, 8),
                          ),
                          FormBuilderValidators.maxLength(
                            128,
                            errorText:
                                l10.authFieldMaxLength(l10.authPassword, 128),
                          ),
                          (password) {
                            if (password == null) {
                              return null;
                            } else if (!password.contains(RegExp('[A-Z]'))) {
                              return l10.authPasswordMustContainCapital;
                            } else if (!password.contains(RegExp('[0-9]'))) {
                              return l10.authPasswordMustContainNumber;
                            }
                            return null;
                          }
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'confirmPassword',
                      decoration: InputDecoration(
                        hintText: l10.authConfirmPassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: FormBuilderValidators.compose(
                        [
                          (confirmPassword) {
                            if (confirmPassword !=
                                _formKey
                                    .currentState?.fields['password']?.value) {
                              return l10.authPasswordsDoNotMatch;
                            }
                            return null;
                          }
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: context.theme.textTheme.titleMedium,
                        padding: const EdgeInsets.all(16),
                        backgroundColor: context.theme.colorScheme.primary,
                        foregroundColor:
                            context.theme.colorScheme.primaryContainer,
                      ),
                      child: Text(l10.authSignUp),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l10.authAlreadyHaveAnAccount,
                      style: TextStyle(
                        color: context.theme.colorScheme.tertiary,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(l10.authLogin),
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
