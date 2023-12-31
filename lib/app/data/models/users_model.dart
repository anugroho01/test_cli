class UserModel {
  String? uid;
  String? name;
  String? keyName;
  String? email;
  String? createAt;
  String? lastSign;
  String? photoUrl;
  String? status;
  String? updateTime;
  List<ChatUser>? chats;

  UserModel(
      {this.uid,
      this.name,
      this.keyName,
      this.email,
      this.createAt,
      this.lastSign,
      this.photoUrl,
      this.status,
      this.updateTime,
      this.chats});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    keyName = json['keyName'];
    email = json['email'];
    createAt = json['creationTime'];
    lastSign = json['lastSignInTime'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    updateTime = json['updatedTime'];
    if (json['chats'] != null) {
      chats = <ChatUser>[];
      json['chats'].forEach((v) {
        chats?.add(ChatUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['keyName'] = keyName;
    data['email'] = email;
    data['creationTime'] = createAt;
    data['lastSignInTime'] = lastSign;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['updatedTime'] = updateTime;
    if (chats != null) {
      data['chats'] = chats?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatUser {
  String? connection;
  String? chatId;
  String? lastTime;
  int? totalUnread;

  ChatUser({this.connection, this.chatId, this.lastTime, this.totalUnread});

  ChatUser.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    chatId = json['chat_id'];
    lastTime = json['lastTime'];
    totalUnread = json['total_unread'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['connection'] = connection;
    data['chat_id'] = chatId;
    data['lastTime'] = lastTime;
    data['total_unread'] = totalUnread;
    return data;
  }
}
