import 'Files.dart';

class PostModel {
  PostModel({
      this.id, 
      this.user, 
      this.username, 
      this.userprofile, 
      this.cateId, 
      this.title, 
      this.description, 
      this.cateName, 
      this.timeCreated, 
      this.postAccept, 
      this.files, 
      this.viewcount, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  PostModel.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    username = json['username'];
    userprofile = json['userprofile'];
    cateId = json['cateId'];
    title = json['title'];
    description = json['description'];
    cateName = json['cateName'];
    timeCreated = json['timeCreated'];
    postAccept = json['postAccept'];
    files =json['files'];
    viewcount = json['viewcount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? user;
  String? username;
  String? userprofile;
  String? cateId;
  String? title;
  String? description;
  String? cateName;
  String? timeCreated;
  bool? postAccept;
  dynamic files;
  dynamic viewcount;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    map['username'] = username;
    map['userprofile'] = userprofile;
    map['cateId'] = cateId;
    map['title'] = title;
    map['description'] = description;
    map['cateName'] = cateName;
    map['timeCreated'] = timeCreated;
    map['postAccept'] = postAccept;
    map['files'] = files;
    map['viewcount'] = viewcount;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}