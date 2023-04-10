import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

// Define AWS Cognito user pool configuration
final userPool = CognitoUserPool(
  'us-east-1_pboY2gkEV', // User Pool ID
  '4pbsqnbhdmoctqb58ev1etvlem', // Client ID
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  // Function to handle user login
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final user = CognitoUser(username, userPool);

    try {
      final authDetails = AuthenticationDetails(
        username: username,
        password: password,
      );
      // ignore: unused_local_variable
      final session = await user.authenticateUser(authDetails);
      // Navigate to home screen on successful login
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, '/main');
    } on CognitoUserNewPasswordRequiredException catch (e) {
      final attributes = { 'name': 'test@email.hu'};
      await user.sendNewPasswordRequiredAnswer('Test.54321', attributes);
    } on CognitoUserMfaRequiredException catch (e) {
      // Handle MFA required exception
      //Navigator.pushNamed(context, '/mfa', arguments: user);
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // Handle confirmation necessary exception
      //Navigator.pushNamed(context, '/confirm', arguments: user);
    } on CognitoUserException catch (e) {
      // Handle other Cognito exceptions
      setState(() {
        _errorMessage = e.message!;
      });
    } catch (e) {
      // Handle other exceptions
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _login();
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
