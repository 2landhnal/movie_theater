import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/login/login_ctrl.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:movie_theater/utils/notify.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController usernameTxtCtrl = TextEditingController(),
      passwordTxtCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login(BuildContext context) async {
    print("Login In clicked!");
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (await LoginController.getInstance()
        .login(context, usernameTxtCtrl.text, passwordTxtCtrl.text)) {
    } else {
      return;
    }
    Navigator.pop(context);
    MyNotifier.ShowToast("Login success!!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Row(
          children: [
            AppBarBackButton(),
            Text(
              "Log in",
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UsernameField(ctrl: usernameTxtCtrl),
                        const SizedBox(height: 10),
                        PasswordField(ctrl: passwordTxtCtrl),
                        const SizedBox(height: 10),
                        SignInButton(
                          onClick: login,
                        ),
                        const SignUpButton(),
                      ],
                    ),
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
  PasswordField({super.key, required this.ctrl});
  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: MyHelper.validateNull,
      style: const TextStyle(color: Colors.white),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: ctrl,
      decoration: GlobalUtils.inputDecorationBlack(labelText: "Password"),
    );
  }
}

class UsernameField extends StatelessWidget {
  UsernameField({super.key, required this.ctrl});
  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: MyHelper.validateEmail,
        style: const TextStyle(color: Colors.white),
        controller: ctrl,
        decoration: GlobalUtils.inputDecorationBlack(labelText: "Email"));
  }
}

class SignInButton extends StatefulWidget {
  SignInButton({
    super.key,
    required this.onClick,
  });

  Function onClick;

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await widget.onClick(context);
          setState(() {
            loading = false;
          });
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
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : const Text("Log in"),
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
          GlobalUtils.navToSignUpPage(context);
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
        child: const Text("Register"),
      ),
    );
  }
}
