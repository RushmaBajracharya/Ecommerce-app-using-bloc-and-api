class ProductDataModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  late int quantity; //added as it is going to be initialized later
  //Rating? rating;

  ProductDataModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.quantity = 1,
  });

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    // Convert 'price' to double
    price = json['price'].toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    quantity = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    // if (this.rating != null) {
    //   data['rating'] = this.rating!.toJson();
    // }
    return data;
  }

  // Define copyWith method
  ProductDataModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    int? quantity,
  }) {
    return ProductDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}

// class Rating {
//   double? rate;
//   int? count;

//   Rating({this.rate, this.count});

//   Rating.fromJson(Map<String, dynamic> json) {
//     rate = json['rate'];
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rate'] = this.rate;
//     data['count'] = this.count;
//     return data;
//   }
// }
