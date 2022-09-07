class MyUser {

  static const String CollectionName='users';

  String id;
  String fName;
  String lName;
  String username;
  String email;

  MyUser(
      { required this.id, required this.fName, required this.lName, required this.username, required this.email});

  MyUser.fromJson(Map<String, dynamic>json) :
        this(
          id: json['id'] as String,
          fName: json['fName'] as String,
          lName: json['lName'] as String,
          username: json['username'] as String,
          email: json['email'] as String
      );

  Map<String , dynamic>toJson(){
    return {
      'id':id,
      'fName':fName,
      'lName':lName,
      'username':username,
      'email':email
    };
  }
}
