import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltrail_flutter/config/app_router.dart';
import 'package:traveltrail_flutter/domain/datasources/traveltrail_datasource.dart';
import 'package:traveltrail_flutter/domain/providers/travel_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> TravelProvider(datasource: TraveltrailDatasource()))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'HomeScreen',
        theme: ThemeData(fontFamily: "Poppins"),
      ),
    );
  }
}