import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:smart_prescription/models/pateint_history_model.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

part 'add_new_ex_state.dart';

class AddNewExCubit extends Cubit<AddNewExState> {
  AddNewExCubit() : super(AddNewExInitial());

  static AddNewExCubit get(BuildContext context) => BlocProvider.of(context);

  var picker = ImagePicker();
  List<XFile> patientImages = [];
  List<String> imagesUrl = [];

  Future getpatientImages() async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      patientImages.addAll(pickedFile);
      emit(UploadProductImageSuccessState());
    } else {
      emit(UploadProductFailerState());
    }
  }

  void _uploadProductImage(
      {required String id, required File vedioFile}) async {
    imagesUrl = [];
    for (int i = 0; i < patientImages.length; i++) {
      await firebase_storage.FirebaseStorage.instance
          .ref("patientImages")
          .child(id)
          .child("${Uri.file(patientImages[i].path).pathSegments.last}")
          .putFile(File(patientImages[i].path))
          .then((image) {
        image.ref.getDownloadURL().then((value) {
          imagesUrl.add(value);
        });
      });
    }
    await firebase_storage.FirebaseStorage.instance
        .ref("ProductVedios")
        .child(id)
        .putFile(vedioFile)
        .then((vedio) {
      vedio.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance.collection("cars").doc(id).update(
            {'id': id, 'image': imagesUrl, 'video': value}).then((value) {
          emit(UploadExamitionInfoSuccess());
        });
      });
    });
  }

  void uploadPatientExamination({required PatientHistoryModel model}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.PATIENTS)
        .add(model.toMap())
        .then((value) {});
  }

  File ? pdfFile;

  void getPdfFile() async {
    FilePickerResult  ? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if(result !=null){
      pdfFile = File("${result.files.single.path}");
      emit(ChoosePdfFile());
    }
  }
}
