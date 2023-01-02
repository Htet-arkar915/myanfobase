class UserData {
  UserData({
      this.id, 
      this.username, 
      this.email, 
      this.bio, 
      this.dob, 
      this.address, 
      this.gender, 
      this.profilePicture, 
      this.login, 
      this.verified, 
      this.isAdmin, 
      this.token,});

  UserData.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    bio = json['bio'];
    dob = json['dob'];
    address = json['address'];
    gender = json['gender'];
    profilePicture = json['profilePicture'];
    login = json['login'];
    verified = json['verified'];
    isAdmin = json['isAdmin'];
    token = json['token'];
  }
  String? id;
  String? username;
  String? email;
  String? bio;
  String? dob;
  String? address;
  String? gender;
  dynamic profilePicture;
  bool? login;
  bool? verified;
  bool? isAdmin;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['bio'] = bio;
    map['dob'] = dob;
    map['address'] = address;
    map['gender'] = gender;
    map['profilePicture'] = profilePicture;
    map['login'] = login;
    map['verified'] = verified;
    map['isAdmin'] = isAdmin;
    map['token'] = token;
    return map;
  }

}