import 'package:flutter/material.dart';
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
  
 DateTime? datetime;
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
            
            Container(
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
                    "${address[0].toString()}, ${address[1].toString()}, Negros Oriental",style: TextStyle(color: Colors.grey[800]),),
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
                          setState(() {
                            loading=true;
                            datetime= DateTime.now();
                          });
                          dynamic res= await DatabaseService(user?.uid,user?.email,"",).placeOrder("$total","${address[0].toString()}, ${address[1].toString()}, Negros Oriental" , phone, "invalid", "${user?.uid}","$datetime");
                          if(res==null)
                          {
                            
                            // ignore: avoid_function_literals_in_foreach_calls
                            widget.productlist.forEach((element)async{
                              dynamic r = await DatabaseService(user?.uid,user?.email,"",).addProductToOrder("${element.name}","${element.price}","${element.total}","${element.quantity}","${user?.uid}","$datetime","${element.image}");
                              if(element==widget.productlist.last)
                              {
                                if(r!=null)
                              {
                                dynamic res= await DatabaseService(user?.uid,user?.email,"",).updateOrder("pending", "${user?.uid}","$datetime");
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
