
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/authenticate/register.dart';
import 'package:sweetncolours/authenticate/signin.dart';
import 'package:sweetncolours/cart.dart';
import 'package:sweetncolours/category.dart';
import 'package:sweetncolours/drawer%20guest.dart';
import 'package:sweetncolours/drawer.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/prod.dart';
import 'package:sweetncolours/proddetails.dart';
import 'package:sweetncolours/services/database.dart';
import 'package:sweetncolours/shared/loading.dart';

import '../loc.dart';
import '../orderdetails.dart';
import '../orders.dart';
import '../slider.dart';
// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  bool isloggedin;
  bool showSignIn=false;
  bool showSignUp=false;
  MyHomePage(this.isloggedin, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  
  // ignore: non_constant_identifier_names
  String? cat_title="All";
  String? selectedCAtegory="All";
  // ignore: non_constant_identifier_names
  String? prod_name;
  // ignore: non_constant_identifier_names
  String? prod_image;
  // ignore: non_constant_identifier_names
  String? prod_price;
  // ignore: non_constant_identifier_names
  String? prod_description;
  // ignore: non_constant_identifier_names
  String? prod_details;
  
  void getProductDetails(String img, String name, String price,String description,String details)
  {
    setState(() {
      prod_image=img;
      prod_name=name;
      prod_price=price;
      prod_description=description;
      prod_details=details;
    });
  }
  
  bool showCart=false;
  bool showOrders=false;
  void setCatTitle(String? cat)
  {
    
    setState(() {
      cat_title=cat;
      selectedCAtegory=cat;
    });
  }
  void showSignInPanel()
  {
    setState(() {
      widget.showSignIn=true;
    widget.showSignUp=false;
    });
    
  }
  void showSignUpPanel()
  {
    setState(() {
      widget.showSignIn=false;
    widget.showSignUp=true;
    });
    
  }
  OrderModel? orderdet;
  void getOrderDet(OrderModel orderdet)
  {
    setState(() {
      this.orderdet=orderdet;
    });
  }
  // cart,order,productdet,orderdet,signout,rider location 
List<bool> widgets=[false,false,false,false,false,false];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObj?>(context);

    void showBottomSheet ()
  {
     showModalBottomSheet(context: context,
     useSafeArea: true,
     isScrollControlled: true,
     builder: (context)
    {
      if(widgets[2]==true)
      {
        return SafeArea(child: ProdDetails("$prod_image","$prod_name","$prod_price","$prod_description","$prod_details"));
      }else if(widgets[0]==true)
      {
        return StreamProvider<List<Products>?>.value(
                          value:DatabaseService(user?.uid,user?.email,null).getProductsFromCart,
                          initialData: null,
                          child:Cart());
      }
      else{
        return const Loading();
      }
       
    });
  }
  
  void showWidgets(int index)
{
    widgets[index]=true;
    if(index<3 && index!=1)
    {
      setState(() {
        showBottomSheet();
      });
    }
    for(int i=0; i<widgets.length; i++)
    {
        if(i!=index)
        {
          setState(() {
            widgets[i]=false;
          });
        }
    {

    }
    }
    
}
  
  
  
    return Scaffold(
      //Color.fromRGBO(215,15,100, 1)
      backgroundColor: Colors.white,
      drawer:(widget.isloggedin==false)?MyDrawerGuest(showSignIn: showSignInPanel,showSignUp: showSignUpPanel):MyDrawer(showWidgets),
     
      appBar:  AppBar(
        leading: Builder( builder: (BuildContext context) { return IconButton(
          onPressed:(){Scaffold.of(context).openDrawer();}, 
          icon: Icon(Icons.menu,color: Color.fromRGBO(215,15,100, 1),size: 20,)); }),
      elevation: 0,
      backgroundColor:Colors.white,
      actions: <Widget>[
        IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_bag, color:Color.fromRGBO(215,15,100, 1),size: 18,)),
      ],
      ),
      body:(widgets[5]==true)?StreamProvider<Rider?>.value(
                      value:DatabaseService(user?.uid, user?.email,"").riderData,
                      initialData: null,
                      child:const RiderLocationMap()):(widgets[3]==true)?OrderDetails(orderdet:orderdet,showWidgets:showWidgets) : widget.showSignIn? const SignIn(): widget.showSignUp? const Register():SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:(widgets[1]==true)?StreamProvider<List<Orders>?>.value(
                  value:FetchOrderFromCustomer(null,null).getOrdersFromCustomer,
                  initialData: null,
                  child: OrdersPanel(showPanel: showWidgets,getOrderDet:getOrderDet)): Column(children: [
          MySlider(),
          const SizedBox(height: 15,),
              StreamProvider<List<CategoryModel>?>.value(
                  value:DatabaseService(user?.uid, user?.email,null).getCategory,
                  initialData: null,
                  child:Category(setCatTitle,selectedCAtegory)),
          const SizedBox(height:3,),
          Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,20),
                child: StreamProvider<List<Products>?>.value(
                  value:DatabaseService(user?.uid,user?.email,cat_title).getProducts,
                  initialData: null,
                  child: ProdGrid(showWidgets,getProductDetails,false,(){}))),
        ],),
      )
      
    );
  }
}