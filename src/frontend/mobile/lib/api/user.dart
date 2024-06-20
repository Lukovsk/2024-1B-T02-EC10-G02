import 'dart:convert';
import 'dart:developer';

import 'package:PharmaControl/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:PharmaControl/globals.dart' as globals;

var baseurl = globals.baseurl;

Future<Map> login(String email, String password) async {
  try {
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
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      User user = User.fromJson(body["user"]);
      globals.user = user;
      log(globals.user?.name ?? "");
      return body["user"];
    } else {
      return {
        "user": false,
      };
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return {
      "user": false,
    };
  }
}

Future<bool> changeDisponibilty(String id) async {
  var response = await http.put(
    Uri.parse("$baseurl/user/status/$id"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
  );

  if (response.statusCode == 200) {
    bool disponibility = globals.user!.disponibility!;
    globals.user!.disponibility = !disponibility;
    return true;
  } else {
    return false;
  }
}
