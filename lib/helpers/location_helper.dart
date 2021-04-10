import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

const TomtomAPIKey = 'xHtIr8GoJe7T8mNjycXAcPIGDQamQgUs';

class LocationHelper {
  static Widget generateLocationPreviewImage(
      MapOptions options, LatLng location) {
    final map = FlutterMap(
      options: options,
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
              "{z}/{x}/{y}.png?key={apiKey}",
          additionalOptions: {"apiKey": TomtomAPIKey},
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 50.0,
              height: 50.0,
              point: location,
              builder: (BuildContext context) => const Icon(Icons.location_on,
                  size: 40.0, color: Colors.indigo),
            ),
          ],
        ),
      ],
    );

    return map;
  }

  static Future<String> getPlaceAddress(LatLng location) async {
    final url =
        'https://api.tomtom.com/search/2/reverseGeocode/${location.latitude},${location.longitude}.JSON?key=$TomtomAPIKey&language=en';

    final response = await http.get(Uri.parse(url));

    final addresses = json.decode(response.body)['addresses'];
    if (addresses == null || addresses.length == null)
      return "Can't find a suitble address for the location";

    final String address = addresses[0]['address']['freeformAddress'];

    return address;
  }
}
