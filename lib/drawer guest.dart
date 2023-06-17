// ignore: file_names
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MyDrawerGuest extends StatefulWidget {
  Function showSignIn,showSignUp;
  MyDrawerGuest({super.key, required this.showSignIn,required this.showSignUp});

  @override
  State<MyDrawerGuest> createState() => _MyDrawerGuestState();
}

class _MyDrawerGuestState extends State<MyDrawerGuest> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName: const Text('Sweetncolours'), accountEmail: const Text('sweetn@colours.co.ph'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network('https://cdn-icons-png.flaticon.com/512/149/149071.png',
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
                leading:const Icon(Icons.exit_to_app),
                title:const Text('Signup'),
                onTap: (){
                  widget.showSignUp();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:const Icon(Icons.exit_to_app),
                title:const Text('Login'),
                onTap: (){
                  widget.showSignIn();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          
        );
  }
}
