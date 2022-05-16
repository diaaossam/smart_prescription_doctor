import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';
import '../../components/app_text.dart';
import '../../models/user_model.dart';
import '../../shared/helper/icon_broken.dart';
import '../../shared/helper/mangers/size_config.dart';
import 'componets/message_design.dart';
import 'cubit/message_cubit.dart';

class MessageScreen extends StatelessWidget {
  UserModel userModel;

  MessageScreen(this.userModel);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MessageCubit()
        ..readMessages(userModel.uid ?? ''),
      child: BlocConsumer<MessageCubit, MessageState>(
        listener: (context, state) {},
        builder: (context, state) {
          MessageCubit cubit = MessageCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.white,
                    child: Image(
                      image: '${userModel.image}' != ConstantsManger.DEFAULT
                          ? NetworkImage('${userModel.image}'):AssetImage('assets/images/user.png') as ImageProvider,
                      height: getProportionateScreenHeight(35.0),
                      width: getProportionateScreenHeight(35.0),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenHeight(10.0),
                  ),
                  AppText(
                    text: '${userModel.userName}',
                    color: ColorsManger.primaryColor,

                    textSize: 24,
                  ),
                ],
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: const AssetImage(
                          'assets/images/chat_background.jpg'))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cubit.userMessageList.length,
                        itemBuilder: (context, index) {
                          return MessageDesign(
                              isMyMessage:
                              cubit.userMessageList[index].sender ==
                                  cubit.getCurrentUserUid()
                                  ? true
                                  : false,
                              time: cubit.userMessageList[index].time,
                              message:
                              cubit.userMessageList[index].message ?? '');
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(5)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: getProportionateScreenHeight(6.0)),
                            child: Container(
                              height: SizeConfigManger.bodyHeight * 0.075,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          getProportionateScreenHeight(
                                              20.0)),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: InputDecoration(
                                            hintText: 'Message',
                                            focusedBorder: InputBorder.none),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(6)),
                          child: InkWell(
                            onTap: () {
                              cubit.sendMessage(
                                  receiver: '${userModel.uid}',
                                  message: messageController.text,
                                  isSeen: false,
                                  type: 'text');
                              messageController.clear();
                            },
                            child: CircleAvatar(
                                radius: getProportionateScreenHeight(27.0),
                                backgroundColor: ColorsManger.primaryColorLight,
                                child: const Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
