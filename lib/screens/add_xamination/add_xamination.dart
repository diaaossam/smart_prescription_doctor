import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/models/pateint_history_model.dart';
import 'package:smart_prescription/models/user_model.dart';
import 'package:smart_prescription/screens/add_xamination/cubit/add_new_ex_cubit.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import '../../shared/helper/mangers/size_config.dart';
import '../../shared/helper/methods.dart';

class AddExaminationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var examination = TextEditingController();
  UserModel userModel;

  AddExaminationScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewExCubit(),
      child: BlocConsumer<AddNewExCubit, AddNewExState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AddNewExCubit cubit = AddNewExCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20.0),
                        horizontal: getProportionateScreenHeight(20.0)),
                    child: Column(
                      children: [
                        state is UploadExamitionInfoLoading
                            ? LinearProgressIndicator()
                            : Container(),
                        SizedBox(
                          height: getProportionateScreenHeight(20.0),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.getpatientImages();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              width: double.infinity,
                              height: SizeConfigManger.bodyHeight * 0.33,
                              child: GridView.builder(
                                  itemCount: cubit.patientImages.isEmpty
                                      ? 6
                                      : cubit.patientImages.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: getProportionateScreenHeight(40.0),
                                      height:
                                          getProportionateScreenHeight(40.0),
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                      ),
                                      child: cubit.patientImages.isEmpty
                                          ? Icon(Icons.camera)
                                          : Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(cubit
                                                    .patientImages[index]
                                                    .path)),
                                              )),
                                            ),
                                    );
                                  })),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              state is ChoosePdfFile ?Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/pdf.png')),
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                width: SizeConfigManger.bodyHeight * 0.1,
                                height: SizeConfigManger.bodyHeight * 0.1,
                              ):Container(),
                              Spacer(),
                              Container(
                                  height: getProportionateScreenHeight(50.0),
                                  width: getProportionateScreenHeight(150),
                                  child: CustomButton(
                                    press: () {
                                      cubit.getPdfFile();
                                    },
                                    text: 'Choose Pdf',
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20.0),
                        ),
                        CustomTextFormField(
                            controller: examination,
                            lableText: 'Examination',
                            hintText: 'n'),
                        SizedBox(
                          height: getProportionateScreenHeight(40.0),
                        ),
                        CustomButton(
                            text: 'SUBMIT',
                            press: () {
                              cubit.uploadPatientExamination(
                                  model: PatientHistoryModel(
                                name: userModel.userName,
                                date: formatDate(dateTime: DateTime.now()),
                                patientId: userModel.uid,
                                examination: examination.text,
                                doctorName: '',
                                images: cubit.imagesUrl,
                                pdfFile: '',
                              ));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
