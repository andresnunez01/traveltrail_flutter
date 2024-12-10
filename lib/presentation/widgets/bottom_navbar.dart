import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatelessWidget {
  final int index;
  const BottomNavbar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      color: const Color.fromARGB(255, 67, 179, 187),
      backgroundColor: Colors.white,
      buttonBackgroundColor: const Color.fromARGB(255, 125, 34, 185),
      onTap: (value){
        switch(value){
          case 0:
          //  Navegar a HomeView
          context.go("/home/0");
          break;
          case 1:
          //  Navegar a MapView
          context.go("/home/1");
          break;
        }
      },
      items: const [
      Icon(Icons.home, color: Colors.white),
      Icon(Icons.map_outlined, color: Colors.white,)
    ]);
  }
}