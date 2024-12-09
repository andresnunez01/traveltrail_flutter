import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:traveltrail_flutter/domain/entities/travel.dart';
import 'package:traveltrail_flutter/domain/providers/travel_provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});
  
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final descriptionController = TextEditingController();
  final locationNameController = TextEditingController();
  final Set<Marker> _markers = {};

  @override
  void initState() {
      super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_){
          _loadMarkers();
        });
    }

  void _loadMarkers() async {
  final provider = Provider.of<TravelProvider>(context, listen: false);
  await provider.getTravels();
  setState(() {
    _markers.clear();
    for(var travel in provider.travels){
      _markers.add(
        Marker(
          markerId: MarkerId(travel.id),
          position: LatLng(travel.lat, travel.lng),
          infoWindow: InfoWindow(
            title: travel.locationName,
            snippet: travel.description)
        
        )
      );
    }
  });
}
  
  void onLongPress(LatLng position){
    showDialog(context: context, builder: (BuildContext context){
      final options = ["Viajes", "Por Viajar"];
      String selectedType = "Viajes";
      return AlertDialog(
        title: const Text("Agregar viaje"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: locationNameController, 
              decoration: InputDecoration( labelText: "Location Name", 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))),),
            const SizedBox(height: 15,),
            TextField(
              controller: descriptionController, 
              decoration: InputDecoration( labelText: "Description", 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))),),
            const SizedBox(height: 15,),
            DropdownButtonFormField(
              value: selectedType,
              items: options.map((type){
                return DropdownMenuItem(
                  value: type,
                  child: Text(type));
              }).toList(), 
              onChanged: (value){

                selectedType = value ?? "Viajes";
              },
              decoration: InputDecoration(
                labelText: "Viaje/Por Viajar",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),)
            
          ],
        ),

        actions: [
          TextButton(onPressed: (){
            context.pop();
          }, child: const Text("Cancelar")),
          TextButton(onPressed: (){
            context.pop();
            setState(() {
              _addMarker(
                position, 
                locationNameController.text, 
                descriptionController.text,
                selectedType
              );
              descriptionController.clear();
              locationNameController.clear();
            });
          }, child: const Text("Aceptar"))
        ],
      );
    });
  }


  Future _addMarker(LatLng position, String locationName, String description, String type
  ) async{
    final travelProvider = Provider.of<TravelProvider>(context, listen: false);
    final newTravel = Travel(
      id: '', 
    // username: username, 
    locationName: locationName, 
    description: description, 
    lat: position.latitude, 
    lng: position.longitude, 
    isEmailSent: false,
    type: type
    );

    try{
      
        await travelProvider.addTravel(newTravel);
        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: locationName,
              snippet: description
            )
          ));
        });

    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      initialCameraPosition: const CameraPosition(target: LatLng(23.092555, -109.720608),
      zoom: 12.5,
      ),
      onLongPress: onLongPress,
      markers: _markers,
      );
  }
}