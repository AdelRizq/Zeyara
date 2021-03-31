import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Places"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
