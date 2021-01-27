import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/Models/sacan_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPages extends StatefulWidget {
  @override
  _MapPagesState createState() => _MapPagesState();
}

class _MapPagesState extends State<MapPages> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

    MapType mapType = MapType.normal;
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition puntoincial =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 50);

    //Marcadores
    Set<Marker> marker = new Set<Marker>();
    marker.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: scan.getLatLng(), zoom: 16, tilt: 50)));
            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: marker,
        initialCameraPosition: puntoincial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if (mapType == MapType.normal) {
            setState(() {
              mapType = MapType.satellite;
            });
          } else {
            setState(() {
              mapType = MapType.normal;
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}
