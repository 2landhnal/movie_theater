import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:movie_theater/utils/notify.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  static User? currentAccount;
  static Customer? currentCustomer;
  static LoginController instance = LoginController._();

  LoginController._();

  static LoginController getInstance() {
    instance ??= LoginController._();
    return instance;
  }

  Future<bool> login(
      BuildContext context, String username, String password) async {
    try {
      //FirebaseAuth.instance.setPersistence(Persistence.SESSION);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyNotifier.ShowToast("No user found for that email.");
        return false;
      } else if (e.code == 'wrong-password') {
        MyNotifier.ShowToast('Wrong password provided for that user.');
        return false;
      } else {
        MyNotifier.ShowToast(e.code);
        return false;
      }
    }
    User? currentUser = FirebaseAuth.instance.currentUser;
    // if (!currentUser!.emailVerified) {
    //   await FirebaseAuth.instance.signOut();
    //   MyNotifier.ShowToast('Email need to be verified!');
    //   return;
    // }
    Customer? cus = await APIService.getCustomerByAccount(currentUser!.uid);
    currentAccount = currentUser;
    currentCustomer = cus;
    notifyListeners();
    return true;
  }

  Future<void> logOutFunc(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    currentAccount = null;
    currentCustomer = null;
    Navigator.pop(context);
    notifyListeners();
    MyNotifier.ShowToast("Log out succeess!");
  }

  static Future checkState() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> initLoginCheck() async {
    await checkState();
  }
}
