import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/services/database.dart';
class ProductList extends StatefulWidget {
  final Products? prod;
  Function getProductDetails;
  Function showProductDetailsPanel;
  Function addorremoveProductToList;
  int index;
  ProductList(this.prod,this.showProductDetailsPanel,this.getProductDetails,this.addorremoveProductToList,this.index);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool  isChecked=false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObj?>(context);
    return Container(
      decoration:BoxDecoration(color:Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3)),
        boxShadow:const [
                BoxShadow(
                    offset: Offset(3, 3),
                    spreadRadius: -3,
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                ),
            ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Row(
              children:[ClipRRect(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(3.0),topRight: Radius.circular(3.0) ),
                child: Image.network("${widget.prod?.image}",
                height:70,
                width: 70,
                fit:BoxFit.cover,)),
              SizedBox(width:10),
              
                  Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    width: 150,
                    child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey[900]),
                        text: "${widget.prod?.name}"),
                                  ),
                  ),
                  SizedBox(width:10),
                  Text("P ${widget.prod?.price}",style: TextStyle(color:Color.fromRGBO(215,15,100, 1), fontSize: 12)),
                  SizedBox(width:6),
                  Text("quantity : ${widget.prod?.quantity}",style: TextStyle(color:Colors.grey[900], fontSize: 12, )),
                   SizedBox(width:6),
                  Text("total ${widget.prod?.total}",style: TextStyle(color:Colors.grey[900], fontSize: 12, )),
                  
                ]
                
              ),]
            ),
              Row(
                children:[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed:(){
                      DatabaseService(user?.uid,user?.email,null).removeProductfromCart("${widget.prod?.id}");
                    },icon:Icon(Icons.delete, color:Colors.grey[800])),
                    Container(height: 70,width: 70, color: Color.fromRGBO(215,15,100, 1),child: Center(child: Checkbox(value: isChecked,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))), side: BorderSide(width: 1.5,color:Colors.white),tristate: true,activeColor: Colors.white, checkColor: Color.fromRGBO(215,15,100, 1), onChanged: (bool? e){setState(() {
                      isChecked=!isChecked;
                      if(isChecked==false)
                      {
                          widget.addorremoveProductToList(widget.prod,false);
                      }else
                      {
                        widget.addorremoveProductToList(widget.prod,true);
                      }
                      
                    });})/*TextButton(onPressed: (){},child: Text("check \n  out", style:TextStyle(color:Colors.white)),)*/)),
                    
                  ],
                ),
                ]
              ),
              
          ]
        )
    );
  }
}