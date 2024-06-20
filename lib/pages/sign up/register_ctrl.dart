import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/utils/notify.dart';

class RegisterController {
  static Future<bool> register(
    String email,
    String pass,
    String name,
    DateTime birthday,
    String gender,
  ) async {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    UserCredential userCredential;
    print("Sign UPPPPPPPPPP");
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        MyNotifier.ShowToast("The password provided is too weak!");
        return false;
      } else if (e.code == 'email-already-in-use') {
        MyNotifier.ShowToast("Username already exist!");
        return false;
      } else {
        MyNotifier.ShowToast(e.code);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
    String salt = MyHelper.getSalt();
    Account account = Account(
        uid: userCredential.user!.uid,
        username: email,
        password: MyHelper.hash(pass + salt),
        role_id: 3,
        salt: salt);
    Customer customer = Customer(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
      birthday: formatter.format(birthday).toString(),
      gender: gender,
      join_at: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    await APIService.pushToFireBase(
        "accounts/${account.uid}/", account.toMap());
    await APIService.pushToFireBase(
        "customers/${customer.uid}/", customer.toMap());
    return true;
  }
}
