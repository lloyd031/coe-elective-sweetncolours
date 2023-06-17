
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
import 'package:sweetncolours/orders.dart';
import 'package:sweetncolours/prod.dart';
import 'package:sweetncolours/proddetails.dart';
import 'package:sweetncolours/services/database.dart';
import 'package:sweetncolours/shared/loading.dart';
class MyHomePage extends StatefulWidget {
  bool isloggedin;
  bool showSignIn=false;
  bool showSignUp=false;
  MyHomePage(this.isloggedin);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  
  String? cat_title="All";
  String? selectedCAtegory="All";
  String? prod_name;
  String? prod_image;
  String? prod_price;
  String? prod_description;
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
  bool showProductDetails=false;
  bool showCart=false;
  bool showOrders=false;
  void setCatTitle(String? cat)
  {
    print(cat);
    setState(() {
      this.cat_title=cat;
      this.selectedCAtegory=cat;
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
      if(showProductDetails==true)
      {
        return SafeArea(child: ProdDetails("$prod_image","$prod_name","$prod_price","$prod_description","$prod_details"));
      }else if(showCart==true)
      {
        return StreamProvider<List<Products>?>.value(
                          value:DatabaseService(user?.uid,user?.email,null).getProductsFromCart,
                          initialData: null,
                          child:Cart());
      }else if(showOrders==true)
      {
        return StreamProvider<List<OrderModel>?>.value(
                          value:DatabaseService(user?.uid,user?.email,null).getOrders,
                          initialData: null,
                          child:Orders());
      }
      else{
        return Loading();
      }
       
    });
  }
  void showProductDetailsPanel()
  {
    setState(() {
      showProductDetails=true;
      showCart=false;
      showOrders=false;
      showBottomSheet ();
    });
  }
  void showCartPanel()
  {
    setState(() {
      showProductDetails=false;
      showCart=true;
      showOrders=false;
      showBottomSheet ();
    });
  }
  void showOrdersPanel()
  {
    setState(() {
      showProductDetails=false;
      showOrders=true;
      showCart=false;
      showBottomSheet ();
    });
  }
    return Scaffold(
      //Color.fromRGBO(215,15,100, 1)
      backgroundColor: Colors.white,
      drawer:(widget.isloggedin==false)?MyDrawerGuest(showSignIn: showSignInPanel,showSignUp: showSignUpPanel):MyDrawer(showCartPanel,showOrdersPanel),
     
      appBar:  AppBar(
        leading: Builder( builder: (BuildContext context) { return IconButton(
          onPressed:(){Scaffold.of(context).openDrawer();}, 
          icon: Icon(Icons.menu,color: Color.fromRGBO(215,15,100, 1),size: 20,)); }),
      elevation: 0,
      backgroundColor:Colors.white,
      actions: <Widget>[
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag, color:Color.fromRGBO(215,15,100, 1),size: 18,)),
      ],
      ),
      body:widget.showSignIn? SignIn(): widget.showSignUp? Register():SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SizedBox(height: 10,),
          SizedBox(height: 15,),
              StreamProvider<List<CategoryModel>?>.value(
                  value:DatabaseService(user?.uid, user?.email,null).getCategory,
                  initialData: null,
                  child:Category(setCatTitle,selectedCAtegory)),
          SizedBox(height:3,),
          Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,20),
                child: StreamProvider<List<Products>?>.value(
                  value:DatabaseService(user?.uid,user?.email,cat_title).getProducts,
                  initialData: null,
                  child: ProdGrid(showProductDetailsPanel,getProductDetails,false,(){}))),
        ],),
      )
      
    );
  }
}