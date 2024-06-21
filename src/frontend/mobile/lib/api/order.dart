import 'dart:convert';
import 'package:PharmaControl/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:PharmaControl/globals.dart' as globals;

import '../models/pyxis.dart';

var baseurl = globals.baseurl;
var pubUrl = globals.publisherUrl;

Future<List<Order>?> getOrders() async {
  String userUrl = globals.user!.role == "NURSE"
      ? "sender/${globals.user!.id}"
      : "receiver/${globals.user!.id}";

  var response = await http.get(
    Uri.parse("$baseurl/orders/$userUrl"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    return data.map((d) => Order.fromJson(d)).toList();
  } else {
    return null;
  }
}

Future<List<Pyxis>?> getPyxis() async {
  var response = await http.get(
    Uri.parse("$baseurl/pyxis/"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes))["pyxis"];

    return data.map((d) => Pyxis.fromJsonWithItems(d)).toList();
  } else {
    return null;
  }
}

Future<Order?> fetchLastOrder() async {
  var response = await http.get(
    Uri.parse("$baseurl/orders/last_pending"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));

    return Order.fromJson(data);
  } else {
    return null;
  }
}

Future<bool> createOrder(String userId, String pyxiId, String problem,
    String? description, String? itemId) async {
  final Map<String, String?> data = {
    "sender_userId": userId,
    "pyxiId": pyxiId,
    "problem": problem,
    "description": description,
    "itemId": itemId,
  };

  var response = await http.post(
    Uri.parse("$pubUrl/order/"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
    body: jsonEncode(data),
  );

  return (response.statusCode == 200);
}

Future<bool> acceptOrder(String userId, String orderId) async {
  final Map<String, String> data = {
    "receiver_userId": userId,
    "order_id": orderId,
  };

  var response = await http.post(
    Uri.parse("$pubUrl/order/accept"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
    body: jsonEncode(data),
  );

  return (response.statusCode == 200);
}

Future<bool> doneOrder(String orderId) async {
  final Map<String, String> data = {
    "order_id": orderId,
  };

  var response = await http.post(
    Uri.parse("$pubUrl/order/done"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
    body: jsonEncode(data),
  );

  return (response.statusCode == 200);
}

Future<bool> cancelOrder(String orderId, String reason, String userId) async {
  final Map<String, String> data = {
    "order_id": orderId,
    "canceled_reason": reason,
    "canceled_userId": userId,
  };

  var response = await http.post(
    Uri.parse("$pubUrl/order/cancel"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
    body: jsonEncode(data),
  );

  return (response.statusCode == 200);
}

Future<bool> rejectOrder(String orderId) async {
  final Map<String, String> data = {
    "order_id": orderId,
  };

  var response = await http.post(
    Uri.parse("$pubUrl/order/reject"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
    body: jsonEncode(data),
  );

  return (response.statusCode == 200);
}
