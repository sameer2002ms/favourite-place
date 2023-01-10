// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:great_places/SQL%20database/database_help.dart';
// import 'package:great_places/SQL%20database/location_api.dart';
//
// import '../models/place.dart';
//
// class UserPlaces with ChangeNotifier {
//   List<Place> _items = [];
//
//   List<Place> get items {
//     return [..._items];
//   }
//
//   Future<void> addPlaces(
//     String pickedTitle,
//     File pickedImage,
//     PlaceLocation pickedlocation,
//   ) async {
//     final address = await LocationHelper.getPlaceAdress(
//         pickedlocation.latitudes, pickedlocation.longitudes);
//
//     final updatedlocation = PlaceLocation(
//         latitudes: pickedlocation.latitudes,
//         longitudes: pickedlocation.longitudes,
//         address: address);
//
//     final newplace = Place(
//       id: DateTime.now().toString(),
//       image: pickedImage,
//       title: pickedTitle,
//       location: updatedlocation,
//     );
//     _items.add(newplace);
//     notifyListeners();
//     //sql database
//     DatabaseHelp.insert('user_places', {
//       'id': newplace.id,
//       'title': newplace.title,
//       'image': newplace.image.path,
//       'loc_lat': newplace.location!.latitudes,
//       'loc_lng': newplace.location!.longitudes,
//       'address': newplace.location!.address!,
//     });
//   }
//
//   Future<void> fetchandSetplaces() async {
//     final datalist = await DatabaseHelp.getData('user_places');
//     _items = datalist
//         .map((item) => Place(
//             id: item['id'],
//             title: item['title'],
//             image: File(item['image']),
//             location: PlaceLocation(
//                 latitudes: item['loc_lat'],
//                 longitudes: item['loc_lng'],
//                 address: item['address'])))
//         .toList();
//     notifyListeners();
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/SQL%20database/database_help.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findbyId(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlaces(
    String pickedTitle,
    File pickedImage,
  ) {
    final newplace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newplace);
    notifyListeners();
    //sql database
    DatabaseHelp.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path
    });
  }

  Future<void> fetchandSetplaces() async {
    final datalist = await DatabaseHelp.getData('user_places');
    _items = datalist
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null))
        .toList();
    notifyListeners();
  }
}
