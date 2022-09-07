import 'package:flutter/foundation.dart';

class Category{

  static String sportsId='sports';
  static String musicId='music';
  static String moviesId='movies';

  String id;
 late String name;
 late String image;


  Category(this.id,this.name,this.image);
  Category.fromId(this.id){
    image='assets/images/$id.jpeg';
    name=id;
  }

 static List<Category> getCategories(){
    return [
      Category.fromId(sportsId),
    Category.fromId(musicId),
    Category.fromId(moviesId),
    ];
  }
}