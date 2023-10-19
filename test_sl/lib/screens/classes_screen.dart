import 'package:flutter/material.dart';
import 'package:test_sl/screens/classview_component.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: const [
          ClassViewComponent(className: 'Class 10',),
          
        ],),
    );
  }
}