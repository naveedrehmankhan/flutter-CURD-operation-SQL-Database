import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:sql/view.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

TextEditingController name=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();
//final _formkey = GlobalKey<FormState>();


Future<void> insertdata() async {
  
  if(name.text != "" && email.text != "" && password.text != "")
  {
  try{
   var uri="http://192.168.100.26/practice_api/insert_record.php";

    var res=await http.post(Uri.parse(uri), body: {
      "name": name.text,
      "email": email.text,
      "password":password.text,
    });

    var response=jsonDecode(res.body);
  
    if(response["success"]=="true")
    {
      print("Record Insert");
      name.text= "";
      email.text= "";
      password.text="";
    }else{
      print("some isssue");
    }
  }
  catch(e){
    print(e);
  }
  }else{
    print('Please Fill All Fields');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Connect MySql Database'),),
      body:
      //  Form(
      //   key: _formkey,
      //   child:
         Column(children: [
          Container(margin: EdgeInsets.all(10),
          child: TextFormField(
             controller: name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label:Text('Enter a Name')
            ),
          ),
          
          ),
            Container(margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label:Text('Enter a Email')
            ),
          ),
          
          ),
            Container(margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: password,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label:Text('Enter a Password')
            ),
          ),
          
          ),
          Container(margin: EdgeInsets.all(10),
          child: ElevatedButton(onPressed: (){insertdata();},child: Text('insert Data'),),),
             Container(margin: EdgeInsets.all(10),
          child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: ((context) => ViewData())));},child: Text('View Data'),),),
        ],),
   //   ),
    );
  }
}


