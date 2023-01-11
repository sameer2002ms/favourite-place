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
          elevation: 0,
          title: Text("Your Places"),
          actions: <Widget>[
            IconButton(
              color: Colors.black,
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
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<UserPlaces>(
                  child: const Center(
                    child: Text('Start adding some'),
                  ),
                  builder: (ctx, greatPlace, ch) => greatPlace.items.isEmpty
                      ? ch! // include ! for null safety to make sure that you telling dart it will not be a null
                      : Container(
                          // color: Colors.white,
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: ListView.builder(
                            itemCount: greatPlace.items.length,
                            itemBuilder: (ctx, index) => Card(
                              elevation: 0,
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              child: ListTile(
                                //for image
                                leading: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(
                                        greatPlace.items[index].image),
                                  ),
                                ),
                                //for text
                                title: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 3, 0, 2),
                                    child: Text(
                                      greatPlace.items[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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
                        ),
                ),
        ));
  }
}
