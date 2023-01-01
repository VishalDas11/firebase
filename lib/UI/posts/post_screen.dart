import 'package:firebase/UI/auth/login_screen.dart';
import 'package:firebase/UI/posts/add_post.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final searchFilter = TextEditingController();
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final changecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Screen"), centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 10,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPost()));
        },
        child: Icon(Icons.add),
      ),
      body:Column(
        children: [
          //stream builder
          // Expanded(
          //     child: StreamBuilder(
          //       stream: ref.onValue,
          //       builder: (context, AsyncSnapshot<DatabaseEvent>snapshot){
          //          if(!snapshot.hasData){
          //            return const CircularProgressIndicator();
          //          }
          //          else{
          //            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //
          //            List<dynamic> list = [];
          //            list.clear();
          //            list = map.values.toList();
          //
          //            return ListView.builder(
          //                itemCount: snapshot.data!.snapshot.children.length,
          //                itemBuilder: (context, index){
          //              return ListTile(
          //                title: Text("Id: "+list[index]['id']),
          //              );
          //            });
          //          }
          //       },
          //     )),
          //  SizedBox(height: 20,),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState((){});
              },
            ),
          ),

           Expanded(
             child: FirebaseAnimatedList(
               defaultChild: Text("Loading"),
                 query: ref,
                 itemBuilder: (context, snapshot, animation, index){
                 final title = snapshot.child('title').value.toString();
                 if(searchFilter.text.isEmpty){
                   return ListTile(
                     title: Text( snapshot.child('title').value.toString() ),
                     subtitle: Text(snapshot.child('id').value.toString()),
                     trailing: PopupMenuButton(
                       icon: Icon(Icons.more_vert,),
                       itemBuilder: (BuildContext context)=> [
                         PopupMenuItem(
                           value: 1,
                             child: ListTile(
                               leading: Icon(Icons.edit),
                               title: Text('Edit'),
                               onTap: (){
                                 Navigator.pop(context);
                                 ShowSnackBar(title, snapshot.child('id').value.toString());
                               },
                             )),
                         PopupMenuItem(
                           value: 1,
                             child: ListTile(
                             leading: Icon(Icons.delete),
                               title: Text("Delete"),
                         )),
                       ],
                     )
                   );
                 }
                 else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toLowerCase())){
                    return ListTile(
                      title: Text( snapshot.child('title').value.toString() ),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                 }
                 else{
                   return Container();
                 }
                   // return ListTile(
                   //   title: Text("title: "+ snapshot.child('title').value.toString() ),
                   //   subtitle: Text('id: '+snapshot.child('id').value.toString()),
                   // );
                 }),
           )
        ],
      ) ,

    );
  }

  Future<void> ShowSnackBar(String title, String id) async{
    changecontroller.text = title;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Update"),
            content: TextField(
              controller: changecontroller,
              decoration: InputDecoration(
                hintText: "Edit"
              ),
            ),
            actions: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    ref.child(id).update({
                      'title' : changecontroller.text.toLowerCase()
                    }).then((value) {
                      Utils().toastMessage("Update successfully");
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("Update"),
                ),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Remove"))
            ],
          );
        });
  }
}
