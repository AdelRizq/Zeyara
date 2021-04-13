import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './map_screen.dart';
import '../providers/places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static String routeName = "/place-details";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<Places>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
              ),
              alignment: Alignment.center,
              width: double.infinity,
              height: 300,
            ),
          ),
          Text(
            place.address,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text("View on map"),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    MapScreen(location: place.location, isSelecting: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
