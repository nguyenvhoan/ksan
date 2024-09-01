import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testtt/controller/multiselected.dart';
import 'package:testtt/models/database_service.dart';
import 'package:testtt/models/room.dart';

class AddService extends StatefulWidget {
  const   AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}
final DatabaseService _databaseService= DatabaseService();
// List<Category> items = []; 

TextEditingController serviceController= TextEditingController();

final FirebaseFirestore db = FirebaseFirestore.instance;




class _AddServiceState extends State<AddService> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
              TextField(
                controller: serviceController,             
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30) ,
                ),
                labelText: 'Dịch vụ mới :'
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
                
                  await _databaseService.createService(serviceController.text);
                  serviceController.clear();
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
