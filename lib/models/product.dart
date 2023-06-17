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
  OrderModel(this.id,this.loc,this.status,this.time,this.total);
}


