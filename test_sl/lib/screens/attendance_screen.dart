import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:test_sl/models/user_model.dart';
import 'package:test_sl/screens/classes_screen.dart';
import 'package:test_sl/screens/marks_screen.dart';
import 'package:test_sl/services/attendance_service.dart';
import 'package:test_sl/services/db_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>();

  @override
  void initState() {
    Provider.of<AttendanceService>(context, listen: false).getTodayAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 40),
              child: const Text("Welcome", style: TextStyle(color: Colors.black54, fontSize: 30),),
            ),
            Consumer<DbService>(
              builder:(context, dbService, child) {
              return  FutureBuilder(
                future: dbService.getUserData(), 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data!;
                    return Container(
                      //margin: const EdgeInsets.only(top: 32),
                      alignment: Alignment.centerLeft,
                      child: Text(user.name != '' ? user.name : "#${user.studentId}", 
                      style: const TextStyle(fontSize: 25),),
                    );
                  }
                  return const SizedBox(width: 60, child: LinearProgressIndicator(),);
                });
            }),
            Container(
              margin: const EdgeInsets.only(top: 25),
              alignment: Alignment.centerLeft,
              child: const Text("Today's Status", style: TextStyle(fontSize: 20),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 12),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2)
                )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Check In", style: TextStyle(fontSize: 20, color: Colors.black54),),
                      const SizedBox(width: 80, child: Divider(),),
                      Text(
                        attendanceService.attendanceModel?.checkIn ?? '--/--', 
                        style: const TextStyle(fontSize: 25),)
                    ],
                  ),),
                  Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Check Out", style: TextStyle(fontSize: 20, color: Colors.black54),),
                      const SizedBox(width: 80, child: Divider(),),
                      Text(
                        attendanceService.attendanceModel?.checkOut ?? '--/--', 
                        style: const TextStyle(fontSize: 25),)
                    ],
                  ),),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat("dd MMMM yyyy").format(DateTime.now()), 
                style: const TextStyle(fontSize: 20),),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat("hh:mm:ss a").format(DateTime.now()), 
                    style: const TextStyle(fontSize: 15, color: Colors.black54),),
                );
              }
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Builder(builder: (context) {
                return SlideAction(
                  text: attendanceService.attendanceModel?.checkIn == null ? "Slide to Check in" : "Slide to Check Out",
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18
                  ),
                  outerColor: Colors.white,
                  innerColor: Colors.green,
                  key: key,
                  onSubmit: () async{
                    await attendanceService.markAttendance(context);
                    key.currentState!.reset();
                    //return null;
                  },
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25,),
              alignment: Alignment.centerLeft,
              child: const Text("Your Agenda", style: TextStyle(fontSize: 20),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 12),
              height: 250,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 196, 255, 198),
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2)
                )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                    width: 150,
                    height: 200,
                    child: ElevatedButton(
                      onPressed: (){
                         // Navigate to the second screen when the button is pressed
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ClassesScreen()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text("Classes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: ElevatedButton(
                      onPressed: (){
                        // Navigate to the second screen when the button is pressed
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MarksScreen()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text("Marks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}