import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/my_app.dart';
import 'package:movie_theater/utils/asset.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => signupPageState();
}

class signupPageState extends State<SignUpPage> {
  DateTime selectedDate = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  bool datePicked = false;
  static List<String> genderList = <String>['Male', 'Female', 'Other'];
  String _dropDownValue = "";
  TextEditingController usernameTxtCtrl = TextEditingController(),
      passwordTxtCtrl = TextEditingController(),
      nameTxtCtrl = TextEditingController(),
      emailTxtCtrl = TextEditingController();

  void signup() async {
    print("Sign UPPPPPPPPPP");
    setState(() {
      MainApp.loading = true;
    });
    await GlobalUtils.dbInstance.ref("users/${usernameTxtCtrl.text}/").set({
      "username": usernameTxtCtrl.text,
      "name": nameTxtCtrl.text,
      "password": passwordTxtCtrl.text,
      "email": emailTxtCtrl.text,
      "birthday": formatter.format(selectedDate).toString(),
      "gender": _dropDownValue,
      "role_id": 3,
    }).then((_) {
      print("Set success");
    }).catchError((onError) {
      print(onError);
    });
    setState(() {
      MainApp.loading = false;
    });
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
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UsernameField(ctrl: usernameTxtCtrl),
                      const SizedBox(height: 10),
                      PasswordField(ctrl: passwordTxtCtrl),
                      const SizedBox(height: 10),
                      NameField(ctrl: nameTxtCtrl),
                      const SizedBox(height: 10),
                      EmailField(ctrl: emailTxtCtrl),
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
                              validator: MyHelper.validateEmail,
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
    return TextField(
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
    return TextField(
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
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: GlobalUtils.inputDecorationBlack(labelText: "Username"),
    );
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton({super.key, required this.onClick});

  Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          onClick();
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
