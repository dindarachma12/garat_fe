import 'package:flutter/material.dart';

class fastaction extends StatelessWidget{
  final String action;

  const fastaction({Key? key,
  required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 165, 255, 179),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text(action,
        style: TextStyle(fontSize: 28),
        )),

    );
  }
}