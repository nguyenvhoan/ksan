
import 'package:flutter/material.dart';
import 'package:testtt/pages/admin/adminManager.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Adminmanager(),
    );
  }
}