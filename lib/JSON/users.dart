import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  //final int? usrId;
  final String email;
  final String? usrName;
  final String password;

  Users({
    //this.usrId,
    required this.email,
    this.usrName,
    required this.password,
  });

  //These json value must be same as your column name in database that we have already defined
  //one column didn't match
  factory Users.fromMap(Map<String, dynamic> json) => Users(
        //usrId: json["usrId"],
        email: json["email"],
        usrName: json["usrName"],
        password: json["usrPassword"],
      );

  Map<String, dynamic> toMap() => {
        //"usrId": usrId,
        "email": email,
        "usrName": usrName,
        "usrPassword": password,
      };
}
