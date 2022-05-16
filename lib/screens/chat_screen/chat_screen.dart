import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/screens/chat_screen/cubit/chat_cubit.dart';
import 'package:smart_prescription/screens/chat_screen/screen/chats_screen/chats_screen.dart';
import 'package:smart_prescription/shared/helper/icon_broken.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';

class ChatScreenLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getChatList(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              ChatsScreen(),
              Center(child: Text('All Users Here')),
            ],
          ),
        ),
      ),
    );
  }
}
