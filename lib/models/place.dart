import 'dart:io';

class PlaceLocation {
  final double latitudes;
  final double longitudes;
  final String address;

  PlaceLocation(
      {required this.latitudes,
      required this.longitudes,
      required this.address});
}

class Place {
  final String id;
  final String title;
  final PlaceLocation ? location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}
