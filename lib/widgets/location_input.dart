import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function _selectLocation;

  LocationInput(this._selectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _imagePreviewUrl;
  Widget locationMap;

  Future<void> _getCurrentUserLocation() async {
    final curLocation = await Location().getLocation();
    _imagePreviewUrl = '1';

    final LatLng location = LatLng(curLocation.latitude, curLocation.longitude);
    setState(
      () {
        locationMap = LocationHelper.generateLocationPreviewImage(
          MapOptions(
            center: location,
            zoom: 13.0,
          ),
          location,
        );
      },
    );

    widget._selectLocation(location);
  }

  Future<void> _chooseOnMap() async {
    final curLocation = await Location().getLocation();
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          location: LatLng(curLocation.latitude, curLocation.longitude),
          isSelecting: true,
        ),
        fullscreenDialog: true,
      ),
    );

    setState(
      () {
        locationMap = LocationHelper.generateLocationPreviewImage(
          MapOptions(
            center: selectedLocation,
            zoom: 13.0,
          ),
          selectedLocation,
        );
      },
    );

    widget._selectLocation(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: _imagePreviewUrl == null
              ? Center(
                  child: Text("No location yet!"),
                )
              : Center(
                  child: locationMap,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current location"),
            ),
            TextButton.icon(
              onPressed: _chooseOnMap,
              icon: Icon(Icons.map),
              label: Text("Pick on map"),
            ),
          ],
        )
      ],
    );
  }
}
