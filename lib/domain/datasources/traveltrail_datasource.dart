import 'package:dio/dio.dart';
import 'package:traveltrail_flutter/domain/entities/travel.dart';

class TraveltrailDatasource {

  Future<List<Travel>> getTravels() async{
     try{
      var dio = Dio();
      dio.options.baseUrl = "https://traveltralflutter.ddns.net/api";
      // dio.interceptors.add(ApiInterceptor());
      final response = await dio.get("/travels");
      final data = response.data as List;
      final travel = Travel.fromJson(data[0]);
      return data.map((item)=> Travel.fromJson(item)).toList();
     }catch(e){
      print(e);
      return [];
     }
  }

  Future<Travel> createTravel(Travel travel) async{
    
    try{

      var dio = Dio();
      dio.options.baseUrl = "https://traveltralflutter.ddns.net/api";
      final response = await dio.post("/travels",
        data: {
          "locationName": travel.locationName.trim(),
          "description": travel.description.trim(),
          "lat": travel.lat,
          "lng": travel.lng,
          "type": travel.type.trim()
        }
      );
      print("createTravel ok");

      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
      return Travel.fromJson(response.data);

    }on DioException catch (e){
      print("Código de estado: ${e.response?.statusCode}");
      print("Datos de respuesta: ${e.response?.data}");
      rethrow;
    }
  }
}

// class ApiInterceptor extends Interceptor{

// }