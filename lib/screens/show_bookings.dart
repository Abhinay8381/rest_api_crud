import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_crud/api%20functions/crud_functions.dart';

class ShowBookingScreen extends StatefulWidget {
  const ShowBookingScreen({super.key});

  @override
  State<ShowBookingScreen> createState() => _ShowBookingScreenState();
}

class _ShowBookingScreenState extends State<ShowBookingScreen> {
  @override
  void initState() {
    super.initState();
    test();
  }

  test() async {
    var response =
        await CrudFunctions().getBookingfromID("/booking").catchError((e) {
      print(e.toString());
    });
    if (response != null) {
      debugPrint(((jsonDecode(response))[2]['bookingid']).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(child: Text("show book Screen")),
    );
  }
}
