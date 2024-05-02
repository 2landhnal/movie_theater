import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/utils/asset.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              const SizedBox(width: 20),
              const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.black),
        child: const Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UsernameField(),
                      SizedBox(height: 10),
                      PasswordField(),
                      SizedBox(height: 10),
                      SignInButton(),
                      SignUpButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: GlobalUtils.inputDecorationBlack(labelText: "Password"),
    );
  }
}

class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: GlobalUtils.inputDecorationBlack(labelText: "Username"));
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white, // your color here
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0))),
        ),
        child: const Text("Sign in"),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          GlobalUtils.signUpFunc(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white, // your color here
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0))),
        ),
        child: const Text("Sign up"),
      ),
    );
  }
}
