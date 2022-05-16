class PatientHistoryModel {
  String ? id ;
  String ? name;
  String ? date;
  String ? patientId;
  String ? pdfFile;
  String ? examination;
  String ? doctorName;
  String ? doctorId;
  List<String> imageList = [];



  PatientHistoryModel({
    required this.id,
    required this.name,
    required this.date,
    required this.patientId,
    required this.imageList,
    this.pdfFile,
    required this.examination,
    required this.doctorName,
  required this.doctorId});

  PatientHistoryModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    id= json['id'];
    date=json['date'];
    patientId= json['patientId'];
    examination =json['examination'];
    doctorName =json['doctorName'];
    pdfFile =json['pdfFile'];
    doctorId = json['doctorId'];
    if(json['imageList'] !=null){
      json['imageList'].forEach((image){
        imageList.add(image);
      });
    }
  }
  Map<String ,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'date':date,
      'patientId':patientId,
      'pdfFile':pdfFile,
      'examination':examination,
      'doctorName':doctorName,
      'pdfFile':pdfFile,
      'doctorId':doctorId,
      'imageList':imageList,

    };
  }
}