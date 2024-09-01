import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testtt/controller/multiselected.dart';
import 'package:testtt/models/database_service.dart';
import 'package:testtt/models/room.dart';
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
String  selected='';  
List<String> _selectedItems = [];
class UpdateBottomRoom extends StatelessWidget {
     UpdateBottomRoom({super.key,required this.code, required this.cate,required this.des,required this.price,required this.status, required this.items});
  String cate,des, code;
  int price,status;
  List<String> items;
  
  TextEditingController coderoomController= TextEditingController();

TextEditingController priceController=TextEditingController();

TextEditingController desController=TextEditingController();


  
  
  @override
  Widget build(BuildContext context) {
    print(cate);
    print(_selectedItems);
    coderoomController.text=code;
    priceController.text=price.toString();
    desController.text=des;
    selected=cate;
    _selectedItems = items;
    
    
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
              TextField(
                controller: coderoomController,             
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30) ,
                ),
                labelText: 'Số phòng :'
              ),
              
            ),
            SizedBox(height: 5,),
            TextField(
                controller: desController,             
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30) ,
                ),
                labelText: 'Giới thiệu về phòng :'
              ),
              
            ),
            SizedBox(height: 5,),
            TextField(
                controller: priceController,             
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30) ,
                ),
                labelText: 'Giá phòng :'
              ),
              
            ),
            SizedBox(height: 10,),
            DropdownButtonExample(),
            MultiOption(),
            const SizedBox(height: 20,),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:() async {
                  Room room= Room(
                    id: coderoomController.text,
                    cate: selected,
                    price: int.parse(priceController.text),
                    status: 0,
                    des: desController.text,
                    items: _selectedItems

                  );
                  
                  await _databaseService.createRoom(room);
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
final DatabaseService _databaseService= DatabaseService();
// List<Category> items = []; 


final FirebaseFirestore db = FirebaseFirestore.instance;




class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = selected;
  
  @override
  Widget build(BuildContext context) {
    
    selected=dropdownValue;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MultiOption extends StatefulWidget {
   MultiOption({super.key});

  @override
  State<MultiOption> createState() => _MultiOptionState();
}

class _MultiOptionState extends State<MultiOption> {
  
   void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
      
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

   @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // use this button to open the multi-select dialog
            ElevatedButton(
              onPressed: _showMultiSelect,
              child: const Text('Select Your Favorite Topics'),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}