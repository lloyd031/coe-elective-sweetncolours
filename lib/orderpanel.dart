import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/orderlist.dart';

class OrderPanel extends StatefulWidget {
  const OrderPanel({super.key});

  @override
  State<OrderPanel> createState() => _OrderPanelState();
}

class _OrderPanelState extends State<OrderPanel> {
  @override
  Widget build(BuildContext context) {
    
    final orders = Provider.of<List<OrderModel>?>(context);
    return GridView.builder(
      
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1, 
      crossAxisSpacing:12,
      mainAxisSpacing: 12,
      mainAxisExtent:73),
      itemCount: (orders==null)? 0: orders.length,
      itemBuilder: (_,index)
      {
        return OrderList(orders?[index]);
      }
      
    );
  
  }
}