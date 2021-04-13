import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places.dart';

import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';
import './screens/place_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
