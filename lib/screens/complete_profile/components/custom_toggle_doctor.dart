import 'package:flutter/material.dart';
import 'package:smart_prescription/screens/complete_profile/cubit/complete_profile_cubit.dart';

class CustomToggleButtonDesign extends StatelessWidget {

  CompleteProfileCubit _cubit;

  CustomToggleButtonDesign(this._cubit);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.all(20),
          child: Row(
            children: [
              Text('Doctor',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 10.0,),
              Icon(Icons.admin_panel_settings_outlined),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.all(20),
          child: Row(
            children: [
              Text('Patient',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 10.0,),
              Icon(Icons.supervised_user_circle_rounded),
            ],
          ),
        ),

      ],
      onPressed: (int index) {
        _cubit.changeToggleState(index);
      },
      isSelected: _cubit.isDoctorList,
    );
  }
}