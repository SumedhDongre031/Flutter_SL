import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sl/screens/splash_screen.dart';
import 'package:test_sl/services/attendance_service.dart';
import 'package:test_sl/services/auth_service.dart';
import 'package:test_sl/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  // INITIALIZE SUPABASE
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MyApp());
}

// Future<void> loadEnvironmentVariables() async {
//   await dotenv.load();
//   final supabaseUrl = dotenv.env['SUPABASE_URL'];
//   final supabaseKey = dotenv.env['SUPABASE_KEY'];

//   if (supabaseUrl == null || supabaseKey == null) {
//     throw Exception(
//         'Supabase URL and Key must be provided in the environment variables.');
//   }

//   await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => DbService()),
        ChangeNotifierProvider(create: (context) => AttendanceService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Attendance',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
