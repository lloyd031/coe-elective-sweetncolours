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
  final address = ["Buntod", "Bacong"];
  String? completeaddress;
  String? choosenCity = "Bacong";
  String? choosenBarangay = "Bacong";
  String? choosenDistrict = "Bacong";
  String error="";
  String? street;
  int cityIndex = 0;
  int? barangayIndex = 0;
  final city = [
    'Bacong',
    'Dumaguete City',
    'Sibulan',
  ];
  final barangay = [
    [
      'Balayagmanok',
      'Banilad',
      'Buntis',
      'Buntod',
      'Calangag',
      'Combado',
      'Doldol',
      'Isugan',
      'Liptong',
      'Lutao',
      'Magsuhot',
      'Malabago',
      'Mampas',
      'North Poblacion',
      'Sacsac',
      'San Miguel',
      'South Poblacion',
      'Sulodpan',
      'Timbanga',
      'Timbao',
      'Tubod',
      'West Poblacion'
    ],
    [
      'Bagacay',
      'Bajumpandan',
      'Balugo',
      'Banilad',
      'Bantayan',
      'Barangay Pob. 1 ',
      'Barangay Pob. 2 ',
      'Barangay Pob. 3 ',
      'Barangay Pob. 4 ',
      'Barangay Pob. 5 ',
      'Barangay Pob. 6 ',
      'Barangay Pob. 7 ',
      'Barangay Pob. 8 ',
      'Batinguel',
      'Buñao',
      'Cadawinonan',
      'Calindagan',
      'Camanjac',
      'Candau-ay',
      'Cantil-e',
      'Daro',
      'Junob',
      'Looc',
      'Mangnao-Canal',
      'Motong',
      'Piapi',
      'Pulantubig',
      'Tabuc-tubig',
      'Taclobo',
      'Talay',
    ],
    [
      'Agan-an',
      'Ajong',
      'Balugo',
      'Boloc-boloc',
      'Calabnugan',
      'Cangmating',
      'Enrique Villanueva',
      'Looc',
      'Magatas',
      'Maningcao',
      'Maslog',
      'Poblacion',
      'San Antonio',
      'Tubigon',
      'Tubtubon'
    ]
  ];
  final Completer<GoogleMapController> controller=Completer();
  static const CameraPosition initialPosition= CameraPosition(target: LatLng(37.15478,-122.78945),zoom:14.0);
  static const CameraPosition targetPosition= CameraPosition(target: LatLng(33.15478,-135.78945),zoom:14.0,bearing: 192, tilt:60);
  bool getloc=false;
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
  final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
 Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? position) {
        getAddress(position!.latitude,position.longitude);
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
          const Icon(Icons.location_pin,color: Color.fromRGBO(215, 15, 100, 1) ,),
          const SizedBox(width: 6,),
          Text("Please provide your location", style:TextStyle(fontSize: 16,color:Colors.grey[800])),
          
          ]),
            
            InkWell(
              onDoubleTap: ()async{
              setState(() {
                getloc=!getloc;
              });
              if(getloc==true)
              {
                currentPosition = await _determinePosition();
                 getAddress(currentPosition!.latitude, currentPosition!.longitude);
                locationStream(currentPosition!.latitude, currentPosition!.longitude);
              }
            },
              child:(getloc==true)?Container(
                
                height: 100,
                child:  GoogleMap(initialCameraPosition: initialPosition, mapType: MapType.normal,onMapCreated: (GoogleMapController controller){
                    this.controller.complete(controller);
                  },),
                
              ): Container(
                width: double.infinity,
                color:Colors.white,
                height:200,
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Container(
                          padding: const EdgeInsets.all(20),
                          height: 200,
                          color:Colors.white,
                          child: Column(
                            
                            children: [
                              const Text("City/Municipality",style:TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 14,),
                              Container(
                                width: 80,
                                height: 2,
                                color:const Color.fromRGBO(215, 15, 100, 1),
                              ),
                              const SizedBox(height: 16,),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    for(int i=0; i<city.length; i++)
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              cityIndex=i;
                                              address[1]=city[i];
                                              address[0]=barangay[i][0];
                                              barangayIndex=0;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(city[i],style:TextStyle(fontWeight: (cityIndex==i)?FontWeight.bold:FontWeight.normal,color: (cityIndex==i)?const Color.fromRGBO(215, 15, 100, 1):Colors.grey[800])),
                                          )),
                                        
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 200,
                          color:Colors.white,
                          child: Column(
                            
                            children: [
                              const Row(
                                children: [
                                  Text("Barangay",style:TextStyle(fontWeight: FontWeight.bold)),
                                  //Icon(FontAwesomeIcons.down)
                                ],
                              ),
                              const SizedBox(height: 14,),
                              Container(
                                width: 80,
                                height: 2,
                                color:const Color.fromRGBO(215, 15, 100, 1),
                              ),
                              const SizedBox(height: 16,),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      for(int i=0; i<barangay[cityIndex].length; i++)
                                      Column(
                                        children: [
                                          InkWell(
                                          onTap: (){
                                            setState(() {
                                              barangayIndex=i;
                                              address[0]=barangay[cityIndex][i];
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(barangay[cityIndex][i],style:TextStyle(fontWeight: (barangayIndex==i)?FontWeight.bold:FontWeight.normal,color: (barangayIndex==i)?const Color.fromRGBO(215, 15, 100, 1):Colors.grey[800])),
                                          )),
                                          
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ), 
                        
                        
                      ],
                    ),
                    
                  ],
                )
              ),
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
                    "${(getloc==true)?currentAddress:"${address[0]} ${address[1]}, Negros Oriental Philippines"}",style: TextStyle(color: Colors.grey[800]),),
              )),
          /*Container(
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
                    "${address[0].toString()}, ${address[1].toString()}, Negros Oriental",style: TextStyle(color: Colors.grey[800]),),
              )),*/
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
                          setState(() {
                            loading=true;
                            DateTime datetime=DateTime.now();
                            dateFormat=DateFormat.yMMMMd().add_jms().format(datetime);
                          });
                          dynamic res= await DatabaseService(user?.uid,user?.email,"",).placeOrder("$total","${address[0].toString()}, ${address[1].toString()}, Negros Oriental" , phone, "invalid", "${user?.uid}","$dateFormat");
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
