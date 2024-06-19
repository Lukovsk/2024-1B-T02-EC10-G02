import 'dart:convert';
import 'package:PharmaControl/models/order.dart';
import 'package:http/http.dart' as http;

var baseurl = "https://6662650962966e20ef086f8d.mockapi.io/api/v0/orders";

Future<List<Order>> getOrders() async {
  var response = await http.get(
    Uri.parse(baseurl),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data.map((d) => Order.fromJson(d)).toList();
  } else {
    return Order.getExamples();
  }
}

Future<Order?> fetchLastOrder() async {
  var response = await http.get(
    Uri.parse("$baseurl/orders/last_pending"),
    headers: <String, String>{'Content-Type': 'application/json;charset=utf-8'},
  );

  if (response.statusCode == 200) {
    final Order data = json.decode(response.body);

    return data;
  } else {
    return null;
  }
}
