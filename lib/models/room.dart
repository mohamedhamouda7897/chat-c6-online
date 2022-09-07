class Room{

  static const String CollectionRoomName='rooms';

  String id ;
  String title;
  String desc;
  String catId;

  Room({required this.id,required  this.title,required  this.desc,required  this.catId});

  Room.fromJson(Map<String, dynamic>json):this(
    id: json['id'] as String,
    title: json['title'] as String,
    desc: json['desc'] as String,
    catId: json['catId'] as String
  );

  Map<String ,dynamic>toJson(){

    return {
      'id':id,
      'title':title,
      'desc':desc,
      'catId':catId
    };
  }
}