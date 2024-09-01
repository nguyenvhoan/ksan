import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testtt/models/room.dart';
class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> createRoom(Room room) async {
      try {
          db.collection('room').doc('room '+room.id).set(room.toMap());
        }
        catch(e){
          print(e.toString());
        }
    
}
Future<void> createService(String service) async {
      try {
          db.collection('service').add(({'service':service}));
        }
        catch(e){
          print(e.toString());
        }
    
}
Future<List<String>> getService() async {
  List<String> services = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('service').get();
    
    for (var doc in querySnapshot.docs) {
      
      services.add(doc['service']); 
    }
  } catch (e) {
    print(e.toString());
  }
  
  return services;
}
Future<void> createCateRoom(String cate) async {
      try {
          db.collection('cateRoom').add(({'cateRoom':cate}));
        }
        catch(e){
          print(e.toString());
        }
    
}
Future<List<String>> getCateRoom() async {
  List<String> cateRoom = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('cateRoom').get();
    
    for (var doc in querySnapshot.docs) {
      
      cateRoom.add(doc['cateRoom']); 
    }
  } catch (e) {
    print(e.toString());
  }
  
  return cateRoom;
}

}
  
