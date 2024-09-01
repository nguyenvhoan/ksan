import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testtt/controller/multiselected.dart';
import 'package:testtt/models/database_service.dart';
import 'package:testtt/models/room.dart';

class AddCateRoom extends StatefulWidget {
  const   AddCateRoom({super.key});

  @override
  State<AddCateRoom> createState() => _AddCateRoomState();
}
final DatabaseService _databaseService= DatabaseService();
// List<Category> items = []; 

TextEditingController cateRoomController= TextEditingController();

final FirebaseFirestore db = FirebaseFirestore.instance;




class _AddCateRoomState extends State<AddCateRoom> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
              TextField(
                controller: cateRoomController,             
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30) ,
                ),
                labelText: 'Loại phòng mới :'
              ),
              
            ),
            SizedBox(height: 5,),
            
            
            const SizedBox(height: 20,),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:() async {
                
                  await _databaseService.createCateRoom(cateRoomController.text);
                  cateRoomController.clear();
                  Navigator.pop(context);
                },
              child:const Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }
}
