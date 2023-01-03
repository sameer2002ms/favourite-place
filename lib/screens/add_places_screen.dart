import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/Widgets/image_input.dart';
import 'package:great_places/Widgets/location_input.dart';
import 'package:great_places/providers/user_places.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routename = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titlecontroller = TextEditingController();
  late File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titlecontroller.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<UserPlaces>(context, listen: false)
        .addPlaces(_titlecontroller.text, _pickedImage);
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
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titlecontroller,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(height: 30,),
                    LocationInput()
                    // FlatButton(onPressed: onPressed, child: child)
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
          ),

        ],
      ),
    );
  }
}
