import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/places.dart';

class PlacesListScreen extends StatelessWidget {
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
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
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
                            itemBuilder: (ctx, idx) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(places.places[idx].image),
                              ),
                              title: Text(places.places[idx].title),
                              subtitle: Text(places.places[idx].address),
                              onTap: () {
                                // go to details page
                              },
                            ),
                          ),
                  ),
      ),
    );
  }
}
