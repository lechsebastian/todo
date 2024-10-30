import 'package:flutter/material.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/widgets/my_button.dart';
import 'package:todo/app/features/widgets/my_communication.dart';
import 'package:todo/app/features/widgets/my_text_and_button.dart';
import 'package:todo/app/features/widgets/my_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<RootCubit>().signIn(
          email: widget.emailController.text,
          password: widget.passwordController.text,
        );
  }

  void register() async {
    context.read<RootCubit>().register(
          email: widget.emailController.text,
          password: widget.passwordController.text,
        );
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
              const SizedBox(height: 90),
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
