import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/services/database.dart';
import 'package:sweetncolours/shared/loading.dart';
// ignore: must_be_immutable
class AddLocation extends StatefulWidget {
  List<Products> productlist = [];
  AddLocation(this.productlist, {super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
 
  
 
  String error="";
  final Completer<GoogleMapController> controller=Completer();
  List<Marker>? locmarker;
  CameraPosition initialPosition= CameraPosition(target: LatLng(12.8797,121.7740),zoom:6.0);
  CameraPosition targetPosition= CameraPosition(target: LatLng(12.8797,121.7740),zoom:6.0,bearing: 192, tilt:60);
  bool getloc=true;
  Position? currentPosition;
  String? currentAddress;
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
Future<void> spotloc() async
{
  final GoogleMapController controller =await this.controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  setState(() {
                  initialPosition= targetPosition;
                });
}
void getAddress(latitude,longitude)async
{
  try
  {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark addr= placemarks[0];
    setState(() {
                currentAddress="${addr.name} ${addr.locality}, ${addr.subAdministrativeArea},${addr.country}";
              });
  }catch(e)
  {
    print(e);
  }
}
void locationStream(latitude, longitude)
{
  final LocationSettings locationSettings = const LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
 Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? position) {
        getAddress(position!.latitude,position.longitude);
        setState(() {
                  targetPosition= CameraPosition(target: LatLng(position.latitude, position.longitude),zoom:16.0,bearing: 192, tilt:60);
                  currentPosition=position;
                });
                spotloc();
    });
}

String dateFormat="";
 bool loading=false;
  @override
  Widget build(BuildContext context) {
    
     final user = Provider.of<UserObj?>(context);
     String phone="+63 906 6581 632";
    double total=0;
    for (var element in widget.productlist) {
      total+=double.parse("${element.total}");
    }
    return (loading==true)?const Loading(): Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
         Center(child: Text("  Almost done", style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Colors.grey[800]))),
         const SizedBox(height: 15,),
         Row(children: [
          Text("Double tap the map to view your loaction", style:TextStyle(fontSize: 16,color:Colors.grey[800])),
          
          ]),
            SizedBox(height:8),
            InkWell(
              onDoubleTap: ()async{
                 currentPosition = await _determinePosition();
                 getAddress(currentPosition!.latitude, currentPosition!.longitude);
                locationStream(currentPosition!.latitude, currentPosition!.longitude);
                setState(() {
                  targetPosition= CameraPosition(target: LatLng(currentPosition!.latitude, currentPosition!.longitude),zoom:16.0,bearing: 192, tilt:60);
                  locmarker=<Marker>[Marker(markerId: MarkerId('12'), position: LatLng(currentPosition!.latitude, currentPosition!.longitude))];
                  
                });
                spotloc();
                
              },
              child:Container(
                
                height: 200,
                child:  GoogleMap(
                  markers:{
                      
                      Marker(markerId:MarkerId("dest"),position:LatLng((currentPosition!=null)?currentPosition!.latitude:0,(currentPosition!=null)?currentPosition!.longitude:0)),
                      
                    },
                  initialCameraPosition: initialPosition, mapType: MapType.normal,onMapCreated: (GoogleMapController controller){
                    this.controller.complete(controller);
                  },),
                
              )
            ),
            
           
          const SizedBox(
              height: 20,
            ),
            Container(
            width: double.maxFinite,
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: Offset(3, 3),
                    spreadRadius: -3,
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.36),
                ),
            ],color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                    (currentAddress!=null)?"${currentAddress}":"",style: TextStyle(color: Colors.grey[800]),),
              )),
         
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: Offset(3, 3),
                    spreadRadius: -3,
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.36),
                ),
            ],color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                    "+63 906 6581 632",style: TextStyle(color: Colors.grey[800]),),
              )),
          Text(error,
                            style: const TextStyle(
                              color:Colors.red,
                              fontSize: 14,
                            ),
                          ),
          const SizedBox(height:3),               
          Container(
            
            width: double.maxFinite,
            padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.white), color: Colors.pink[100]),
              child: Text("Total Cost : P $total")),
         
                          
           
                  const SizedBox(height: 6,),
          SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(onPressed: ()async{
                            if(currentAddress!=null)
                            {
                              
                          setState(() {
                            loading=true;
                            DateTime datetime=DateTime.now();
                            dateFormat=DateFormat.yMMMMd().add_jms().format(datetime);
                          });
                          dynamic res= await DatabaseService(user?.uid,user?.email,"",).placeOrder("$total","${currentAddress}" , phone, "invalid", "${user?.uid}","$dateFormat",currentPosition!.latitude, currentPosition!.longitude);
                          if(res==null)
                          {
                            
                            // ignore: avoid_function_literals_in_foreach_calls
                            widget.productlist.forEach((element)async{
                              dynamic r = await DatabaseService(user?.uid,user?.email,"",).addProductToOrder("${element.name}","${element.price}","${element.total}","${element.quantity}","${user?.uid}","$dateFormat","${element.image}");
                              if(element==widget.productlist.last)
                              {
                                if(r!=null)
                              {
                                dynamic res= await DatabaseService(user?.uid,user?.email,"",).updateOrder("pending", "${user?.uid}","$dateFormat");
                                if(res==null)
                                {
                                  // ignore: avoid_function_literals_in_foreach_calls
                                  widget.productlist.forEach((element) async {
                                    dynamic res= await DatabaseService(user?.uid,user?.email,"",).removeProductfromCart("${element.id}");
                                    if(element == widget.productlist.last)
                                    {
                                      if(res==null)
                                    {
                                      setState(() {
                                loading=false;
                              });
                                    }
                                    }
                                  
                                  });
                                  
                              }
                              }
                              }
                              
                            });
                          
                          }
                          
                            }
                          }, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(215,15,100, 1),),
                            padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
                            elevation: MaterialStateProperty.all(0.0),
                            
                          ),

                          child:const Text('Place Order'),
                          
                          ),
                        ),
        ],
      ),
    );
  }
}
