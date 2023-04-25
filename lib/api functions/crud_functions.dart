import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = "https://api.nstack.in/v1/todos";

class CrudFunctions {
  var client = http.Client();

  //to get all the booking ids booked from you(get)
  Future<dynamic> getBookingfromID(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  // to create a new booking(post)
  Future<dynamic> createBooking(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.post(
      url,
      body: jsonEncode(object),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return "Something went wrong";
    }
  }
}
