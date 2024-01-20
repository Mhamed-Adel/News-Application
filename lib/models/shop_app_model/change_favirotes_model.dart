class ChangeFavirotesModel{
  late bool status;
  late String message;
  ChangeFavirotesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}