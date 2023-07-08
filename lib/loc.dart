import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class RiderLocationMap extends StatefulWidget {
  const RiderLocationMap({super.key});

  @override
  State<RiderLocationMap> createState() => _RiderLocationMapState();
}

class _RiderLocationMapState extends State<RiderLocationMap> {
  CameraPosition initialPosition= CameraPosition(target: LatLng(9.3068,123.3054),zoom:12.0);
  final Completer<GoogleMapController> controller=Completer();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Rider?>(context);
    CameraPosition initialPosition= CameraPosition(target: LatLng((user!=null)?user.lat:0,(user!=null)?user.long:0),zoom:16.0);
    return 
                   GoogleMap(
                    initialCameraPosition: initialPosition, mapType: MapType.normal,onMapCreated: (GoogleMapController controller){
                      this.controller.complete(controller);
                    },
                    markers:{
                      
                      Marker(markerId:MarkerId("dest"),position:LatLng((user!=null)?user.lat:0,(user!=null)?user.long:0)),
                      
                    },);
  }
}