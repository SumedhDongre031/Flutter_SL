import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_sl/screens/attendance_screen.dart';
import 'package:test_sl/screens/calender_screen.dart';
import 'package:test_sl/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> navigationIcons = [
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.solidUser
  ];
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          CalenderScreen(),
          AttendanceScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2,2))]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              for(int i=0; i < navigationIcons.length; i++)...{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Center(
                      child: FaIcon(navigationIcons[i],
                      color: i == currentIndex ? Colors.green : Colors.black54,
                      size: i == currentIndex ? 30 : 26,
                      ),)),
                )
              }
          ],
        ),
      ),
    );
  }
}
