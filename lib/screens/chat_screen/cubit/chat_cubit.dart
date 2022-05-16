import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

import '../../../models/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get (context)=>BlocProvider.of(context);

  void getChatList() {
    FirebaseFirestore.instance.collection(ConstantsManger.USERS).get().then((value) {
      value.docs.forEach((users) {
        FirebaseFirestore.instance
            .collection(ConstantsManger.CHATLIST)
            .doc(ConstantsManger.CHATLIST)
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
              print(value.docs.length);
          value.docs.forEach((chat) {
            if (users.id == chat.id) {
              getUser(users.id);
            }
          });
        });
      });
    });
  }

  List<UserModel> userList = [];

  void getUser(String id) {
    userList.clear();
    FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(id).get().then((value) {
      userList.add(UserModel.fromJson(value.data() ?? {}));
    }).then((value) {
      emit(SetChatListState());
    });
  }
}
