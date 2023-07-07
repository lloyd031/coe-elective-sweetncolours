import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/services/database.dart';

import 'models/product.dart';
import 'models/user.dart';

class OrderDetails extends StatefulWidget {
  final OrderModel? orderdet;
  const OrderDetails({super.key, required this.orderdet});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
 

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
            child: Column(
              children: [
                StreamProvider<List<OrderedProducts>?>.value(
                              value:FetchOrderFromCustomer("${widget.orderdet?.id}${widget.orderdet?.time}",widget.orderdet?.id,).getOrdersItem,
                              initialData: null,
                              child: const OrderedItemProductTiles()),

                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                 Padding(
                  padding: EdgeInsets.only(left:20, top: 20,),
                  child: Row(
                    children: [
                       Icon(FontAwesomeIcons.truckFast,color:Colors.grey[800],size: 16,),
                                        SizedBox(width: 10,),
                      SizedBox(width: 10,),
                      Text("Delivery Details",style:const TextStyle(color:Color.fromRGBO(30,30,50,1),fontSize: 16,fontWeight:FontWeight.bold)),
                    ],
                  ),
                    
                 
                ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(bottom:20),
                   child: StreamProvider<UserData?>.value(
                                value:DatabaseService(widget.orderdet?.id, null,"").userData,
                                initialData: null,
                                child:CustomerProfile(orderdet: widget.orderdet,)),
                 ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                  Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                           Icon(FontAwesomeIcons.moneyBill1Wave,color:Colors.grey[800],size: 16,),
                                            SizedBox(width: 10,),
                          SizedBox(width: 10,),
                          Text("Cash on Delivery",style:const TextStyle(color:Color.fromRGBO(30,30,50,1),fontSize: 16,fontWeight:FontWeight.bold)),
                        ],
                      ),
                      Text((widget.orderdet!=null)?"₱ ${double.parse("${widget.orderdet?.total}").toStringAsFixed(2)}":"",style: const TextStyle(fontWeight: FontWeight.bold)),
                      
                    ],
                  ),
                  
                ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),

                OrderInstruction(index: "1",instruction: "Waiting for sellers approval",status:"pending" ,orderderstatus: "${widget.orderdet?.status}"),
                            OrderInstruction(index: "2",instruction: "Your order is being approved",status:"approved" ,orderderstatus: "${widget.orderdet?.status}",),
                            OrderInstruction(index: "3",instruction: "Ready for delivery",status:"To Deliver"  ,orderderstatus:"${widget.orderdet?.status}"),
                            OrderInstruction(index: "4",instruction: "Delivering",status: "Delivering",orderderstatus: "${widget.orderdet?.status}"),
              ],
            ),
      );
    
  }
}
class OrderedItemProductTiles extends StatefulWidget {
  const OrderedItemProductTiles({super.key});

  @override
  State<OrderedItemProductTiles> createState() => _OrderedItemProductTilesState();
}

class _OrderedItemProductTilesState extends State<OrderedItemProductTiles> {
  @override
  Widget build(BuildContext context) {
    final order= Provider.of<List<OrderedProducts>?>(context);
    return (order==null)?const Text(""):Column(
      children: [
        for(int i=0; i<order.length; i++)
        ListTile(
      title:Text(order[i].name),
      subtitle:const Text("tap to view details") ,
      trailing: ClipOval(
                  child: Container(
                    color:const Color.fromRGBO(254,71,228,1),
                    width:20,
                    height:20,
                    child: Center(
                      child: Text(order[i].qty,
                      style: const TextStyle(fontSize: 12, color: Colors.white),),
                    )
                  ),
                ),
     leading: CircleAvatar(
  backgroundImage:  NetworkImage(order[i].image), // No matter how big it is, it won't overflow
),
     
    )
      ],
    );
  }
}

class CustomerProfile extends StatelessWidget {
  final OrderModel? orderdet;
  const CustomerProfile({super.key, required this.orderdet});

  @override
  Widget build(BuildContext context) {
    final customerdet = Provider.of<UserData?>(context);

    return ListTile(
      
      title:Text((customerdet!=null)?"${customerdet.fn} ${customerdet.ln}":"..."),
      subtitle:Text((orderdet!=null)?"\n${orderdet?.loc} \n  \n +62 906 6581 632":"...") ,
     
    );
  }
}

class OrderInstruction extends StatelessWidget {
  final String index;
  final String status;
  final String orderderstatus;
  final String instruction;
  const OrderInstruction({super.key,required this.index, required this.instruction,required this.status,required this.orderderstatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color:(orderderstatus==status)? Color.fromRGBO(19,188,240,1):Colors.grey[400],
                                      borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                    child: Center(child: Text("${index}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color:Colors.white),))),
                                  SizedBox(width:10),
                                  Text("  ${instruction}",style: TextStyle(color: (orderderstatus==status)?Colors.black:Colors.grey[400],fontWeight: (orderderstatus==status)?FontWeight.bold:FontWeight.normal),),
                                ] 
                              ),
    );
  }
}