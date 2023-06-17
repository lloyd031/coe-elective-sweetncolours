import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
class ProductTile extends StatelessWidget {
  
  final Products? prod;
  Function getProductDetails;
  Function showProductDetailsPanel;
  ProductTile(this.prod,this.showProductDetailsPanel,this.getProductDetails);
  
  @override
  Widget build(BuildContext context) {
    bool loading=false;
    final user = Provider.of<UserObj?>(context);
    return  InkWell(
      onTap: ()async{showProductDetailsPanel();getProductDetails(prod?.image,prod?.name,prod?.price,prod?.description,prod?.details);},
      child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              boxShadow: [
                  BoxShadow(
                      offset: Offset(3, 3),
                      spreadRadius: -3,
                      blurRadius: 6,
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                  ),
              ],
              color: Colors.white,
              ),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(3.0),topRight: Radius.circular(3.0) ),
                  child: Image.network("${prod?.image}",
                  height:130,
                  width: double.infinity,
                  fit:BoxFit.cover,)),
                Padding(
                  padding:EdgeInsets.fromLTRB(8, 8, 8, 0),
                   child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      
                    const SizedBox(height:6),
                     RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey[900]),
                        text: "${prod?.name}"),
                  ),
                
                    //Text("${prod?.name}",style: TextStyle(color: Colors.grey[900]),),
                    const SizedBox(height:6),
                    Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("₱ ${prod?.price}", style: TextStyle(color:Color.fromRGBO(215,15,100, 1)),),
                         IconButton(onPressed: (){}, icon:Icon(Icons.star, color:Colors.yellow[900],size: 18, ),),
                         
                      ],
                    )
                    
                    
                   ])
                ),
                
              ],
            ),
          ),
    );;
  }
}