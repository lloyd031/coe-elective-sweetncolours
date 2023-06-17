import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/orderpanel.dart';
import 'package:sweetncolours/services/database.dart';
class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  
    int h=10;
    bool showConfirmLocation=false;
    List<Products> prodtocheckout=List.empty(growable: true);
    
    void addCurrentLocation()
    {
      setState(() {
        showConfirmLocation=true;
      });
    }
    void placeOrder(List<Products> p)
    {
      if(p.isNotEmpty)
      {
        prodtocheckout=p;
        addCurrentLocation();
      }
    }
    
    void addorremoveProductToList(Products p,bool add)
    {
      if(add==true)
      {
        prodtocheckout.add(p);
      }else 
      {
        prodtocheckout.remove(p);
      }
    }
    
  @override
  Widget build(BuildContext context) {
    
    final orders = Provider.of<List<OrderModel>?>(context);
    final user = Provider.of<UserObj?>(context);
    return  Padding(
      padding:const EdgeInsets.all(6),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const SizedBox(height: 15,),
          Text("Orders", style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Colors.grey[900])),
          const SizedBox(height: 15,),
          Container(
            color:Colors.white,
            height:300,
            child: (orders!=null && orders.isEmpty)?const Center(child: Text("empty")):SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StreamProvider<List<OrderModel>?>.value(
                          value:DatabaseService(user?.uid,user?.email,null).getOrders,
                          initialData: null,
                          child:const OrderPanel()),
            ),
          ),
          Padding(
            padding:const EdgeInsets.only(top:6),
            child: SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(onPressed: (){
                            placeOrder(prodtocheckout);
                          }, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(215,15,100, 1),),
                            padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
                            elevation: MaterialStateProperty.all(0.0),
                            
                          ),

                          child:const Text('Check Out'),
                          
                          ),
                        ),
          )
        ] 
      ),
    );
  
  }
}