
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/productlist.dart';
import 'package:sweetncolours/producttile.dart';

class ProdGrid extends StatefulWidget {
 Function showProductDetailsPanel;
 Function getProductDetails;
 Function addorremoveProductToList;
 bool isCart;
 ProdGrid(this.showProductDetailsPanel,this.getProductDetails,this.isCart,this.addorremoveProductToList);
   
  State<ProdGrid> createState() => _ProdGridState();
}

class _ProdGridState extends State<ProdGrid> {
  
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Products>?>(context);
    return GridView.builder(
      
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (widget.isCart==true)?1:2, 
      crossAxisSpacing:12,
      mainAxisSpacing: 12,
      mainAxisExtent:(widget.isCart==true)?70:214,),
      itemCount: (products==null)? 0: products.length,
      itemBuilder: (_,index)
      {
        return (widget.isCart==true)?ProductList(products?[index],widget.showProductDetailsPanel,widget.getProductDetails,widget.addorremoveProductToList,index):ProductTile(products?[index],widget.showProductDetailsPanel,widget.getProductDetails);
      }
      
    );
  }
}