import 'package:flutter/material.dart';
import 'package:sweetncolours/services/auth.dart';
import 'package:sweetncolours/shared/loading.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  String email = '';
  String password = '';
  String cpassword = '';
  String fn='';
  String ln='';
  String pic='https://cdn-icons-png.flaticon.com/512/149/149071.png';
  String accType="user";
  String error=' ';
  @override
  Widget build(BuildContext context) {
    return loading? const Loading():Scaffold(
        backgroundColor: Colors.white,
        
        body: SizedBox(
          height: double.maxFinite,
          child:  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children:[
                  const SizedBox(height: 80,),
                    const Text("Sign Up", style: TextStyle(color:Color.fromRGBO(215,15,100, 1), fontSize: 20,),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50,vertical:10),
                    child: Form(
                    key: _formKey,
                      child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                          hintText:"Firstname",
                        ),
                        validator: (val){
                          if(val!.isEmpty)
                          {
                              return "Enter Firstname";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            fn = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                          hintText:"Lastname",
                        ),
                        validator: (val){
                          if(val!.isEmpty)
                          {
                              return "Enter Lastname";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            ln = val;
                          });
                        },
                      ),
                     
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                          hintText:"Email",
                        ),
                        validator: (val){
                          if(val!.isEmpty)
                          {
                              return "enter email";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                          hintText:"Password",
                        ),
                        obscureText: true,
                        validator: (String? val){
                          RegExp regex =
                              RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if(val!.length<6 )
                              {
                                  return "atleast 6 characters ";
                              }else
                              {
                                  if (!regex.hasMatch(val)) {
                                    return 'please include capital letters, special characters, and numbers';
                                  } else {
                                    return null;
                                  }
                              }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                          hintText:"Confirm password",
                        ),
                        obscureText: true,
                        validator: (String? val){
                          if(val!=password)
                          {
                              return "password don't match";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            cpassword = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20,),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(onPressed: ()async{
                              if(_formKey.currentState!.validate())
                                {
                                  setState(() {
                                    loading=true;
                                  });
                                   dynamic result=await _auth.registerWithEmailAndPassword(email, password,fn,ln,pic,accType);
                                  if(result==null)
                                  {
                                    setState(() {
                                      error='invalid email or password';
                                      loading=false;
                                    });
                                  }
                                }
                          }, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(215,15,100, 1),),
                            padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
                            elevation: MaterialStateProperty.all(0.0),
                            
                          ),
                          child:const Text('Sign in'),
                          
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                          const SizedBox(height:20),
                          Text(
                            error,
                            style: const TextStyle(
                              color:Colors.red,
                              fontSize: 14,
                            ),
                          )
                    ],
                                )),
                  ),] 
              ),
            ),
        ));
  }
}
