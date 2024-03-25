import 'package:flutter/material.dart';

class LoginLoading extends StatelessWidget {
  const LoginLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // ローディング表示
      ),
    );
  }
}
