class ProfilePicture {
  ProfilePicture({
      this.fileName, 
      this.filePath, 
      this.fileType, 
      this.fileSize,});

  ProfilePicture.fromJson(dynamic json) {
    fileName = json['fileName'];
    filePath = json['filePath'];
    fileType = json['fileType'];
    fileSize = json['fileSize'];
  }
  String? fileName;
  String? filePath;
  String? fileType;
  String? fileSize;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['fileName'] = fileName;
    map['filePath'] = filePath;
    map['fileType'] = fileType;
    map['fileSize'] = fileSize;
    return map;
  }

}