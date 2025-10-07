import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_bloc.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_event.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_state.dart';
import 'package:networkx/src/presentation/features/posts/screens/post_screen.dart';
import 'package:networkx/src/presentation/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle the login button press
  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      context.read<LoginBloc>().add(
        LoginRequested(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login'), centerTitle: true),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32.0),

              BlocConsumer<LoginBloc, LoginState>(
                builder: (context, state) {
                  final loginButton = ElevatedButton(
                    onPressed: _submitLogin,
                    child: const Text('LOG IN', style: TextStyle(fontSize: 18)),
                  );

                  if (state is LoginRequestLoading) {
                    return const LoadingIndicator();
                  }

                  if (state is LoginRequestRejected) {
                    return Column(
                      children: [
                        Center(
                          child: Text(
                            'Error: ${state.errorMessage}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        loginButton,
                      ],
                    );
                  }
                  return loginButton;
                },
                listener: (context, state) {
                  if (state is LoginRequestApproved) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
