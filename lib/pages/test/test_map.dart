class Account {
  String username;
  String password;
  int role_id;
  Account({
    required this.username,
    required this.password,
    required this.role_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'role_id': role_id,
    };
  }

  factory Account.fromMap(Map<dynamic, dynamic> map) {
    return Account(
      username: map['username'] as String,
      password: map['password'] as String,
      role_id: map['role_id'] as int,
    );
  }
}

void main() {
  var obj = {"username": "cao", "password": "190103", "role_id": 1};
  Account acc = Account.fromMap(obj);
  print(acc.username);
}
