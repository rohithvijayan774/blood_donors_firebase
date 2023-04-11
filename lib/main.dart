import 'package:blood_donation/screens/add_donors_screen.dart';
import 'package:blood_donation/screens/donor_details.dart';
import 'package:blood_donation/screens/home_screen.dart';
import 'package:blood_donation/screens/update_donors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddDonorsScreen(),
        '/update': (context) => const UpdateDonorsScreen(),
      },
    );
  }
}
