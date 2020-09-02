import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_diaries/helpers/location_helper.dart';
import 'package:travel_diaries/screens/map_full_screen.dart';

class MapPreview extends StatefulWidget {
  final Function passAddress;

  MapPreview(this.passAddress);

  @override
  _MapPreviewState createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  String _mapLocationImg;

  Future<void> toMapScreen() async {
    final result = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
        builder: (ctx) => MapFullScreen(
              isSelecting: true,
            ),
        fullscreenDialog: true));
    if (result == null) {
      return;
    }
    print(result.latitude);
    print(result.longitude);
    final url =
        LocationHelper.getLocationImage(result.latitude, result.longitude);
    setState(() {
      _mapLocationImg = url;
    });
    widget.passAddress(result.latitude, result.longitude);
  }

  Future<void> getCurrentLoca() async {
    final locationData = await Location().getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    final url = LocationHelper.getLocationImage(
        locationData.latitude, locationData.longitude);
    setState(() {
      _mapLocationImg = url;
    });
    widget.passAddress(locationData.latitude, locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _mapLocationImg == null
              ? Center(child: Text('No Location Added'))
              : Image.network(
                  _mapLocationImg,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                onPressed: () {
                  getCurrentLoca();
                },
                icon: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text('Current location')),
            FlatButton.icon(
                onPressed: () {
                  toMapScreen();
                },
                icon: Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text('Select on map')),
          ],
        )
      ],
    );
  }
}
