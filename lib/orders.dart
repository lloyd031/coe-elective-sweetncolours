import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
//import 'package:sweetncolours/ordercount.dart';
import 'package:sweetncolours/services/database.dart';

class OrdersPanel extends StatefulWidget {
  final Function getOrderDet;
   final Function showPanel;
  const OrdersPanel({super.key, required this.showPanel, required this.getOrderDet});

  @override
  State<OrdersPanel> createState() => _OrdersPanelState();
}

class _OrdersPanelState extends State<OrdersPanel> {
   List<OrderModel?> ordercount=[];
  @override
  Widget build(BuildContext context) {
   final order = Provider.of<List<Orders>?>(context);
    return Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              
              const SizedBox(height:8,),
                  
                      const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("ORDER LIST",style:TextStyle(color:Color.fromRGBO(30,30,50,1),fontSize: 16,fontWeight:FontWeight.bold)),
                        SizedBox(width: 24,),
                        
                      ]
                    ),
                Container(
                  child:(order==null)?const Text(""):Column(
                    children: [
                      for(int i=0; i<order.length; i++)
                      StreamProvider<OrderModel?>.value(
                                value:FetchOrderFromCustomer(order[i].orderId,order[i].customerId).getOrders,
                                initialData: null,
                                child:OrderTile(orderdoc:order[i],showPanel:widget.showPanel,getOrderDet:widget.getOrderDet),),
                  
                    ],
                  ),
                ),
                
              
            ],
          ),
        ),
      ],
    );
  }
    
  }
  class OrderTile extends StatefulWidget {
    final Orders? orderdoc;
    final Function getOrderDet;
  final Function showPanel;
  const OrderTile({super.key,required this.orderdoc, required this.showPanel, required this.getOrderDet});
 
  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  
  Widget build(BuildContext context) {
    final order= Provider.of<OrderModel?>(context);
    return   InkWell(
      onDoubleTap: ()async{
        widget.getOrderDet(order);
        widget.showPanel(3);
      },
      child: SizedBox(
            width:double.maxFinite,
            child: Column(
              mainAxisSize:MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top:Radius.circular(8)),
                  gradient:LinearGradient(
                    begin: Alignment.bottomLeft,
                    end:Alignment.topRight,
                    colors:[Color.fromRGBO(132,90,254,1),
                Color.fromRGBO(174,46,255,1),],
                  ),
                
                ),
                  
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      StreamProvider<UserData?>.value(
                      value:DatabaseService(order?.id, null,"").userData,
                      initialData: null,
                      child:const CustomerModel())
                      ,
                       Row(
                        children: [
                          
                            const SizedBox(
                                width: 8,
                              ),
                          Text("${order?.time}",style:const TextStyle(color:Color.fromRGBO(239,201,255,1),) ,),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.vertical(bottom:Radius.circular(8)),
                  ),
                  padding:const EdgeInsets.all(8),
                  child:  Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Text("Total",style:TextStyle(color:Color.fromARGB(224, 27, 26, 26),fontSize: 12)),
                            
                            Text((order!=null)?"₱ ${double.parse("${order.total}").toStringAsFixed(2)}":"" ,style: const TextStyle(fontWeight: FontWeight.bold),),
                             
                          ]
                        ),
                        /*const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Text("Location",style:TextStyle(color:Color.fromARGB(224, 27, 26, 26),fontSize: 12)),
                            
                            StreamProvider<OrderModel?>.value(
                            value:FetchOrderFromCustomer(widget.order?.orderId,widget.order?.customerId).getOrders,
                            initialData: null,
                            child:const OrderModelValue(val:"loc")),
                             
                          ]
                        ),*/
                        const Divider(),
                      StreamProvider<List<OrderedProducts>?>.value(
                      value:FetchOrderFromCustomer("${order?.id}${order?.time}",order?.id).getOrdersItem,
                      initialData: null,
                      child: const OrderedItemTiles()),
                      
                      ],
                    ),
                  
                ),
              ],
            ),
          ),
    );
    
  }
}
class OrderedItemTiles extends StatefulWidget {
  const OrderedItemTiles({super.key});

  @override
  State<OrderedItemTiles> createState() => _OrderedItemTilesState();
}

class _OrderedItemTilesState extends State<OrderedItemTiles> {
  @override
  Widget build(BuildContext context) {
    final order= Provider.of<List<OrderedProducts>?>(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1, 
      crossAxisSpacing:12,
      mainAxisSpacing: 12,
      mainAxisExtent:25,),
      itemCount: (order==null)? 0: order.length,
      itemBuilder: (_,index)
      {
        return OrderedProductTile(op:order?[index]);
      }
      
    );
  }
}
class OrderedProductTile extends StatelessWidget {
  final OrderedProducts? op;
  const OrderedProductTile({super.key, required this.op});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${op?.qty} x"),
        const SizedBox(width:10),
        ClipRRect(
              borderRadius: const BorderRadius.only(topLeft:Radius.circular(3.0),topRight: Radius.circular(3.0) ),
              child: Image.network("${op?.image}",
              height:25,
              width: 25,
              fit:BoxFit.cover,)),
        const SizedBox(width:10),
        Text(op!.name),
      ],
    );
  }
}

class CustomerModel extends StatelessWidget {
  const CustomerModel({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<UserData?>(context);
    return Text("${(customer!=null)?"${customer.fn} ${customer.ln}":""} ",style:const TextStyle(color:Colors.white,fontSize: 12,));
  }
}

