import 'dart:io';
import 'package:flutter/foundation.dart';

class Location {
  final double lat;
  final double long;
  final String address;
  const Location({@required this.lat,@required this.long,this.address});
}

class Places {
  final String id;
  final String title;
  final File image;
  final Location location;

  Places({@required this.id,@required this.title,@required this.image,@required this.location});
}