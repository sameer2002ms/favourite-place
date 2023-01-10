import 'package:flutter/material.dart';
import 'package:great_places/providers/user_places.dart';
import 'package:great_places/screens/add_places_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Greate Places',
        theme: ThemeData(
          accentColor: Colors.amber,
          primarySwatch: Colors.amber,
        ),
        home:  PlacesListScreen(),
        routes: {
          AddPlaceScreen.routename: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routename: (context) => PlaceDetailScreen()
          // PlacesListScreen.routename:(context) => PlacesListScreen(),
        },
      ),
    );
  }
}