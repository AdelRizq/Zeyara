import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

import '../helpers/DBHelper.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  addPlace(
    String title,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: null,
    );

    _places.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'user_places',
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path,
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
              location: null),
        )
        .toList();
    notifyListeners();
  }
}
