import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingWidget extends StatelessWidget {
  final bool isAC;
  final String bookingId;
  final String userName;
  final String email;
  final String checkInTime;
  final String checkOutTime;
  final String bookingTime;
  final VoidCallback onUpdate;
  final VoidCallback onCancel;

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
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Booking Time: ${dateTimeFormatter(bookingTime)}",
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
                'Hi $userName , Your booking is confirmed',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                'Booking ID: $bookingId',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                'Email: $email',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        'Check-in Time: ${dateConverter(checkInTime)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Check-out Time: ${dateConverter(checkOutTime)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Amount due: ₹ ${amountDueCalculator(isAC, DateTime.parse(checkInTime), DateTime.parse(checkOutTime))}',
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
                  onPressed: () => onUpdate,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Update Booking'),
                ),
                ElevatedButton(
                  onPressed: () => onCancel,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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

  String dateConverter(String dateInISO8601) {
    DateTime dateTime = DateTime.parse(dateInISO8601);
    return DateFormat.yMMMd().format(dateTime);
  }

  int amountDueCalculator(bool isAC, DateTime checkin, DateTime checkout) {
    if (isAC) {
      return ((checkout.difference(checkin)).inDays) * 1299;
    } else {
      return ((checkout.difference(checkin)).inDays) * 799;
    }
  }

  String dateTimeFormatter(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM d, y h:mm a').format(dateTime);
  }
}
