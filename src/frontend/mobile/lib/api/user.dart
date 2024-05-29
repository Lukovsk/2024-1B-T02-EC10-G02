import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:PharmaControl/globals.dart' as globals;

var baseurl = globals.baseurl;

Future<Map> login(String email, String password) async {
  final Map<String, String> data = {
    "email": email,
    "password": password,
  };

  var response = await http.post(
    Uri.parse("$baseurl/user/login"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    return body["user"];
  } else {
    return {
      "user": false,
    };
  }
}
