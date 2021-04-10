import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';

import '../helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  final bool isSelecting;
  LatLng location;

  MapScreen({this.location, this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _selectLocation(LatLng location) {
    setState(() => widget.location = location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => Navigator.of(context).pop(widget.location),
            )
        ],
      ),
      body: LocationHelper.generateLocationPreviewImage(
        MapOptions(
          center: widget.location,
          zoom: 13.0,
          onTap: widget.isSelecting ? _selectLocation : null,
        ),
        widget.location,
      ),
    );
  }
}
