import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/components/custom_button.dart';
import 'package:smart_prescription/screens/main_doctor/cubit/main_cubit.dart';
import 'package:smart_prescription/screens/patient_history/cubit/patient_history_cubit.dart';
import 'package:smart_prescription/shared/helper/icon_broken.dart';
import 'package:smart_prescription/shared/helper/methods.dart';
import '../../components/custom_text_form_field.dart';
import '../../models/pateint_history_model.dart';
import '../../shared/helper/mangers/colors.dart';
import '../add_xamination/add_xamination.dart';
import '../details/details_screen.dart';

class PatientHistory extends StatelessWidget {
  String? patientId;
  var examController = TextEditingController();
  var dateController = TextEditingController();

  PatientHistory({this.patientId});

  @override
  Widget build(BuildContext context) {
    //from doctor App
    if (patientId != null) {
      return BlocProvider(
        create: (context) =>
            PatientHistoryCubit()..getPatientHistory(patientId: patientId!),
        child: BlocConsumer<PatientHistoryCubit, PatientHistoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: CustomButton(
                      press: () {
                        navigateTo(context,
                            AddExaminationScreen(patientId: patientId!));
                      },
                      text: 'Add New Xamination',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildListView(PatientHistoryCubit.get(context), true),
                ],
              ),
            );
          },
        ),
      );
    }

    // From User App No App Bar
    else {
      return BlocProvider(
        create: (context) => PatientHistoryCubit()..getPatientHistory(),
        child: BlocConsumer<PatientHistoryCubit, PatientHistoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            PatientHistoryCubit cubit = PatientHistoryCubit.get(context);
            return cubit.patientHistoryList.length == 0
                ? Center(
                    child: AppText(text: 'No History', color: Colors.grey,textSize: 30.0),
                  )
                : Container(
              padding: EdgeInsets.all(20.0),
                    width: double.infinity,
                    child: ListView.separated(
                        separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildListViewItem(
                            cubit: cubit,
                            model: cubit.patientHistoryList[index],
                            context: context,
                            isDoc: false),
                        itemCount: cubit.patientHistoryList.length),
                  );
          },
        ),
      );
    }
  }

  Widget buildListView(PatientHistoryCubit cubit, bool isDoc) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
            shrinkWrap: true,
            itemBuilder: (context, index) => buildListViewItem(
                cubit: cubit,
                model: cubit.patientHistoryList[index],
                context: context,
                isDoc: isDoc),
            itemCount: cubit.patientHistoryList.length),
      ),
    );
  }

  Widget buildListViewItem(
      {required PatientHistoryModel model,
      required context,
      required bool isDoc,
      required PatientHistoryCubit cubit}) {
    return InkWell(
      onTap: () {
        navigateTo(context, DetailsScreen(isDoc, model.id ?? ''));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorsManger.primaryColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            AppText(
              text: 'Doctor name : ${model.doctorName}',
              color: Colors.white,
              textSize: 23.0,
            ),
            SizedBox(
              height: 8,
            ),
            AppText(
              text: 'Date               :  ${model.date}',
              color: Colors.white,
              textSize: 23.0,
            ),
            SizedBox(
              height: 8,
            ),
            AppText(
              text: 'Examination : ${model.examination}',
              color: Colors.white,
              textSize: 23.0,
            ),
            SizedBox(
              height: 20,
            ),
            model.doctorId == FirebaseAuth.instance.currentUser!.uid
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              buildEditDialog(context, cubit, model.id);
                            },
                            icon: Icon(
                              IconBroken.Edit,
                              color: Colors.white,
                              size: 35,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.deleteModel(id: model.id ?? '');
                            },
                            icon: Icon(
                              IconBroken.Delete,
                              color: Colors.white,
                              size: 35,
                            )),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  AwesomeDialog buildEditDialog(context, PatientHistoryCubit cubit, id) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Column(
        children: [
          CustomTextFormField(
              lableText: 'Examination',
              hintText: 'Examination',
              controller: examController),
          SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
              lableText: 'Date', hintText: 'Date', controller: dateController),
        ],
      ),
      btnOkOnPress: () {
        cubit.updateUserData(map: {
          "examination": examController.text,
          "date": dateController.text,
        }, id: id);
      },
    )..show();
  }
}
