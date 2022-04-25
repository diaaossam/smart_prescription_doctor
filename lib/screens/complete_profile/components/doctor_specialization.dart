
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:smart_prescription/screens/complete_profile/cubit/complete_profile_state.dart';



class DoctorSpecialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit,CompleteProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'أختر التخصص',
              style: TextStyle(
                fontSize: 20,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: CompleteProfileCubit.get(context).doctorTitleList
                .map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize:20,
                    ),
                  ),
                ))
                .toList(),
            value: CompleteProfileCubit.get(context).doctorTitle,
            onChanged: (value) {
              CompleteProfileCubit.get(context).chooseDoctorType(doctor: '${value}');
            },
            buttonHeight: 50,
            buttonWidth: 240,
            itemHeight: 50.0,
          ),
        );
      },
    );
  }
}
