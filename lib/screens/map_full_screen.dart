import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_diaries/models/places.dart';

class MapFullScreen extends StatefulWidget {
  final Location placeLocation;
  final bool isSelecting;

  MapFullScreen(
      {this.placeLocation = const Location(lat: 13.0452439, long: 80.1986642),
      this.isSelecting = false});

  @override
  _MapFullScreenState createState() => _MapFullScreenState();
}

class _MapFullScreenState extends State<MapFullScreen> {
  LatLng pickedLocation;
  void pickLocation(LatLng location)
  {
    setState(() {
      pickedLocation =location;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [if(widget.isSelecting == true) IconButton(icon: Icon(Icons.done), onPressed: pickedLocation == null ? null : (){
          Navigator.of(context).pop(pickedLocation);
        })],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.placeLocation.lat, widget.placeLocation.long),
            zoom: 20),
        onTap: widget.isSelecting ? pickLocation : null,
        markers: (pickedLocation == null && widget.isSelecting) ? null : {
          Marker(markerId: MarkerId('m1'),position:  pickedLocation ?? LatLng(widget.placeLocation.lat, widget.placeLocation.long))
        },
      ),
    );
  }
}
