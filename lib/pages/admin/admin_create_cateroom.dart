import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testtt/models/database_service.dart';

import 'package:testtt/pages/admin/widgets/bottom_option_room.dart';
import 'package:testtt/pages/admin/widgets/update_bottom_room.dart';
import 'package:testtt/pages/widgets/navbar.dart';
String color='0xffFFFFFF';

List<String> items=[];
class AdminCreateCateroom extends StatefulWidget {
  AdminCreateCateroom({super.key});

  @override
  State<AdminCreateCateroom> createState() => _AdminCreateCateroomState();
}

class _AdminCreateCateroomState extends State<AdminCreateCateroom> {
  List<String> services = [];
  List<String> cates = [];
  @override
  void initState() {
    super.initState();
    fetchServices();
    fetchCate();
  }

  Future<void> fetchServices() async {
    List<String> fetchedServices = await _databaseService.getService();
    setState(() {
      services = fetchedServices;
    });
    print(services);
  }
  Future<void> fetchCate() async {
    List<String> fetchedCate = await _databaseService.getCateRoom();
    setState(() {
      cates = fetchedCate;
    });
    print(cates);
  }
  final FirebaseFirestore db = FirebaseFirestore.instance;

  DatabaseService _databaseService =DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Create Cateroom'),
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
        stream: db.collection('room').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Wrap(
                spacing: 20, // Khoảng cách giữa các item
                runSpacing: 20, // Khoảng cách giữa các hàng
                children: snapshot.data!.docs.map<Widget>((documentSnapshot) {
                  String color = documentSnapshot['status'] == 0 ? '0xff00FFFF' : '0xffFFFFFF';
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    constraints: BoxConstraints(
                      maxWidth: 500 , // Chiều rộng tối thiểu
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
                                  Text('Số phòng: '),
                                  Text(documentSnapshot['id']),
                                ]),
                                Row(children: [
                                  Text('Loại phòng: '),
                                  Text(documentSnapshot['cate']),
                                ]),
                                Row(children: [
                                  Text('Mô tả phòng: '),
                                  Expanded(
                                    child: Text(
                                      documentSnapshot['des'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Text('Giá thuê: '),
                                  Text((documentSnapshot['price']).toString()),
                                ]),
                                Row(children: [
                                  Text('Trạng thái: '),
                                  Text(documentSnapshot['status'] == 1 ? 'đã thuê' : 'chưa thuê'),
                                ]),
                                Row(children: [
                                  Text('Dịch vụ: '),
                                  Text(List<String>.from(documentSnapshot['service']).join(', ')),
                                ]),
                              ],
                            ),
                          ),
                          
                          IconButton(
                            onPressed: () {
                              
                              showModalBottomSheet(context: context, builder: (BuildContext content){
                                return UpdateBottomRoom(
                                  code: documentSnapshot['id'],
                                  cate: documentSnapshot['cate'],
                                  des: documentSnapshot['des'],
                                  price: documentSnapshot['price'],
                                  status: documentSnapshot['status'],
                                  items: List<String>.from(documentSnapshot['service']),

                                );
                              });
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
              return BottomOption(service: services,cate: cates,);
            },
          );
        },
      ),
    );
  }
}



