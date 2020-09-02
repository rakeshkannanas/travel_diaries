import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_diaries/models/places.dart';
import 'package:travel_diaries/providers/place_provider.dart';
import 'package:travel_diaries/screens/map_full_screen.dart';

class PlacesDetailsScreen extends StatelessWidget {
  static const routeName = 'PlacesDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final data = Provider.of<PlaceProvider>(context).getSinglePlace(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(data.title),
        ),
        body: Column(
          children: [
            Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Center(
                  child: (Image.file(data.image,
                      width: double.infinity, fit: BoxFit.cover)),
                )),
            SizedBox(
              height: 150,
            ),
            Text(
              data.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => MapFullScreen(
                            isSelecting: false,
                            placeLocation: data.location,
                          ),fullscreenDialog: true));
                },
                child: Text(
                  'Open location on map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ],
        ));
  }
}
