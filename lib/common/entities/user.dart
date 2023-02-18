class UserItem {
  String? access_token;
  String? token;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;
  UserItem({
    this.access_token,
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type,
  });
  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
        access_token: json["access_token"],
        token: json["token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        online: json["online"],
        type: json["type"],
      );
  Map<String, dynamic> toJson() => {
        "access_token": access_token,
        "token": token,
        "name": name,
        "description": description,
        "avatar": avatar,
        "online": online,
        "type": type,
      };
}

class LoginRequestEntity {
  String? email;
  String? phone;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;
  String? open_id;

  LoginRequestEntity({
    this.email,
    this.phone,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type,
    this.open_id,
  });
  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "name": name,
        "description": description,
        "avatar": avatar,
        "online": online,
        "type": type,
        "open_id": open_id,
      };
}

class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserItem? data;
  UserLoginResponseEntity({
    this.code,
    this.data,
    this.msg,
  });
}
