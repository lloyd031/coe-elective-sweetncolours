import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetncolours/models/user.dart';
import 'package:sweetncolours/services/database.dart';
 

class AuthService
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //create user object based on firebase user
  UserObj? _UserFromFirebase(User? user)
  {
    
    return user!=null?UserObj(user.uid,user.email):null;
  }
  //auth changed user stream 
  Stream<UserObj?> get user{
    return _auth.authStateChanges().map(_UserFromFirebase);
  }
  // signin anonymously
  Future signinAnon() async
  {
    try
    {
      UserCredential result = await _auth.signInAnonymously();
      User? user=result.user;
      return _UserFromFirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async
   {
      try{
          UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
          User? user=result.user;
          return _UserFromFirebase(user);
      }catch(e)
      {
          print(e.toString());
          return null;
      }
   }
   //signup with email and password
   Future registerWithEmailAndPassword(String email, String password,String fn, String ln, String profile, String accType) async
   {
      try{
          UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          User? user=result.user;
          //create a document for the user with uid in firebase
          await DatabaseService(user?.uid,user?.email,null).updateUserData(fn, ln, profile,accType);
          return _UserFromFirebase(user);
      }catch(e)
      {
          print(e.toString());
          return null;
      }
   }
  //signout
  Future signOut() async
  { 
    try
    {
        return await _auth.signOut();
    }catch(e)
    {
        print(e.toString());
        return null;
    }
  }

}