import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_app/register.dart';

FirebaseOptions config = const FirebaseOptions(
  apiKey: "AIzaSyARiB1-s8Qd1ekbl7-qJVheenAwimybO8k",
  authDomain: "new-app-d328c.firebaseapp.com",
  projectId: "new-app-d328c",
  storageBucket: "new-app-d328c.firebasestorage.app",
  messagingSenderId: "90253767865",
  appId: "1:90253767865:web:fda0ca145b23680fb29768",
  measurementId: "G-7ZXYMN9W74"
 );

void main() async{
  if(kIsWeb){
    await Firebase.initializeApp(options: config);
  }else{
   await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  @override
  void initState() {
    FirebaseAuth.instance.signInAnonymously();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebae App"), actions: [
        IconButton(onPressed: (){
          setState(() {
            
          });
        }, icon:const Icon(Icons.refresh))
      ],),
      body: Container(child: FutureBuilder(
        future:_firebaseFirestore.collection("Contact").orderBy("name").get(),
        builder: (c,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          List contacts = snapshot.data!.docs as List;
          
         return ListView.builder(
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (c,index){
          return Card(
                margin: EdgeInsets.all(12),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(contacts[index]["name"]
                          .substring(0,1)
                          .toString()
                          .toUpperCase(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                    title: Text(contacts[index]['name']),
                    subtitle: Text(contacts[index]['email']),
                    trailing: IconButton(onPressed: (){
                      _firebaseFirestore.collection("Contact").doc(contacts[index].id).delete();
                      //_firebaseFirestore.collection("Contact").doc(contacts[index].id).update({"name":"jehova"});
                      setState(() {
                        
                      });
                     print(contacts[index].id);


                    },icon: Icon(Icons.delete),),

                   
                  ),
                ),
              );

          });
        },
        ),),


      floatingActionButton: FloatingActionButton(onPressed: (){
        var route = MaterialPageRoute(builder: (b)=>Register());
        Navigator.push(context, route);
      },child: Icon(Icons.add,color: Colors.white,),),
    );
  }
}

