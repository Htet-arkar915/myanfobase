class CategoryModel {
  CategoryModel({
      this.id, 
      this.catename, 
      this.v,});

  CategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    catename = json['catename'];
    v = json['__v'];
  }
  int? id;
  String? catename;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['catename'] = catename;
    map['__v'] = v;
    return map;
  }

}