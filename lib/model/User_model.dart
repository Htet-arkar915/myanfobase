
class UserModel {
  UserModel({
      this.id, 
      this.username, 
      this.email, 
      this.password, 
      this.verified, 
      this.login, 
      this.isAdmin, 
      this.dob, 
      this.gender, 
      this.address, 
      this.bio, 
      this.profilePicture, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    verified = json['verified'];
    login = json['login'];
    isAdmin = json['isAdmin'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    bio = json['bio'];
    profilePicture = json['profilePicture'];
    /*if (json['profilePicture'] != null) {
      profilePicture = [];
      *//*json['profilePicture'].forEach((i) {
        profilePicture?.add(ProfilePicture.fromJson(i));
      });*//*
      profilePicture?.add(jsonDecode(json['profilePicture'].toString()[0]));
      *//*for(Map<String, dynamic> p in )){
        profilePicture?.add(ProfilePicture.fromJson(p));
      }*//*
    }*/

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? username;
  String? email;
  String? password;
  bool? verified;
  bool? login;
  bool? isAdmin;
  String? dob;
  String? gender;
  String? address;
  String? bio;
  dynamic profilePicture;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['verified'] = verified;
    map['login'] = login;
    map['isAdmin'] = isAdmin;
    map['dob'] = dob;
    map['gender'] = gender;
    map['address'] = address;
    map['bio'] = bio;
    /*if (profilePicture != null) {
      map['profilePicture'] = profilePicture?.map((i) => i?.toJson()).toList();
    }*/
    map['profilePicture'] = profilePicture;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}