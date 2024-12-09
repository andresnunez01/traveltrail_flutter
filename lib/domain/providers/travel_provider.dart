import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltrail_flutter/domain/datasources/traveltrail_datasource.dart';
import 'package:traveltrail_flutter/domain/entities/travel.dart';


class TravelProvider extends ChangeNotifier{
  TraveltrailDatasource datasource;
  List<Travel> travels = [];
  int viajesCount = 0;
  int porViajarCount = 0;
  TravelProvider({
    required this.datasource
  });


  Future getTravels() async {
    travels = await datasource.getTravels();
    viajesCount = travels.where((element) => element.type == "Viajes").length;
    porViajarCount = travels.where((element) => element.type == "Por Viajar").length;
    print(travels);
    notifyListeners();
  }

  Future addTravel(Travel travel) async {
    final newTravel = await datasource.createTravel(travel);
    travels.add(travel);
    viajesCount = travels.where((element) => element.type == "Viajes").length;
    porViajarCount = travels.where((element) => element.type == "Por Viajar").length;
    notifyListeners();
  }


  // Future saveText(String text) async{
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("savedText", text);
  // }

  // Future getText(String key) async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final text = prefs.getString(key);
  // prefs.remove(key);
  //   print(text)
  // }
}