class UserModel {
  String? uid;
  String? name;
  String? email;
  String? lastSign;
  String? photoUrl;
  String? updateTime;
  String? createAt;
  String? status;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.lastSign,
      this.photoUrl,
      this.updateTime,
      this.createAt,
      this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    lastSign = json['lastSign'];
    photoUrl = json['photoUrl'];
    updateTime = json['updateTime'];
    createAt = json['create_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['lastSign'] = lastSign;
    data['photoUrl'] = photoUrl;
    data['updateTime'] = updateTime;
    data['create_at'] = createAt;
    data['status'] = status;
    return data;
  }
}
