class UserModel {
  String userMail, userImg;

  UserModel(
    this.userMail,
    this.userImg,
  );
}

class UserModelConverter {
  UserModel userModelFromJson(Map<String, dynamic>? json) => UserModel(
        json!["userMail"],
        json["userImg"],
      );

  Map<String, dynamic> userModelToJson(UserModel instance) => <String, dynamic>{
        'userMail': instance.userMail,
        'userImg': instance.userImg,
      };
}
