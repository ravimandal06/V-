import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vender/homeNav.dart';

void main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "auth-vender",
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCLVTFhtqQrUF7E8HZwWS9hYnJTX3c7z0M',
      appId: '1:309678650326:android:bc471e1692319b83146a77',
      messagingSenderId: '309678650326',
      projectId: 'ecommerce-vender',
      storageBucket: 'ecommerce-vender.appspot.com',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final token;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeNav(),
    );
  }
}
