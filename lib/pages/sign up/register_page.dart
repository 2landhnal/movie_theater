import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/my_app.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/sign%20up/register_ctrl.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:movie_theater/utils/notify.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => signupPageState();
}

class signupPageState extends State<RegisterPage> {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  bool datePicked = false;
  static List<String> genderList = <String>['Male', 'Female', 'Other'];
  String _dropDownValue = "Male";
  TextEditingController passwordTxtCtrl = TextEditingController(),
      nameTxtCtrl = TextEditingController(),
      emailTxtCtrl = TextEditingController();

  // void sendVerify() {
  //   if (passwordTxtCtrl.text == "" ||
  //       nameTxtCtrl.text == "" ||
  //       emailTxtCtrl.text == "") {
  //     MyNotifier.ShowToast("Please fill the required field!");
  //     return;
  //   }
  //   FirebaseAuth.instance
  //       .sendSignInLinkToEmail(
  //           email: emailTxtCtrl.text, actionCodeSettings: VerifyConfig.acs)
  //       .catchError(
  //           (onError) => print('Error sending email verification $onError'))
  //       .then((value) => print('Successfully sent email verification'));
  // }

  void signup() async {
    UserCredential userCredential;
    print("Sign UPPPPPPPPPP");
    if (passwordTxtCtrl.text == "" ||
        nameTxtCtrl.text == "" ||
        emailTxtCtrl.text == "") {
      MyNotifier.ShowToast("Please fill the required field!");
      return;
    }
    if (await RegisterController.register(
      emailTxtCtrl.text,
      passwordTxtCtrl.text,
      nameTxtCtrl.text,
      selectedDate,
      _dropDownValue,
    )) {
    } else {
      return;
    }
    GlobalUtils.navToLogin(context);
    MyNotifier.ShowToast("Register success!");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        datePicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MyHelper.getRandomString(8));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Row(
          children: [
            AppBarBackButton(),
            Text(
              "Register",
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
                  scrollDirection: Axis.vertical,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //UsernameField(ctrl: usernameTxtCtrl),
                        //const SizedBox(height: 10),
                        EmailField(ctrl: emailTxtCtrl),
                        const SizedBox(height: 10),
                        PasswordField(ctrl: passwordTxtCtrl),
                        const SizedBox(height: 10),
                        NameField(ctrl: nameTxtCtrl),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 2.4,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: TextEditingController(
                                    text: datePicked
                                        ? formatter.format(selectedDate)
                                        : "Birthday"),
                                onTap: () => _selectDate(context),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(),
                                  labelText: "Birthday",
                                  labelStyle: TextStyle(color: Colors.white),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white38,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 63,
                                color: Colors.transparent,
                                child: InputDecorator(
                                  decoration: GlobalUtils.inputDecorationBlack(
                                      labelText: "Gender"),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        dropdownColor: Colors.black,
                                        hint: _dropDownValue == ""
                                            ? const Text(
                                                'Dropdown',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                _dropDownValue,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                        items: genderList.map((String e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            _dropDownValue = val!;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SignUpButton(onClick: signup),
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

class EmailField extends StatelessWidget {
  EmailField({
    super.key,
    required this.ctrl,
  });

  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        validator: MyHelper.validateEmail,
        decoration: GlobalUtils.inputDecorationBlack(labelText: "Email"),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({
    super.key,
    required this.ctrl,
  });

  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: MyHelper.passwordValidator,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: GlobalUtils.inputDecorationBlack(labelText: "Password"));
  }
}

class NameField extends StatelessWidget {
  NameField({
    super.key,
    required this.ctrl,
  });

  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: MyHelper.validateNull,
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: GlobalUtils.inputDecorationBlack(labelText: "Fullname"));
  }
}

class UsernameField extends StatelessWidget {
  UsernameField({super.key, required this.ctrl});

  TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: MyHelper.validateNull,
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: GlobalUtils.inputDecorationBlack(labelText: "Username"),
    );
  }
}

class SignUpButton extends StatefulWidget {
  SignUpButton({super.key, required this.onClick});

  Function onClick;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
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
          await widget.onClick();
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
            : const Text("Register"),
      ),
    );
  }
}
