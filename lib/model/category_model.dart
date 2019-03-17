class CategoryModel {
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.comments,
    this.image,
  });

  factory CategoryModel.formJson(dynamic json) {
    return CategoryModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
    );
  }
}

class CategoryListModel {
  List<CategoryModel> list;

  CategoryListModel(this.list);

  factory CategoryListModel.fromJson(List json) {
    return CategoryListModel(
      json.map((item) => CategoryModel.formJson(item)).toList(),
    );
  }
}
