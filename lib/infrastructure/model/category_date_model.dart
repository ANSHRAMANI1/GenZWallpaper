import 'dart:convert';

List<CategoryDataModel> categoryDataModelFromJson(String str) => List<CategoryDataModel>.from(json.decode(str).map((x) => CategoryDataModel.fromJson(x)));

String categoryDataModelToJson(List<CategoryDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryDataModel {
  String? category;
  String? image;
  int? trending;

  CategoryDataModel({
    this.category,
    this.image,
    this.trending,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
    category: json["category"],
    image: json["image"],
    trending: json["trending"],
  );

  factory CategoryDataModel.fromSheets(List<String> json) => CategoryDataModel(
    category: json[0],
    image: json[1],
    trending: int.parse(json[2]),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "image": image,
    "trending": trending,
  };
}
