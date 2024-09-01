import 'package:flutter/material.dart';
import 'package:testtt/pages/admin/admin_cate_room.dart.dart';
import 'package:testtt/pages/admin/admin_create_cateroom.dart';
import 'package:testtt/pages/admin/service_room.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blueAccent,
            alignment: Alignment.center,
            child: Text(
              'Admin Management',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Danh sách phòng'),
            onTap: () {
              Navigator.pop(context); // Đóng Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminCreateCateroom()),
              );
            },
          ),
          ListTile(
            title: Text('Danh sách các dịch vụ'),
            onTap: () {
              Navigator.pop(context); // Đóng Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiceRoom()),
              );
            },
          ),
          ListTile(
            title: Text('Danh sách các loại phòng'),
            onTap: () {
              Navigator.pop(context); // Đóng Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminCateRoom()),
              );
            },
          ),
        ],
      ),
    );
  }
}
