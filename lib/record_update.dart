import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RecordUpdate extends StatefulWidget {
  //const RecordUpdate({super.key});
 
  String name;
  String email;
  String password;
  RecordUpdate(this.name,this.email,this.password);

  @override
  State<RecordUpdate> createState() => _RecordUpdateState();
}

class _RecordUpdateState extends State<RecordUpdate> {

TextEditingController name=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();

@override
  void initState() {
  name.text=widget.name;
  email.text=widget.email;
  password.text=widget.password;
    super.initState();
  }

Future<void> updaterecord()async{
try{

 String url="http://192.168.100.26/practice_api/update_data.php";
 
 var res= await http.post(Uri.parse(url),body: {
    
    "name":name.text,
    "password":password.text,
    "email":email.text,

 });

 var response=jsonDecode(res.body);

 if(response["success"]=="true")
 {

  print("update");
 }else{
  print("some issue");
 }


}catch(e){print(e);}

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Record'),
      ),
      body: Column(children: [
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
          child: ElevatedButton(onPressed: (){updaterecord();},child: Text('Update'),),),
      ],),
    );
  }
}