class UserModel {
  String? userName;
  String? phone;
  String? address;
  String? image;
  String? birthDate;
  String? uid;
  String? token;
  bool? isDoctor;
  String? doctorSpecialization;
  String? doctorId;

  UserModel(
      {required this.userName,
      required this.phone,
      required this.address,
      required this.image,
      this.uid,
      this.token,
     required this.birthDate,
      required this.isDoctor,
      this.doctorSpecialization,
      this.doctorId});

  UserModel.fromJson(Map<String, dynamic> json) {
    birthDate= json['birthDate'];
    userName = json['userName'];
    phone = json['phone'];
    address = json['address'];
    image = json['image'];
    uid = json['uid'];
    token = json['token'];
    isDoctor = json['isDoctor'];
    doctorSpecialization = json['doctorSpecialization'];
    doctorId = json['doctorId'];

  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'birthDate': birthDate,
      'phone': phone,
      'address': address,
      'image': image,
      'uid': uid,
      'token': token,
      'isDoctor': isDoctor,
      'doctorSpecialization': doctorSpecialization,
      'doctorId': doctorId,

    };
  }
}
