import 'dart:io';

import 'package:latlong/latlong.dart';
import 'package:flutter/foundation.dart';

import '../models/place.dart';

import '../helpers/dbhelper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(String title, File pickedImage, LatLng location) async {
    String address = await LocationHelper.getPlaceAddress(location);

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: location,
      address: address,
    );

    _places.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'user_places',
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path,
        "loc_lat": newPlace.location.latitude,
        "loc_lng": newPlace.location.longitude,
        "address": newPlace.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final placesData = await DBHelper.getData('user_places');
    _places = placesData
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            image: File(place['image']),
            location: LatLng(place['loc_lat'], place['loc_lng']),
            address: place['address'] ?? "NOT FOUND",
          ),
        )
        .toList();

    notifyListeners();
  }
}
