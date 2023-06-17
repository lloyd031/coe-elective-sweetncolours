import 'package:flutter/material.dart';
import 'package:sweetncolours/services/auth.dart';
import 'package:sweetncolours/shared/loading.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  String error=' ';
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return loading? const Loading() : Scaffold(
      backgroundColor:Colors.white,
      
      body: SizedBox(
          height:double.maxFinite,
          child:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    const Text("Sign In", style: TextStyle(color:Color.fromRGBO(215,15,100, 1), fontSize: 20,),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50,vertical:10),
                      child: Form(
                      key: _formKey,
                      child:Column(children: <Widget>[
                        const SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                            hintText: "Email",
                          ),
                          onChanged:(val){
                            setState(() {
                              email=val;
                            });
                          },
                          validator: (val){
                            if(val!.isEmpty)
                            {
                                return "enter email";
                            }
                            return null;
                          },
                          
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.grey[50],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                            hintText: "Password",
                          ),
                          obscureText: true,
                          onChanged:(val){
                            setState(() {
                              password=val;
                            });
                          },
                          validator: (val){
                            if(val!.isEmpty)
                            {
                                return "enter password";
                            }
                            return null;
                          },
                          
                        ),
                        const SizedBox(height: 20,),
                        
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(onPressed: ()async{
                              if(_formKey.currentState!.validate())
                                {
                                  setState(() {
                                    loading=true;
                                  });
                                  dynamic result=await _auth.signInWithEmailAndPassword(email, password);
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
                        const SizedBox(height:20),
                            Text(
                              error,
                              style: const TextStyle(
                                color:Colors.red,
                                fontSize: 14,
                              ),
                            )
                      ],)
                                    ),
                    )],
                ),
              ),
            
          
        )
    );
  }
}