class Cart {
  int cartId;
  int userId;
  int shopId;
  String productName;
  int productPrice;
  int quantity;
  String image;
  String breed;

  Cart(
      {this.cartId,
      this.userId,
      this.shopId,
      this.productName,
      this.productPrice,
      this.quantity,
      this.image,
      this.breed});

  Cart.fromJson(dynamic json) {
    cartId = json['id'];
    userId = json['users_id'];
    shopId = json['shop_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    image = json['product_img'];
    breed = json['breed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.cartId;
    data['users_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['quantity'] = this.quantity;
    data['product_img'] = this.image;
    data['breed'] = this.breed;
    return data;
  }
}
