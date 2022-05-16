import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/screens/chat_screen/cubit/chat_cubit.dart';
import 'custom_user_item.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (cotext, state) {

          return ChatCubit.get(context).userList.length == 0
              ? Center(child: AppText(text: 'No Messages',isTitle: true,textSize: 30,color: Colors.grey,))
              : ListView.builder(
                  itemCount: ChatCubit.get(context).userList.length,
                  itemBuilder: (context, index) {
                    return CustomUserItem(
                        userModel: ChatCubit.get(context).userList[index]);
                  });
        });
  }
}
