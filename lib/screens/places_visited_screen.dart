import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_diaries/providers/place_provider.dart';
import 'package:travel_diaries/screens/add_places_screen.dart';
import 'package:travel_diaries/screens/place_details_screen.dart';

class PlacesVisitedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context,listen: false).fetchData(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlaceProvider>(
                    child: Center(child: Text('No places added yet !!!')),
                    builder: (context, data, ch) => data.getPlaces.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: data.getPlaces.length,
                            itemBuilder: (ctx, i) => Container(
                                  margin: EdgeInsets.all(10),
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            FileImage(data.getPlaces[i].image),
                                      ),
                                      title: Text(data.getPlaces[i].title),
                                      subtitle: Text(data.getPlaces[i].location.address),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(PlacesDetailsScreen.routeName,arguments: data.getPlaces[i].id);
                                      },
                                    ),
                                  ),
                                )),
                  ),
      ),
    );
  }
}
