import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/SQL%20database/database_help.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
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
