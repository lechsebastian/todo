import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isCreatingAccount = false;

  void switchLogingMode() {
    setState(() {
      isCreatingAccount = !isCreatingAccount;
    });
  }

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );
    } catch (error) {
      print('Error has been occured: $error');
    }
  }

  void register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );
    } catch (error) {
      print('Error has been occured: $error');
    }
  }

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
              MyCommunication(
                text: isCreatingAccount
                    ? 'Hey, nice to see you here!'
                    : 'Hey, we missed you!',
              ),
              const SizedBox(height: 100),
              MyTextField(
                controller: widget.emailController,
                label: 'Email',
                isObscure: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: widget.passwordController,
                label: 'Password',
                isObscure: true,
              ),
              const SizedBox(height: 40),
              MyButton(
                text: isCreatingAccount ? 'Register' : 'Login',
                onTap: isCreatingAccount ? register : login,
              ),
              const SizedBox(height: 10),
              MyTextAndButton(
                onTap: switchLogingMode,
                text: isCreatingAccount
                    ? 'Already have an account? '
                    : 'Not a member? ',
                textToTap: isCreatingAccount ? 'Log in' : 'Register now',
              ),
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
    required this.onTap,
    required this.text,
    required this.textToTap,
  });

  final VoidCallback onTap;
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
            onTap: onTap,
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
    return Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 18));
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
    );
  }
}
