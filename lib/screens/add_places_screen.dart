import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/Widgets/image_input.dart';
import 'package:great_places/Widgets/location_input.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/user_places.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routename = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titlecontroller = TextEditingController();
  late File _pickedImage;
  PlaceLocation? _pickedlocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  //passimg the data in add place
  void _selectPlace(double lat, double lng) {
    _pickedlocation = PlaceLocation(latitudes: lat, longitudes: lng);
  }

  void _savePlace() {
    if (_titlecontroller.text.isEmpty ||
        _pickedImage == null ||
        _pickedlocation == null) {
      return;
    }
    Provider.of<UserPlaces>(context, listen: false).addPlaces(
      _titlecontroller.text,
      _pickedImage,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Name of the Place',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20,
                              )),
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      controller: _titlecontroller,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 30,
                    ),
                    LocationInput(onSelectPlace: _selectPlace),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(110, 0, 110, 160),
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                icon: Icon(Icons.add),
                label: Text('Add Place'),
                onPressed: _savePlace),
          )
        ],
      ),
    );
  }
}
