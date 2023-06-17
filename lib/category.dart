import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/categorylist.dart';
import 'package:sweetncolours/models/product.dart';

// ignore: must_be_immutable
class Category extends StatefulWidget {
  Function setCatTitle;
  String? selectedCAtegory;
   Category(this.setCatTitle(String title),this.selectedCAtegory, {super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<CategoryModel>?>(context);
    return Padding(
      
                padding: const EdgeInsets.fromLTRB(20,10,20,10),
                child: Row(
                  
                  children:[
                    Padding(padding: const EdgeInsets.fromLTRB(0,12,3,10),child: Text("CATEGORIES    ",style: TextStyle(color:Colors.grey[850],fontWeight:FontWeight.bold),)),
                    Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           TextButton(onPressed: (){ widget.setCatTitle("All");},child:Text("All" , style: TextStyle(color:(widget.selectedCAtegory=="All")?const Color.fromRGBO(215,15,100, 1):Colors.grey[850]))),
                        SizedBox(
                          
                          height:50,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,

                            scrollDirection: Axis.horizontal,
                            itemCount: (categories!=null)?categories.length:0,
                            itemBuilder: (_,index)
                            {
                              if(categories!=null)
                              {
                                return CategoryList(categories[index],widget.setCatTitle,widget.selectedCAtegory);
                              }
                              return null;
                            },
                          ),
                        ),
                        
                      ]),
                    ),
                  )] 
                ),
              );
  }
}