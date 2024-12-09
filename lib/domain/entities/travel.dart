

class Travel {
  final String id;
  // final String username;
  final String locationName;
  final String description;
  final double lat;
  final double lng;
  final bool isEmailSent;
  final String type;

  Travel({
    required this.id,
    // required this. username,
    required this.locationName,
    required this.description,
    required this. lat,
    required this.lng,
    required this.isEmailSent,
    required this.type
  });

  factory Travel.fromJson(Map<String, dynamic> json){
    return Travel(
      id: json["_id"] as String, 
      // username: json["username"] as String,
      locationName: json["locationName"] as String, 
      description: json["description"] as String, 
      lat: json["lat"] as double, 
      lng: json["lng"] as double, 
      isEmailSent: json["isEmailSent"] as bool,
      type: json["type"] as String
      );
  }
}