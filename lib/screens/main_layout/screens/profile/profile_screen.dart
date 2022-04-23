import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/custom_card.dart';
import 'package:smart_prescription/shared/helper/icon_broken.dart';
import 'package:smart_prescription/shared/helper/mangers/assets_manger.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';
import 'package:smart_prescription/shared/helper/mangers/size_config.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserInfo(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return state is GetUserInfoLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: SizeConfigManger.bodyHeight * 0.08,
                    ),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: SizeConfigManger.bodyHeight * .105,
                                backgroundColor: ColorsManger.primaryColor,
                              ),
                              CircleAvatar(
                                radius: SizeConfigManger.bodyHeight * .1,
                                backgroundColor: Colors.white,
                                backgroundImage: setImage(cubit),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: ColorsManger.primaryColor,
                            radius: getProportionateScreenHeight(25.0),
                            child: IconButton(
                                onPressed: () {
                                  cubit.getproductImage();
                                },
                                icon: Icon(Icons.camera_alt)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfigManger.bodyHeight * 0.03,
                    ),
                 /*   CustomCardInfo(
                        prefix: IconBroken.User,
                        title: 'Full Name',
                        detials:
                            '${cubit.userModel.firstName} ${cubit.userModel.lastName}'),
                    CustomCardInfo(
                        prefix: IconBroken.User,
                        title: 'Full Name',
                        detials:
                        '${cubit.userModel.firstName} ${cubit.userModel.lastName}')*/
                  ],
                );
        },
      ),
    );
  }

  ImageProvider setImage(ProfileCubit cubit) {
    print(cubit.userModel.image);
    if (cubit.userModel.image == ConstantsManger.DEFAULT) {
      return AssetImage(AssetsManger.DefaultUserImage);
    } else {
      if (cubit.profileImage != null) {
        return FileImage(cubit.profileImage ?? File(''));
      } else {
        return NetworkImage(cubit.userModel.image ?? '');
      }
    }
  }
}
