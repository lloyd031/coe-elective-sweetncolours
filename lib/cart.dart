import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/addlocation.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/prod.dart';
import 'package:sweetncolours/services/database.dart';

class Cart extends StatefulWidget {
 Cart();

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> { 
    int h=10;
    bool showConfirmLocation=false;
    List<Products> prodtocheckout=List.empty(growable: true);
    void setHeight()
    {
      setState(() {
        print("Sdf");
      });
      
    }
    void addCurrentLocation()
    {
      setState(() {
        showConfirmLocation=true;
      });
    }
    void placeOrder(List<Products> p)
    {
      if(!p.isEmpty)
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
      print(prodtocheckout);
    }
    
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Products>?>(context);
    final user = Provider.of<UserObj?>(context);
    return  (showConfirmLocation==true)?AddLocation(prodtocheckout):Padding(
      padding:EdgeInsets.all(6),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          SizedBox(height: 15,),
          Text("CART", style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Colors.grey[900])),
          SizedBox(height: 15,),
          Container(
            color:Colors.white,
            height:300,
            child: (products!=null && products.isEmpty)?Center(child: Text("empty")):SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StreamProvider<List<Products>?>.value(
                          value:DatabaseService(user?.uid,user?.email,null).getProductsFromCart,
                          initialData: null,
                          child: ProdGrid((){},(){},true,addorremoveProductToList,)),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top:6),
            child: SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(onPressed: (){
                            placeOrder(prodtocheckout);
                          }, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(215,15,100, 1),),
                            padding: MaterialStateProperty.all(EdgeInsets.only(top: 15, bottom: 15)),
                            elevation: MaterialStateProperty.all(0.0),
                            
                          ),

                          child:Text('Check Out'),
                          
                          ),
                        ),
          )
        ] 
      ),
    );
  }
}