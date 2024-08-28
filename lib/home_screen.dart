//import 'dart:js_interop_unsafe';
// Conditional import based on the platform
import 'dart:io' if (dart.library.js_interop) 'dart:js_interop_unsafe';



import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivedatabase/models/notes_models.dart';

import 'boxes/boxes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Hive Database')),
        backgroundColor: Colors.teal,
      ),
      body: ValueListenableBuilder<Box<NotesModels>>(
        valueListenable:Boxes.getData().listenable(),
        builder: (context , box,_ ){
          var data=box.values.toList().cast<NotesModels>();

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [

                          Text(data[index].title.toString(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              delete(data[index]);

                            },
                              child: Icon(Icons.delete,color: Colors.red,)),

                          SizedBox(width: 15,),
                          InkWell(
                            onTap: (){
                              _editDialog(data[index], data[index].title, data[index].description);
                            },
                              child: Icon(Icons.edit)),

                        ],
                      ),

                      Text(data[index].description.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),
              );
            },

          );

        },  // builder means ky ui build karani hy hum ny
        // children: [
//           FutureBuilder(
//     future: Hive.openBox('fatima'),
//     builder: (context , snapshot){
//       return Column(
//         children: [
//           ListTile(
//             title:  Text(snapshot.data!.get('name').toString()),
//             subtitle:  Text(snapshot.data!.get('age').toString()),
//             trailing: IconButton(
//               onPressed: (){
//                 //snapshot.data!.put('name','value');// update the value
//                 snapshot.data!.delete('name');
//                 setState(() {
//
//                 });
//               }, icon: Icon(Icons.delete),
//             ),
//           ),
//
//         ],
//       );
//     }
// ),
//           FutureBuilder(
//               future: Hive.openBox('name'),
//               builder: (context , snapshot){
//                 return Column(
//                   children: [
//                     ListTile(
//                       title:  Text(snapshot.data!.get('youtube').toString()),
//
//                     ),
//
//                   ],
//                 );
//               }
//           ),


       // ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async{

          _showMyDialog();



          // var box = await Hive.openBox('fatima');
          // var box2 = await Hive.openBox('name');
          //
          // box2.put('youtube', 'life');
          //
          // box.put('name', 'fatima khalid');
          // box.put('age', '23 ');
          // box.put('details',  {
          //   'pro' : 'developer',
          //   'cash' :'najjhcs'
          // });
          //
          //
          // print(box.get('name'));
          // print(box.get('age'));
          // print(box.get('details')['pro']);// if want to display one from the list

        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModels  notesModels) async{
    await notesModels.delete();

  }

  Future<void> _editDialog(NotesModels notesModels , String title , String description){
    titleController.text=title;
    descriptionController.text=description;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Edit Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText:'Enter Title' ,
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText:'Enter Description' ,
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {

                    notesModels.title=titleController.text.toString();
                    notesModels.description=descriptionController.text.toString();
                    await notesModels.save();
                    descriptionController.clear();
                    titleController.clear();
                    //final data=NotesModels(title: titleController.text,
                    //     description: descriptionController.text);
                    // final box = Boxes.getData();
                    // box.add(data);
                    //
                    // // data.save();
                    //
                    // print(box);
                    // titleController.clear();
                    // descriptionController.clear();
                    Navigator.pop(context);

                  },
                  child: Text('Edit')),

              TextButton(
                  onPressed: (){

                    Navigator.pop(context);

                  },
                  child: Text('Cancel')),
            ],
          );
        }
    );
  }


  Future<void> _showMyDialog(){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Add Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText:'Enter Title' ,
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText:'Enter Description' ,
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  final data=NotesModels(title: titleController.text,
                      description: descriptionController.text);
                  final box = Boxes.getData();
                  box.add(data);

                  // data.save();

                  print(box);
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);

                },
                child: Text('Add')),

            TextButton(
                onPressed: (){

                  Navigator.pop(context);

                },
                child: Text('Cancel')),
          ],
        );
      }
    );
  }
}
