import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud/screens/home_screen.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../api functions/crud_functions.dart';
import '../models/booking_model.dart';
import '../provider/internet_provider.dart';
import '../utils/utils.dart';

class UpdateBookingScreen extends StatefulWidget {
  String bookingId;
  DateTime checkInDate;
  DateTime checkOutDate;
  String roomType;
  int amount;
  UpdateBookingScreen(
      {super.key,
      required this.bookingId,
      required this.checkInDate,
      required this.checkOutDate,
      required this.amount,
      required this.roomType});

  @override
  State<UpdateBookingScreen> createState() => _UpdateBookingScreenState();
}

class _UpdateBookingScreenState extends State<UpdateBookingScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController updateBookingController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Update Your Booking',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: mobileBackgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 211, 210, 210),
                      width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/rooms.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  " Hotel Bundelkhand Pride",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                      radius: 10,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "4 stars rated  |",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 115, 114, 114)),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "Fully air Conditioned",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 115, 114, 114)),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Karol Bagh, Delhi",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 115, 114, 114)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () async {
                    await _selectCheckInDate(context);
                    setState(() {
                      widget.checkOutDate =
                          widget.checkInDate.add(const Duration(days: 1));
                      if (widget.checkOutDate
                              .difference(widget.checkInDate)
                              .inDays <
                          0) {
                        widget.amount = 0;
                        showSnackBar(
                            context,
                            "Check Out Date Should Be Greater Then Check in Date",
                            Colors.red);
                      } else {
                        if (widget.roomType == "AC") {
                          widget.amount = widget.checkOutDate
                                  .difference(widget.checkInDate)
                                  .inDays *
                              1299;
                        } else {
                          widget.amount = widget.checkOutDate
                                  .difference(widget.checkInDate)
                                  .inDays *
                              799;
                        }
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 235, 235),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor, width: 2)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: DateFormat.yMMMd()
                                    .format(widget.checkInDate),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              const TextSpan(
                                text: " (Check in)",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            ])),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 6, 2),
                            child: Icon(Icons.calendar_month)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () async {
                    await _selectCheckOutDate(context);
                    if (widget.checkOutDate
                            .difference(widget.checkInDate)
                            .inDays <
                        0) {
                      widget.amount = 0;
                      // ignore: use_build_context_synchronously
                      showSnackBar(
                          context,
                          "Check Out Date Should Be Greater Then Check in Date",
                          Colors.red);
                    } else {
                      if (widget.roomType == "AC") {
                        widget.amount = widget.checkOutDate
                                .difference(widget.checkInDate)
                                .inDays *
                            1299;
                      } else {
                        widget.amount = widget.checkOutDate
                                .difference(widget.checkInDate)
                                .inDays *
                            799;
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 235, 235),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor, width: 2)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: DateFormat.yMMMd()
                                    .format(widget.checkOutDate),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              const TextSpan(
                                text: " (Check out)",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            ])),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 6, 2),
                            child: Icon(Icons.calendar_month)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 235, 235),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primaryColor, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: RadioListTile(
                          activeColor: Colors.black,
                          title: const Text(
                            'AC',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: 'AC',
                          groupValue: widget.roomType,
                          onChanged: (value) {
                            setState(() {
                              widget.roomType = value.toString();
                              if (widget.roomType == "AC") {
                                widget.amount = widget.checkOutDate
                                        .difference(widget.checkInDate)
                                        .inDays *
                                    1299;
                              } else {
                                widget.amount = widget.checkOutDate
                                        .difference(widget.checkInDate)
                                        .inDays *
                                    799;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: RadioListTile(
                          activeColor: Colors.black,
                          title: const Text(
                            'Non AC',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: 'Non AC',
                          groupValue: widget.roomType,
                          onChanged: (value) {
                            setState(() {
                              widget.roomType = value.toString();
                              if (widget.roomType == "AC") {
                                widget.amount = widget.checkOutDate
                                        .difference(widget.checkInDate)
                                        .inDays *
                                    1299;
                              } else {
                                widget.amount = widget.checkOutDate
                                        .difference(widget.checkInDate)
                                        .inDays *
                                    799;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedLoadingButton(
                onPressed: () {
                  updateBooking();
                },
                controller: updateBookingController,
                successColor: Colors.black,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                borderRadius: 25,
                color: primaryColor,
                child: Wrap(
                  children: [
                    const Text("Edit your booking",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("(₹ ${widget.amount})",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        widget.checkInDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        widget.checkOutDate = picked;
      });
    }
  }

  updateBooking() async {
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Check your Internet connection", Colors.red);
      updateBookingController.reset();
    } else {
      if (widget.checkOutDate.difference(widget.checkInDate).inDays < 0) {
        widget.amount = 0;

        // ignore: use_build_context_synchronously
        showSnackBar(context,
            "Check Out Date Should Be Greater Then Check in Date", Colors.red);
      } else {
        BookingModel bookingModel = BookingModel(
            isAC: widget.roomType == "AC",
            checkin: widget.checkInDate.toIso8601String(),
            checkout: widget.checkOutDate.toIso8601String());
        debugPrint(widget.checkOutDate.toIso8601String());
        CrudFunctions()
            .updateBooking(widget.bookingId, bookingModel)
            .then((value) async {
          if (value == "Something went wrong") {
            showSnackBar(context, value, Colors.red);
            updateBookingController.reset();
          } else {
            showSnackBar(context, "Booking updated successfully", Colors.green);
            updateBookingController.success();
            nextScreenReplacement(context, const HomeScreen());
          }
        });
      }
    }
  }
}
