class CategoriesModel {
  final String categoryId;
  final String categoryImg;
  final String categoryName;
  final dynamic createdOn;
  final dynamic updatedOn;

  CategoriesModel(
      {required this.categoryId,
      required this.categoryImg,
      required this.categoryName,
      required this.createdOn,
      required this.updatedOn});

  //serialize the user model instance to a jsnon map
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImg': categoryImg,
      'categoryName': categoryName,
      'createdOn': createdOn,
      'updateOn': updatedOn
    
    };
  }

  //created the a model instance from a jsnon map
  factory CategoriesModel.fromMap(Map<String, dynamic> json) {
    return CategoriesModel(
        categoryId: json['categoryId'],
        categoryImg: json['categoryImg'],
        categoryName: json['categoryName'],
        createdOn: json['createdOn'],
        updatedOn: json['updatedOn']);
  }
}
