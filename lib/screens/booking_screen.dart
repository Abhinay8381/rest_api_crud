import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rest_api_crud/utils/utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));
  int amount = 799;
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Welcome',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: mobileBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ],
          ),
        ),
        body: SafeArea(
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
                  " Hotel Restful Booker",
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () async {
                    await _selectCheckInDate(context);
                    setState(() {
                      checkOutDate = checkInDate.add(const Duration(days: 1));
                      if (checkOutDate.difference(checkInDate).inDays < 0) {
                        amount = 0;
                        showSnackBar(
                            context,
                            "Check Out Date Should Be Greater Then Check in Date",
                            Colors.red);
                      } else {
                        amount =
                            checkOutDate.difference(checkInDate).inDays * 799;
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
                                text: DateFormat.yMMMd().format(checkInDate),
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () async {
                    await _selectCheckOutDate(context);
                    if (checkOutDate.difference(checkInDate).inDays < 0) {
                      amount = 0;
                      showSnackBar(
                          context,
                          "Check Out Date Should Be Greater Then Check in Date",
                          Colors.red);
                    } else {
                      amount =
                          checkOutDate.difference(checkInDate).inDays * 799;
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
                                text: DateFormat.yMMMd().format(checkOutDate),
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
                height: 20,
              ),
              RoundedLoadingButton(
                onPressed: () {},
                controller: googleController,
                successColor: Colors.green,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                borderRadius: 25,
                color: primaryColor,
                child: Wrap(
                  children: [
                    const Text("Book now & pay at hotel",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("(₹ $amount)",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        )));
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
        checkInDate = picked;
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
        checkOutDate = picked;
      });
    }
  }
}