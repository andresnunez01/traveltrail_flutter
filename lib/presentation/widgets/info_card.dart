import 'package:flutter/material.dart';


class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const InfoCard(
    {super.key, 
    required this.title, 
    required this.value, 
    required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}