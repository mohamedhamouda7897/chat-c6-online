class Message{

  static const String ColleectionName='Messages';
  String id;
  String roomId;
  String content;
  int dateTime;
  String SenderId;
  String SenderName;

  Message({this.id='', required this.roomId,required  this.content,required  this.dateTime,required  this.SenderId,
    required  this.SenderName});

  Message.fromJson(Map<String , dynamic> json ):this(
    id: json['id'],
    roomId: json['roomId'],
    content: json['content'],
    dateTime: json['dateTime'],
    SenderId: json['senderId'],
    SenderName: json['senderName']
  );
   Map<String,dynamic>toJson(){
     return {
       'id': id,
       'roomId': roomId,
       'content': content,
       'dateTime': dateTime,
       'senderId': SenderId,
       'senderName': SenderName
     };
   }
}