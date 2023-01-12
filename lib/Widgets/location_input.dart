import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../SQL database/location_api.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput({super.key, required this.onSelectPlace});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

//here we have taken the input latitude and logitude
class _LocationInputState extends State<LocationInput> {
  String? _prewImageUrl;

  void _showpreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.genratelocationPreviewImage(
        latitude: lat, longitude: lng);
    // print(locData.longitude);
    // print(locData.latitude);

    setState(() {
      _prewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserlocation() async {
    try {
      final locData = await Location().getLocation();
      _showpreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    // print(selectedLocation.latitude);
    _showpreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);

    ////*******
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 2, color: Colors.amber),
              borderRadius: BorderRadius.circular(15)),
          child: _prewImageUrl == null
              ? Text(
                  'No location choosen',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _prewImageUrl!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
        ),
        Row(
          children: <Widget>[
            //buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: TextButton.icon(
                  icon: Icon(
                    Icons.location_on,
                  ),
                  label: Text(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    'Current Location',
                  ),
                  onPressed: _getCurrentUserlocation),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: TextButton.icon(
                icon: Icon(
                  Icons.map,
                ),
                label: Text(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    'Select on Map'),
                onPressed: _selectOnMap,
              ),
            ),
          ],
        )
      ],
    );
  }
}
