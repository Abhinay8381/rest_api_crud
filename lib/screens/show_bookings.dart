import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_crud/api%20functions/crud_functions.dart';
import 'package:rest_api_crud/api%20functions/firestore_functions.dart';
import 'package:rest_api_crud/models/booking_model.dart';
import 'package:rest_api_crud/utils/utils.dart';
import 'package:rest_api_crud/widgets.dart/booking_widget.dart';

class ShowBookingScreen extends StatefulWidget {
  const ShowBookingScreen({super.key});

  @override
  State<ShowBookingScreen> createState() => _ShowBookingScreenState();
}

class _ShowBookingScreenState extends State<ShowBookingScreen> {
  List<dynamic> bookingIDs = [];
  String name = "", email = "", photoUrl = "";
  getbookingIDsFromFirestore() async {
    Firestorefunctions().getIDs().then((value) {
      setState(() {
        bookingIDs = value['BookingIDs'];
        name = value['name'];
        email = value['email'];
        photoUrl = value['image_url'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getbookingIDsFromFirestore();
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
      body: bookingIDs.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : FutureBuilder(
              future: getAllBookings(bookingIDs, context),
              builder: ((context, AsyncSnapshot<List<BookingModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return BookingWidget(
                            checkInTime: snapshot.data![index].checkin,
                            checkOutTime: snapshot.data![index].checkout,
                            bookingId: snapshot.data![index].bookingId!,
                            userName: name,
                            email: email,
                            isAC: snapshot.data![index].isAC,
                            bookingTime: snapshot.data![index].bookingTime!,
                            onUpdate: () {},
                            onCancel: () {});
                      });
                } else if (snapshot.hasError) {
                  showSnackBar(context, snapshot.error, Colors.red);
                  return Container();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }
              })),
    );
  }

  // function to get the data for all the booking ids in the list
  Future<List<BookingModel>> getAllBookings(
      List<dynamic> ids, BuildContext context) async {
    List<BookingModel> bookings = [];
    for (int i = 0; i < ids.length; i++) {
      var value = await CrudFunctions().getBookingfromID(ids[i]);
      if (value == "Something went wrong") {
        // ignore: use_build_context_synchronously
        showSnackBar(context, value, Colors.red);
      } else {
        BookingModel book = BookingModel.fromJson(jsonDecode(value));

        bookings.add(book);
      }
    }

    return bookings;
  }
}
