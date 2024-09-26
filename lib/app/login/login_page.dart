import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.assignment, size: 180),
              const SizedBox(height: 20),
              const MyCommunication(text: 'Hey, we missed you!'),
              const SizedBox(height: 100),
              MyTextField(
                controller: emailController,
                label: 'Email',
                isObscure: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: passwordController,
                label: 'Password',
                isObscure: true,
              ),
              const SizedBox(height: 40),
              MyButton(
                emailController: emailController.text,
                passwordController: passwordController.text,
                text: 'Login',
              ),
              const SizedBox(height: 10),
              const MyTextAndButton(
                  text: 'Not a member? ', textToTap: 'Register now'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextAndButton extends StatelessWidget {
  const MyTextAndButton({
    super.key,
    required this.text,
    required this.textToTap,
  });

  final String text;
  final String textToTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey[700]),
        ),
        InkWell(
            onTap: () {},
            child: Text(
              textToTap,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class MyCommunication extends StatelessWidget {
  const MyCommunication({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text('Hey, we missed you!',
        style: TextStyle(color: Colors.grey[700], fontSize: 18));
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.emailController,
    required this.passwordController,
  });

  final String text;
  final String emailController;
  final String passwordController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController,
            password: passwordController,
          );
        } catch (error) {
          print('Error has been occured: ${error}');
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.isObscure,
  });

  final TextEditingController controller;
  final String label;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
    );
  }
}
