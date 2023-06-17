import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/services/database.dart';
import 'package:sweetncolours/shared/loading.dart';
class ProdDetails extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? description;
  String? details;
  ProdDetails(this.image, this.name, this.price, this.description,this.details);

  @override
  State<ProdDetails> createState() => _ProdDetailsState();
}

class _ProdDetailsState extends State<ProdDetails> {
  
  int q = 1;
  bool loading=false;
  String qty = "1";
  void addQty(bool Add) {
    setState(() {
      if (Add == true) {
        if (q <10) {
          q++;
        }
      } else {
        if (q > 1) {
          q--;
        }
      }

      qty = q.toString();
    });
  }
  bool extendDesc=false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObj?>(context);
    double price = double.parse("${widget.price}");
    return (loading==true)?Loading():Scaffold(
      body: Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${widget.image}"), fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 10,
                          width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${widget.name}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey[800]),),
                                    Icon(Icons.favorite_border,color: Colors.grey[700],)
                                  ],
                                ),
                          SizedBox(height: 6,),
                          Text("₱ ${double.parse("${widget.price}")}",style: TextStyle(color:Color.fromRGBO(215,15,100, 1),fontSize: 18),),
                           SizedBox(height: 24,),
                           TextFormField(
                      
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        hintText:"Message on cake...",
                      ),
                      
                      onChanged: (val) {
                        setState(() {
                        });
                      },
                    ), 
                    SizedBox(height: 24,),    
                          Text("PRODUCT DETAILS",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[800]),),
                          SizedBox(height: 18,),
                          Text(
                            "${widget.details}",
                            style: TextStyle(fontSize: 16,height:1.5,color:Colors.grey[700]),
                            maxLines: null,
                        
                          ),
                          SizedBox(height: 24,),
                          Text("PRODUCT DESCRIPTION",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[800]),),
                          SizedBox(height: 18,),
                          Text(
                            "${widget.description}",
                            style: TextStyle(fontSize: 16,height:1.5,color:Colors.grey[700]),
                            maxLines: (extendDesc==true)?null:3,
                        
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                extendDesc=!extendDesc;
                              });
                            },
                            child: Text("${(extendDesc==true)?"show less":"show more"}",style: TextStyle(color:Color.fromRGBO(215,15,100, 1),fontSize: 16),),
                          ),
                          SizedBox(height:24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(FontAwesomeIcons.award,color:Colors.grey[800]),
                                  SizedBox(width: 16,),
                                  Text("Best Quality",style:TextStyle(color: Colors.grey[800]))
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(FontAwesomeIcons.truckFast,color:Colors.grey[800]),
                                  SizedBox(width: 20,),
                                  Text("Fast Delivery",style:TextStyle(color: Colors.grey[800])),
                                  SizedBox(width: 21,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(FontAwesomeIcons.moneyBill1Wave,color:Colors.grey[800]),
                                  SizedBox(width: 16,),
                                  Text("Cash-on-Delivery",style:TextStyle(color: Colors.grey[800]))
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(FontAwesomeIcons.faceSmile,color:Colors.grey[800]),
                                  SizedBox(width: 16,),
                                  Text("Very Convenient",style:TextStyle(color: Colors.grey[800]))
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                         Container(
                          color: Colors.grey[100],
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                             children: [
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    InkWell(onTap: (){addQty(false);},child: Icon(Icons.remove)),
                                    SizedBox(width: 16,),
                                    Text("$qty",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 16,),
                                    InkWell(onTap: (){addQty(true);},child: Icon(Icons.add)),
                                    
                                  ],
                                )
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  color:Color.fromRGBO(215,15,100, 1),
                                  child: Center(
                                    child: Text("₱ ${q*double.parse("${widget.price}")} | Add to cart", style: TextStyle(color:Colors.white,fontSize:15),),
                                  ),
                                ),
                                onTap: ()async{
                                  setState(() {
                                    loading=true;
                                  });
                                  dynamic res=await DatabaseService(user?.uid, user?.email,'').addProductToCart("${widget.name}", "${widget.price}", "${widget.image}", "${widget.description}", "$qty", "${q*double.parse("${widget.price}")}");
                                  if(res!=null)
                                  {
                                    setState(() {
                                    loading=false;
                                  });
                                  }
                                },
                              )
                             ],
                           ),
                         ),
            
                        ],
                      ),
                    ),
                  )
                ],
              ),
        ),
            
      ),
      
    );
  }
}
