
class UserModel{
  String ? userName;
  String ? phone;
  String ? image ;
  String ? uid;
  String ? token;
  bool ? isDoctor;

  UserModel({
    required this.userName,
    required this.phone,
    required this.isDoctor,
    required this.token,
    this.image,
    this.uid});

  UserModel.fromJson(Map<String, dynamic> json){
    userName = json ['userName'];
    phone = json ['phone'];
    image = json ['image'];
    uid = json ['uid'];
    isDoctor = json['isDoctor'];
    token=json['token'];
  }

  Map<String, dynamic> toMap(){
    return {
      'userName':userName,
      'phone':phone,
      'image':image,
      'uid':uid,
      'isDoctor':isDoctor,
      'token':token,
    };
  }
}