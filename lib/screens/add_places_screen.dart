import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:travel_diaries/models/places.dart' as L;
import 'package:travel_diaries/providers/place_provider.dart';
import 'package:travel_diaries/widgets/image_picker.dart';
import 'dart:io';

import 'package:travel_diaries/widgets/map_preview.dart';

class AddPlacesScreen extends StatefulWidget {
  static const routeName = 'AddPlacesScreen';
  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {

  final _titleController = TextEditingController();
  final _key = GlobalKey<FormState>();
  L.Location _location;
  String title ='';
  File pickedImg;

  void onSaved(File imagePath)
  {
   pickedImg = imagePath;
  }

  void addPlace()
  {
    if(!_key.currentState.validate())
    {
      return;
    }
    else if(pickedImg == null)
      {
        return;
      }
    else if(_location == null)
    {
      return;
    }
    _key.currentState.save();
    Provider.of<PlaceProvider>(context,listen: false).addPlace(title, pickedImg,_location);
    Navigator.of(context).pop();
  }

  void addAddress(double lat,double long){
    _location =  L.Location(lat: lat,long: long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        onSaved: (val)=>title=val,
                        validator: (val){
                          if(val.isEmpty)
                            {
                              return 'Enter title';
                            }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    ImagePick(onSaved),
                    SizedBox(height: 10,),
                    MapPreview(addAddress)
                  ],
                ),
              ),
            ),
          ),
          FlatButton.icon(onPressed: (){
            addPlace();
          },
          icon: Icon(Icons.add),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: Text('ADD PLACE'),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
