import 'package:flutter/foundation.dart';
import 'package:travel_diaries/helpers/db_helper.dart';
import 'package:travel_diaries/helpers/location_helper.dart';
import 'package:travel_diaries/models/places.dart';
import 'dart:io';

class PlaceProvider with ChangeNotifier {
  List<Places> _placesList = [];

  List<Places> get getPlaces {
    return [..._placesList];
  }

  Future<void> addPlace(String title, File img, Location location) async {
    final address =
        await LocationHelper.getAddress(location.lat, location.long);

    final place = Places(
        id: DateTime.now().toString(),
        title: title,
        image: img,
        location:
            Location(lat: location.lat, long: location.long, address: address));
    _placesList.add(place);
    DBHelper.insert("userplaces", {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': location.lat,
      'long': location.long,
      'address': address
    });
    notifyListeners();
  }

  Future<void> fetchData() async {
    final data = await DBHelper.getData("userplaces");
    _placesList = data
        .map((e) => Places(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: Location(
                lat: e['lat'], long: e['long'], address: e['address'])))
        .toList();
    notifyListeners();
  }

  Places getSinglePlace(String id)
  {
   return _placesList.firstWhere((element) => element.id == id);
  }
}
