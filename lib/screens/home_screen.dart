import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud/provider/sign_in_provider.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      body: SafeArea(
        child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: onPageChanged,
            children: homeScreenWidgets),
      ),
      bottomNavigationBar: CupertinoTabBar(
        border: const Border.fromBorderSide(BorderSide.none),
        height: 70,
        backgroundColor: const Color.fromARGB(179, 227, 227, 227),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              backgroundColor: primaryColor,
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              backgroundColor: primaryColor,
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              backgroundColor: primaryColor,
              label: ''),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
