import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController usernameTxtCtrl = TextEditingController(),
      passwordTxtCtrl = TextEditingController();

  void login(BuildContext context) async {
    print("Login In clicked!");
    var result = await APIService.getUserByAccount(usernameTxtCtrl.text);
    print("result == null: ${result == null}");
    if (result == null) return;
    GlobalUtils.sharedPrefs.setString("username", result.username);
    context.read<GlobalUtils>().loginAccount(result);
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(GlobalUtils.createSnackBar(context, "Success!!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const AppBarBackButton(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
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
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: ctrl,
      decoration: context
          .read<GlobalUtils>()
          .inputDecorationBlack(labelText: "Password"),
    );
  }
}

class UsernameField extends StatelessWidget {
  UsernameField({super.key, required this.ctrl});
  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: const TextStyle(color: Colors.white),
        controller: ctrl,
        decoration: context
            .read<GlobalUtils>()
            .inputDecorationBlack(labelText: "Username"));
  }
}

class SignInButton extends StatelessWidget {
  SignInButton({super.key, required this.onClick});

  Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => onClick(context),
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
        child: const Text("Log in"),
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
          Navigator.pop(context);
          context.read<GlobalUtils>().signUpFunc(context);
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
