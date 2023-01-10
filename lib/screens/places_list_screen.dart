import 'package:flutter/material.dart';
import 'package:great_places/providers/user_places.dart';
import 'package:great_places/screens/add_places_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routename = '/add-place-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routename);
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<UserPlaces>(context, listen: false)
              .fetchandSetplaces(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<UserPlaces>(
                      child: const Center(
                        child: Text('Start adding some'),
                      ),
                      builder: (ctx, greatPlace, ch) => greatPlace.items.isEmpty
                          ? ch! // include ! for null safety to make sure that you telling dart it will not be a null
                          : ListView.builder(
                              itemCount: greatPlace.items.length,
                              itemBuilder: (ctx, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlace.items[index].image),
                                ),
                                title: Text(greatPlace.items[index].title),
                                //the reciever can be null so we used exclamation mark
                                // subtitle: Text(greatPlace.items[index].location!.address!),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routename,
                                      arguments: greatPlace.items[index].id);
                                },
                              ),
                            ),
                    ),
        ));
  }
}
