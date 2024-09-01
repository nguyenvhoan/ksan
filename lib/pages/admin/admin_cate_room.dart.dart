import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testtt/pages/admin/widgets/add_cate_room_bottom.dart';
import 'package:testtt/pages/admin/widgets/add_service.dart';
import 'package:testtt/pages/admin/widgets/bottom_option_room.dart';
import 'package:testtt/pages/admin/widgets/update_bottom_room.dart';
import 'package:testtt/pages/widgets/navbar.dart';

String color='0xffFFFFFF';

List<String> items=[];
class AdminCateRoom extends StatelessWidget {
  AdminCateRoom({super.key});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Room'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Navbar(),
      body: StreamBuilder(
        stream: db.collection('cateRoom').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Wrap(
                spacing: 20, // Khoảng cách giữa các item
                runSpacing: 20, // Khoảng cách giữa các hàng
                children: snapshot.data!.docs.map<Widget>((documentSnapshot) {
                  items.add(documentSnapshot['cateRoom']);
                  print(items);
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    constraints: BoxConstraints(
                      maxWidth: 350 , // Chiều rộng tối thiểu
                    ),
                    
                    decoration: BoxDecoration(
                      color: Color(int.parse(color)),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.network(
                              'lib/controller/SUPER-DELUXE2.jpg', // Đảm bảo rằng URL hợp lệ
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Expanded( // Sử dụng Expanded để cho phép nội dung chiếm không gian còn lại
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('Loại phòng: '),
                                  Text(documentSnapshot['cateRoom']),
                                ]),
                                
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                            
                            },
                            icon: Icon(Icons.edit),
                            
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext content) {
              return AddCateRoom();
            },
          );
        },
      ),
    );
  }
}