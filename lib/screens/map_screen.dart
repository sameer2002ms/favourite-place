import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initiallocation;
  final bool isSelecting;

  const MapScreen(
      {this.initiallocation =
          const PlaceLocation(latitudes: 33.546, longitudes: 45.545),
      this.isSelecting = false,
      PlaceLocation? initialLocation});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng  ? _pickedplace;

  void _selectPlace(LatLng position) {
    setState(() {
      _pickedplace = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Map"),
        //if we selcting the location then the following function will execute
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedplace == null
                  ? null
                  : () {
                      //the data we will picked while pop up
                      Navigator.of(context).pop(_pickedplace);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initiallocation.latitudes,
              widget.initiallocation.longitudes),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectPlace : null,
        markers: (_pickedplace == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedplace ??
                      LatLng(widget.initiallocation.latitudes,
                          widget.initiallocation.longitudes),
                ),
              },
      ),
    );
  }
}
