import 'package:flutter/material.dart';

class ClassViewComponent extends StatefulWidget {
  final String className; // Add a class name parameter

  const ClassViewComponent({Key? key, required this.className}) : super(key: key);

  @override
  State<ClassViewComponent> createState() => _ClassViewComponentState();
}

class _ClassViewComponentState extends State<ClassViewComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 200,
        child: ElevatedButton(
          onPressed: () {
            // You can add functionality here if needed
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(
            widget.className, // Use the passed class name
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
