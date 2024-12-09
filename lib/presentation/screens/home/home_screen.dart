import 'package:flutter/material.dart';
import 'package:traveltrail_flutter/presentation/screens/home/home_view/home_view.dart';
import 'package:traveltrail_flutter/presentation/screens/home/map_view/map_view.dart';
import 'package:traveltrail_flutter/presentation/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  final int viewIndex;
  const HomeScreen({super.key, required this.viewIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: viewIndex,
        children: const [HomeView(), MapView()],
      ),
      bottomNavigationBar: BottomNavbar(index: viewIndex,),
    );
  }
}
