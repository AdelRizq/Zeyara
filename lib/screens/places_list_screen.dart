import 'package:flutter/material.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/places.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                    child: const Text("No places yet, please add some :)")),
                builder: (ctx, places, ch) => places.places.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: places.places.length,
                        itemBuilder: (ctx, idx) => Dismissible(
                          key: Key(places.places[idx].id),
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: 25,
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            final title = places.places[idx].title;
                            places.deletePlace(places.places[idx].id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("${title} was removed successfully")));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(places.places[idx].image),
                            ),
                            title: Text(places.places[idx].title),
                            subtitle: Text(places.places[idx].address),
                            onTap: () {
                              // go to details page
                              Navigator.of(context).pushNamed(
                                  PlaceDetailsScreen.routeName,
                                  arguments: places.places[idx].id);
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
