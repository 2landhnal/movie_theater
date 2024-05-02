// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class TestFirebase extends StatefulWidget {
//   const TestFirebase({super.key});

//   @override
//   State<TestFirebase> createState() => _TestFirebaseState();
// }

// class _TestFirebaseState extends State<TestFirebase> {
//   FirebaseDatabase dbInstance = FirebaseDatabase.instance;

//   bool loading = false;

//   void _onPress() async {
//     setState(() {
//       loading = true;
//     });
//     await dbInstance.ref("roles/3").set({
//       "name": "User",
//     }).then((_) {
//       print("Set success");
//     }).catchError((onError) {
//       print(onError);
//     });
//     setState(() {
//       loading = false;
//     });
//   }

//   void _signUp() async {
//     var email = "nguyenhbyg9@gmail.com";
//     var password = "19012003@";
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _checkState() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }

//   void _signIn() async {
//     var email = "nguyenhbyg9@gmail.com";
//     var password = "19012003@";
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Container(
//         decoration: const BoxDecoration(color: Colors.black),
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text("Testing"),
//             const Text("Testing"),
//             TextButton(
//               onPressed: _onPress,
//               child: const Text(
//                 "Click",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             TextButton(
//               onPressed: _signUp,
//               child: const Text(
//                 "SignUp",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             TextButton(
//               onPressed: _signIn,
//               child: const Text(
//                 "SignIn",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             TextButton(
//               onPressed: _signIn,
//               child: const Text(
//                 "Check State",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Visibility(
//         visible: loading,
//         child: const Center(
//             child: CircularProgressIndicator(backgroundColor: Colors.white38)),
//       ),
//     ]);
//   }
// }
