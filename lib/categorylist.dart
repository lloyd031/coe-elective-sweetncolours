import 'package:flutter/material.dart';
import 'package:sweetncolours/models/product.dart';

// ignore: must_be_immutable
class CategoryList extends StatefulWidget {
  CategoryModel? cat;
  String? selectedCAtegory;
  Function setCatTitle;
  
  CategoryList(this.cat,this.setCatTitle,this.selectedCAtegory, {super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool isSelected =false;
  
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){ widget.setCatTitle(widget.cat?.title);},child:Text("${widget.cat?.title}" , style: TextStyle(color:(widget.cat?.title==widget.selectedCAtegory)?const Color.fromRGBO(215,15,100, 1):Colors.grey[850]),));
  }
}