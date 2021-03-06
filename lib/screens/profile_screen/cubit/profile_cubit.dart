import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

import '../../../models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getCurrentUserProfileInfo() {
    emit(LoadingUserInfoState());
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((user) {
      userModel = UserModel.fromJson(user.data() ?? {});
      emit(GetUserInfoSuccessProfileState());
    });
  }

  var _picker = ImagePicker();
  File? profileImage;

  Future getProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadImageToImage(profileImage);
    } else {
      print('No Image Selected');
    }
  }

  void uploadImageToImage(File? profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            '${ConstantsManger.USERS}/profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(ConstantsManger.USERS)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'image': value});
      });
      emit(ChangeUserProfileImage());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void changeInfo({required Map<String, dynamic> map}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map).then((value) {
          emit(UpdateUserInfoSuccess());
    });
  }
}
