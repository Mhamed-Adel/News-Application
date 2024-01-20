class SearchModel {
late  bool status;
late  DataModel data;

  SearchModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel{
  int? currentpage;
  List<Data> data = [];
  DataModel.fromJson(Map<String,dynamic>json){
    currentpage = json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });

  }
}

class Data{
int? id;
dynamic price;
dynamic oldprice;
dynamic discount;
dynamic image;
String? name;

Data.fromJson(Map<String,dynamic>json){
  id=json['id'];
  price=json['price'];
  oldprice=json['old_price'];
  discount=json['discount'];
  image=json['image'];
  name=json['name'];
}
}