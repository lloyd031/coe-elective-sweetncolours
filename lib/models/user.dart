class UserObj
{
  final String? email;
  final String? uid;
  UserObj(this.uid,this.email);
}
class UserData
{
  final String? uid;
  final String? email;
  final String? fn;
  final String? ln;
  final String? pic;
  final String? accType;
  UserData(this.uid, this.fn, this.ln,this.pic,this.email,this.accType);
  
}

class Rider
{
  final String? uid;
  final String? email;
  final String? fn;
  final String? ln;
  final String? pic;
  final String? accType;
  final double lat;
  final double long;
  Rider(this.uid, this.fn, this.ln,this.pic,this.email,this.accType,this.lat, this.long);
  
}