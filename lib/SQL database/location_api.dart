import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyA09AZJsR_98VHYbSf6nFAdJ34CaLYhhGU';

class LocationHelper {
  static String genratelocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=300x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  //here we have implemented the geocoding to make latitude and longitude readable
  // static Future<String> getPlaceAdress(double lat, double lng) async {
  //   var url =
  //       Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
  //   final response = await http.get(url);
  //   // print(json.decode(response.body));
  //   return json.decode(response.body)['result'][0]['formatted_address'];
  // }
}
