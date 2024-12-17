import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 var formKey = GlobalKey<FormState>();
  var emailCtr = TextEditingController();
  var nameCtr = TextEditingController();
  var phoneCtr = TextEditingController();
  var PasswordCrt =  TextEditingController();

 

  
  void alert(msg){
    AlertDialog alertDialog = AlertDialog(
      title: const Text("staus"),
      content: Container(
        height: 200,
        child: Center(child: Text(msg),),),
    );

    showDialog(context: context, builder: (g){
      return alertDialog;

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar:AppBar(
          title: Text("Create a new Member and Firbae Auth")
        ),
        body:Container(
          padding:EdgeInsets.all(20),
          child: Card(
          child: Container(
            padding:EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: nameCtr,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                         validator: (value){
                        if(value!.isEmpty){
                          return "Please fill this field";
                        }
                      },
                      
                    ),
                    
                  ),

                   Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: phoneCtr,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),

                         validator: (value){
                        if(value!.isEmpty){
                          return "Please fill this field";
                        }
                      },
                      
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value){
                        final bool emailValid = 
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value!);
                        if(!emailValid){
                          return "Invalid email";
                        }
                      },
                      controller: emailCtr,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: PasswordCrt,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),

                         validator: (value){
                        if(value!.isEmpty){
                          return "Please fill this field";
                        }
                      },
                      
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: MaterialButton(onPressed: ()async{

                      if(formKey.currentState!.validate()){
                        print(emailCtr.text);
                        print(PasswordCrt.text);


                      try{
                          firebaseAuth.createUserWithEmailAndPassword(email: emailCtr.text, password: PasswordCrt.text);
                          alert("Successfully Register");

                          FirebaseFirestore.instance.collection("Contact").add({
                            "name":nameCtr.text,
                        "phone": phoneCtr.text,
                        "email": emailCtr.text,
                        "password": PasswordCrt.text

                          });
                          formKey.currentState!.reset();
                      }on FirebaseAuthException catch(e){
                        alert(e.code.toString());
                      }


                      }
                    },
                    child:  Text("Save"),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    )
                  )


            ],),),),
          ),

        )
      )
    );
  
  }
}
