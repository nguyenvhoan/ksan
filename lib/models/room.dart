import 'package:flutter/material.dart';

class Room{
  String id;
  String cate;
  int price;
  int status =0;
  String des;
  List<String> items;
  Room({required this.id, required this.cate, required this.price, required this.status, required this.des,required this.items});
  Map<String,dynamic> toMap()=>{"id":id,"cate":cate, 'price': price,'status':0, 'des':des,'service':items};
}