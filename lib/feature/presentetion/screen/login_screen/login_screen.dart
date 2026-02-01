import 'package:bloclearnbyproject/feature/presentetion/auth/auth_block/auth_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/auth/auth_block/auth_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/auth/auth_block/auth_state.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/post_list_screen/post_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Auto login check
    context.read<AuthBloc>().add(CheckLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts Pagination"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(

        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PostListScreen4()),
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          // FULL SCREEN LOADING
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // EMAIL FIELD
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD FIELD
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            LoginButtonPressed(
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
