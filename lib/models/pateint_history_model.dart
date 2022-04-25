class PatientHistoryModel {
  String ? name;
  String ? date;
  String ? patientId;
  List<String>? images;
  String ? pdfFile;
  String ? examination;
  String ? doctorName;


  PatientHistoryModel({
    required this.name,
    required this.date,
    required this.patientId,
    this.images,
    this.pdfFile,
    required this.examination,
    required this.doctorName});

  PatientHistoryModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    date=json['date'];
    patientId= json['patientId'];
    examination =json['examination'];
    doctorName =json['doctorName'];
    if (json['images'] != null) {
      json['images'].forEach((element) {
        images!.add(element);
      });
    }
    pdfFile =json['pdfFile'];
  }
  Map<String ,dynamic> toMap(){
    return{
      'name':name,
      'date':date,
      'patientId':patientId,
      'images':images,
      'pdfFile':pdfFile,
      'examination':examination,
      'doctorName':doctorName,
      'pdfFile':pdfFile,
    };
  }
}