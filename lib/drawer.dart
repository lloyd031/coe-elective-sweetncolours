import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/services/auth.dart';
import 'package:sweetncolours/services/database.dart';
import 'package:sweetncolours/shared/loading.dart';


final AuthService _auth=AuthService();
// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
Function showCartPanel;
Function showOrderPanel;
  MyDrawer(this.showCartPanel,this.showOrderPanel, {super.key});
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObj?>(context);
    return StreamBuilder<UserData?>(
      stream: DatabaseService(user?.uid,user?.email,null).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          UserData? userData=snapshot.data;
           String? fn=userData!.fn;
           String? ln=userData.ln;
           String? pic=userData.pic;
           String? email=userData.email;
           
            return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text('$fn $ln'), accountEmail: Text('$email'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network('$pic',
                      width: 90,
                      height:90,
                      fit:BoxFit.cover),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color:Color.fromRGBO(215,15,100, 1),
                    image: DecorationImage(image: NetworkImage('https://images.pexels.com/photos/323311/pexels-photo-323311.jpeg?auto=compress&cs=tinysrgb&w=400'
                    ),
                    fit:BoxFit.cover,
                    ),
                  ),
                  ),
              ListTile(
                leading:const Icon(Icons.person),
                title:const Text('My Profile'),
                onTap: (){},
              ),
              ListTile(
                leading:const Icon(Icons.shopping_cart),
                title:const Text('My Cart'),
                onTap: (){showCartPanel();},
              ),
              ListTile(
                leading:const Icon(Icons.shopping_bag),
                title:const Text('My Oders'),
                onTap: (){
                  showOrderPanel();
                },
              ),
              const Divider(),
              ListTile(
                leading:const Icon(Icons.star),
                title:const Text('Rate App'),
                onTap: (){},
              ),
              ListTile(
                leading:const Icon(Icons.share),
                title:const Text('Share'),
                onTap: (){},
              ),
              const Divider(),
              ListTile(
                leading:const Icon(Icons.notifications),
                title:const Text('Notifications'),
                onTap: (){},
                trailing: ClipOval(
                  child: Container(
                    color:Colors.red,
                    width:20,
                    height:20,
                    child:const Center(
                      child: Text('6',
                      style: TextStyle(fontSize: 12, color: Colors.white),),
                    )
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading:const Icon(Icons.exit_to_app),
                title:const Text('Signout'),
                onTap: ()async{
                 await _auth.signOut();
                },
              ),
            ],
          ),
          
        );
        
        }else{
          
          return const Loading();
        }
        
      }
    );
  }
}
