
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetncolours/models/product.dart';
import 'package:sweetncolours/models/user.dart';
class DatabaseService
{
  final String? uid;
  final String? email;
  // ignore: non_constant_identifier_names
  String? cat_title;
  DatabaseService(this.uid,this. email,this.cat_title);

  //collection reference
  final CollectionReference accountDetails =FirebaseFirestore.instance.collection('acc');
  Future updateUserData(String fn, String ln,String profile,String accType) async{
    return await accountDetails.doc(uid).set({
      'fn':fn,
      'ln':ln,
      'profile':profile,
      'accType':accType,
    });
  }
//place order

final CollectionReference order =FirebaseFirestore.instance.collection('order');
Future placeOrder(String total,String location,String phone,String status,String uid,String datetime,double lat, double long) async{
   reflectOrder(datetime);
    return await order.doc(uid).collection("order").doc(uid+datetime).set({
      'time':datetime,
      'uid':uid,
      'loc':location,
      'total':total,
      'status':status,
      'latitude':lat,
      'longitude':long
    });
  }
  Future updateOrder(String status,String uid,String datetime) async{
   
    return await order.doc(uid).collection("order").doc(uid+datetime.toString()).update({
      'status':status
    });
  }
  
  //reflect orders to admin

final CollectionReference orders =FirebaseFirestore.instance.collection('ordertoadmin');
Future reflectOrder(String datetime) async{
   
    return await orders.doc().set({
      'customer_id':uid,
      'order_id':uid!+datetime,
      'status':"pending",
    });
  }
  
  Future addProductToOrder(String name, String price, String total, String qty, String uid,String datetime,String image) async{
   
    return await order.doc(uid).collection("order").doc(uid+datetime.toString()).collection("products").add({
      'name':name,
      'price':price,
      'total':total,
      'quantity':qty,
      'image':image,
    });
  }
 
//adding products to cart
final CollectionReference prodToCart =FirebaseFirestore.instance.collection('cart');
Future addProductToCartCollection(String name, String price,String image,String description,String quantity,String total) async{
    addProductToCart(name,price,image,description,quantity,total);
    return await prodToCart.doc(uid).set({
      'id':uid,
    });
  }
  Future addProductToCart(String name, String price,String image,String description,String quantity,String total) async{
    return await prodToCart.doc(uid).collection("cart").add(
      {
      'name':name,
      'price':price,
      'image':image,
      'description':description,
      'quantity':quantity,
      'total':total,
    });
  }
  Future removeProductfromCart(String id) async{
    return await prodToCart.doc(uid).collection("cart").doc(id).delete();
  }
  

  //add products to database
  final CollectionReference prodDetails =FirebaseFirestore.instance.collection('products');
  
  
  //get accounts stream
  Stream<UserData?> get userData
  {
      return accountDetails.doc(uid).snapshots().map(_userDataFromSnapshot);  
  }
  //
  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    
    return UserData(uid, snapshot.get("fn"), snapshot.get("ln"), snapshot.get("profile"),email,snapshot.get("accType"));
  }
  List<CategoryModel> _categoryListFromSnapShot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return CategoryModel(doc.get('title'));
    }).toList();
  }
  //get category stream
  final CollectionReference prodCategory =FirebaseFirestore.instance.collection('category');
  Stream<List<CategoryModel>> get getCategory{
    return prodCategory.snapshots().map(_categoryListFromSnapShot);
  }
  //product list from snapshot
  List<Products> _productListFromSnapShot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      
      return Products(doc.get('name'),doc.get('price'),doc.get('description'),doc.get('details'),doc.get('image'),"","","");
    }).toList();
  }
 
  //get prod stream
  Stream<List<Products>> get getProducts{
    return prodDetails.where('categories',arrayContains: "$cat_title").snapshots().map(_productListFromSnapShot);
  }
  List<Products> _productListFromCategorySnapShot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      
      return Products(doc.get('name'),doc.get('price'),doc.get('description'),"",doc.get('image'),doc.get('quantity'),doc.get('total'),doc.id);
    }).toList();
  }
  List<OrderModel> _orderListFromCartSnapShot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      
      return OrderModel(doc.id,doc.get('loc'),doc.get('status'),doc.get('time'),doc.get('total'));
    }).toList();
  }
 
  //get prod stream
  Stream<List<Products>> get getProductsFromCart{
    return prodToCart.doc(uid).collection("cart").snapshots().map(_productListFromCategorySnapShot);
  }
  //get order stream
  
  Stream<List<OrderModel>> get getOrders{
    return order.doc(uid).collection("order").snapshots().map(_orderListFromCartSnapShot);
  }
  

}

class FetchOrderFromCustomer
{
  final String? uid;
  final String? orderId;
  FetchOrderFromCustomer(this.orderId,this.uid);
  final CollectionReference order =FirebaseFirestore.instance.collection('order');
    OrderModel? _orderListFromCartSnapShot(DocumentSnapshot snapshot)
  {
    
      return OrderModel(snapshot.get('time'),snapshot.get('total'),snapshot.get('loc'),snapshot.get('status'),snapshot.get('uid'));
  
  }
      //get order stream
  
  Stream<OrderModel?> get getOrders{
    return order.doc(uid).collection("order").doc(orderId).snapshots().map(_orderListFromCartSnapShot);
  }
  
 
  List<Orders> _OrderctListFromSnapShot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      
      return Orders(doc.get('customer_id'),doc.get('order_id'),doc.id);
    }).toList();
  }
    //get pendiing orders
    final CollectionReference orders =FirebaseFirestore.instance.collection('ordertoadmin');
    Stream<List<Orders>> get getOrdersFromCustomer{
        return orders.where("customer_id",isEqualTo:uid).snapshots().map(_OrderctListFromSnapShot);
      }
  
 List<OrderedProducts> _pendingOrderItemtListFromSnapShot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      //this.name,this.price,this.description,this.details,this.image,this.qty
      return OrderedProducts(doc.get("name"),doc.get("price"),doc.get("image"),doc.get("quantity"));
    }).toList();
  }
    //get pendiing orders

    Stream<List<OrderedProducts>> get getOrdersItem{
        return order.doc(uid).collection("order").doc(orderId).collection("products").snapshots().map(_pendingOrderItemtListFromSnapShot);
      }

      

       Future updateOrderStatus(String status) async
  {
    return order.doc(uid).collection("order").doc(orderId).update({'status':"$status"});
  }
  Future updateOrderStatusInAdmin(String status) async
  {
    return orders.doc(orderId).update({'status':"$status"});
  }
  
  
  
  
}
