import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';

class OrderList extends StatefulWidget {
final OrderModel? orderModel;
OrderList(this.orderModel);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    bool  isChecked=false;
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
              children:[
                  Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    width: 160,
                    child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey[900]),
                        text: "${widget.orderModel?.time}"),
                                  ),
                  ),
                  SizedBox(width:10),
                  Text("P ${widget.orderModel?.total}",style: TextStyle(color:Color.fromRGBO(215,15,100, 1), fontSize: 12)),
                  SizedBox(width:6),
                  Text("status : ${widget.orderModel?.status}",style: TextStyle(color:Colors.grey[900], fontSize: 12, )),
                   SizedBox(width:6),
                  Text("time: ${widget.orderModel?.time}",style: TextStyle(color:Colors.grey[900], fontSize: 12, )),
                  
                ]
                
              ),]
            ),
              
              
          ]
        )
    );
  
  }
}