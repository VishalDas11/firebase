import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firestore/add_Data.dart';
import 'package:flutter/material.dart';

class FirestorScreen extends StatefulWidget {
  const FirestorScreen({Key? key}) : super(key: key);

  @override
  State<FirestorScreen> createState() => _FirestorScreenState();
}

class _FirestorScreenState extends State<FirestorScreen> {

  final firstore = FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FireStore"), backgroundColor: Colors.purple,),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFireStoreData()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: firstore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
               if(snapshot.connectionState == ConnectionState.waiting){
                 return Center(child: CircularProgressIndicator());
               }
               if(snapshot.hasError){
                 return Text("Error");
               }
               return  Expanded(
                 child: ListView.builder(
                     itemCount: snapshot.data!.docs.length,
                     itemBuilder: (context, index){
                       return ListTile(
                         leading: Text(snapshot.data!.docs[index]['title'].toString()),
                         subtitle: Text(snapshot.data!.docs[index].id.toString()),

                       );
                     }),
               );
          }),

        ],
      ),
    );
  }
}
