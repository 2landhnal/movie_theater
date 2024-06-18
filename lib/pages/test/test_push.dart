import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/utils/asset.dart';

class TestPush extends StatelessWidget {
  const TestPush({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            Obj newObj = Obj(id: 0, content: "test");
            await FirebaseDatabase.instance
                .ref("test/${newObj.id}/")
                .set(newObj.toMap())
                .then((_) {
              print("Set success");
            }).catchError((onError) {
              print(onError);
            });
          },
          child: const Text("Push"),
        ),
      ),
    );
  }
}

class Obj {
  int id;
  String content;
  Obj({
    required this.id,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
    };
  }

  factory Obj.fromMap(Map<dynamic, dynamic> map) {
    return Obj(
      id: map['id'] as int,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Obj.fromJson(String source) =>
      Obj.fromMap(json.decode(source) as Map<String, dynamic>);
}
