import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_diaries/providers/place_provider.dart';
import 'package:travel_diaries/screens/add_places_screen.dart';
import 'package:travel_diaries/screens/place_details_screen.dart';
import 'package:travel_diaries/screens/places_visited_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.grey[300]
      ),
        debugShowCheckedModeBanner: false,
        home:  PlacesVisitedScreen(),
        routes: {
        AddPlacesScreen.routeName : (context)=>AddPlacesScreen(),
        PlacesDetailsScreen.routeName : (context) => PlacesDetailsScreen(),
        },
      ),
    );
  }
}
