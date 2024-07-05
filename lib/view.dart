import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sql/record_update.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}


class _ViewDataState extends State<ViewData> {

@override
  void initState() {
  getrecord();
    super.initState();
  }

  List userdata=[];

Future<void> getrecord() async{
 String url="http://192.168.100.26/practice_api/view_data.php";

 try{
var response=await http.get(Uri.parse(url));
setState(() {
  
 userdata=jsonDecode(response.body);
});
 }
 catch(e){print(e);}
}

//
Future<void> delrecord(String id)async {
  try{
String url="http://192.168.100.26/practice_api/delete_data.php";

var res= await http.post(Uri.parse(url),body: {
 "id":id
});

var response=jsonDecode(res.body);
if(response["success"]=="true"){

  print("record delete");
  getrecord();
}else{
print("some issues");
}
  }
  catch(e){print(e);}
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('View Data'),),
    body: ListView.builder(
    itemCount: userdata.length,
    itemBuilder: (context,index){
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordUpdate(userdata[index]["uname"],userdata[index]["uemail"],userdata[index]["upassword"],)));},
        title: Text(userdata[index]["uname"]),
        subtitle: Text(userdata[index]["uemail"]),
        trailing:IconButton(onPressed: (){
          delrecord(userdata[index]["uid"]);
        }, icon:Icon(Icons.delete),
)
      ),
    );
  
    }

    ),
    
    
    );
  }
}