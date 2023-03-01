import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screen/home_screen.dart';
import 'package:movie_app/screen/profile_screen.dart';
import 'package:movie_app/screen/ticket_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _activeIndex = 0;

  List pages = [
    HomeScreen(),
    ProfileScreen(),
    TicketScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _activeIndex,
        onTap: (value) {
          setState(() {
            _activeIndex = value;
          });
        },
        backgroundColor: Color(0xff05103A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: pages[_activeIndex],
    );
  }
}
