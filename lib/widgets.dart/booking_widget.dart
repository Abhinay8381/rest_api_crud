import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api functions/crud_functions.dart';
import '../api functions/firestore_functions.dart';
import '../screens/home_screen.dart';
import '../utils/utils.dart';

class BookingWidget extends StatefulWidget {
  final bool isAC;
  final String bookingId;
  final String userName;
  final String email;
  final String checkInTime;
  final String checkOutTime;
  final String bookingTime;
  final VoidCallback onUpdate;

  const BookingWidget({
    super.key,
    required this.bookingTime,
    required this.isAC,
    required this.checkInTime,
    required this.checkOutTime,
    required this.bookingId,
    required this.userName,
    required this.email,
    required this.onUpdate,
  });

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 211, 210, 210), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 211, 210, 210), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: const Image(
                              image: AssetImage("assets/logo.png"),
                            ),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          const Text(
                            'Hotel Bundelkhand Pride',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "Booking Time: ${dateTimeFormatter(widget.bookingTime)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 102, 101, 101),
                                fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      'Hi ${widget.userName} , Your booking is confirmed',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Booking ID: ${widget.bookingId}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Email: ${widget.email}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          child: Icon(
                            Icons.check_circle,
                            size: 60,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Check-in Time: ${dateConverter(widget.checkInTime)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Check-out Time: ${dateConverter(widget.checkOutTime)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Amount due: ₹ ${amountDueCalculator(widget.isAC, DateTime.parse(widget.checkInTime), DateTime.parse(widget.checkOutTime))}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: widget.onUpdate,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text('Update Booking'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          deleteBookting();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text('Cancel Booking'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
  }

  //converting date to desired format
  String dateConverter(String dateInISO8601) {
    DateTime dateTime = DateTime.parse(dateInISO8601);
    return DateFormat.yMMMd().format(dateTime);
  }

// calculating amount based on room type check in and check out
  int amountDueCalculator(bool isAC, DateTime checkin, DateTime checkout) {
    if (isAC) {
      return ((checkout.difference(checkin)).inDays) * 1299;
    } else {
      return ((checkout.difference(checkin)).inDays) * 799;
    }
  }

  //converting date to desired format
  String dateTimeFormatter(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM d, y h:mm a').format(dateTime);
  }

// deleting booking from booking id
  deleteBookting() async {
    setState(() {
      _isLoading = true;
    });
    var value = await CrudFunctions().deleteBooking(widget.bookingId);
    if (value == "Something went wrong") {
      // ignore: use_build_context_synchronously
      showSnackBar(context, value, Colors.red);
      setState(() {
        _isLoading = false;
      });
    } else {
      //deleting booking id from user document
      await Firestorefunctions().deleteIDs(widget.bookingId);
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Booking deleted successfully", Colors.green);
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const HomeScreen()),
          (route) => false);
    }
  }
}
