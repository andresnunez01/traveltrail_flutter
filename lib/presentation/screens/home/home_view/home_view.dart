import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltrail_flutter/domain/providers/travel_provider.dart';
import 'package:traveltrail_flutter/presentation/widgets/info_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_){
        final provider = Provider.of<TravelProvider>(context, listen: false);
        provider.getTravels();
      });
  }

  @override
  Widget build(BuildContext context) {
    final travelProvider = Provider.of<TravelProvider>(context);
    
    return SafeArea(
      child: Padding(
        padding:  const EdgeInsets.all(10.0),
        child:  Column(
          children: [
            const Text(
              "Travel Trail APP", 
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: "Viajes Realizados", value: travelProvider.viajesCount.toString(), color: Colors.blueAccent),
                InfoCard(title: "Por Visitar", value: travelProvider.porViajarCount.toString(), color: Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 20,),
            const Text(
              "Ultimos viajes", 
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, 
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: travelProvider.travels.length,
              itemBuilder: (context, index) {
                final travel = travelProvider.travels[index];
                return Card(
                  child: ListTile(
                    title: Text(travel.locationName),
                    subtitle: Text(travel.description),
                    leading: const Icon(Icons.card_travel, color: Colors.amberAccent,),
                    trailing: Icon(Icons.check_circle, color: travel.isEmailSent ? Colors.green : Colors.deepOrange,),
                  ),
                );
              },
            ),)
          ],
        ),
      ),
    );
  }
}