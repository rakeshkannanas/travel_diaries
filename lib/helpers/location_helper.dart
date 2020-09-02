import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = '';

class LocationHelper
{

  static String getLocationImage(double lat,double long)
  {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=20&size=600x300&maptype=roadmap&markers=color:green%7Clabel:A%7C$lat,$long&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddress(double lat,double long) async
  {
    final url ='https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY';
    final res = await http.get(url);
    print(res.body);
    return jsonDecode(res.body)['results'][0]['formatted_address'];
  }
}