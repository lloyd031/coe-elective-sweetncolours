class Products{
  final String? name;
  final String? price;
  final String? description;
   final String? details;
  final String? image;
  final String? quantity;
  final String? total;
  final String? id;
  Products(this.name,this.price,this.description,this.details,this.image,this.quantity,this.total,this.id);
 
}
class OrderedProducts{
  final String name;
  final String price;
  final String image;
  final String qty;
 OrderedProducts(this.name,this.price,this.image,this.qty);
  
}
class CategoryModel{
  final String? title;
  CategoryModel(this.title);
}

class OrderModel{
  final String? id;
  final String? loc;
  final String? status;
  final String?  time;
  final String? total;
  OrderModel(this.time,this.total,this.loc,this.status,this.id);
}
class Orders
{
  final String? docId;
  final String? customerId;
  final String? orderId;
  Orders(this.customerId,this.orderId,this.docId);
}