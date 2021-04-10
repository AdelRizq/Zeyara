import 'dart:io';

import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = "/add-place-screen";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  LatLng location;

  _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  _selectLocation(LatLng location) {
    print(location);
    setState(() {
      this.location = location;
    });
  }

  _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        location == null) {
      return;
    }

    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, location);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectLocation),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text("Add new place"),
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
