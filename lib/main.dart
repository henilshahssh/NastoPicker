import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:np_3/ListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> data2;
  String data = "Add an item";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringList2();
  }

  getStringList2() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      data2 = prefs.getStringList(ListPageState().listKey) ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(child: Center(child: Text("Drawer Header")),decoration: BoxDecoration(color: Colors.blue),),
      //       ListTile(title: Text("Whole nasto list"),onTap: () async {
      //         Navigator.pop(context);
      //         final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
      //         if(result){
      //           setState(() {
      //             getStringList2();
      //           });
      //         }
      //       },),
      //     ],
      //   ),
      // ),
      appBar: AppBar(title: Text("Nasto Picker"),centerTitle: true,actions: [
        IconButton(icon: Icon(Icons.edit), onPressed: () async {
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
          if(result){
            setState(() {
              getStringList2();
            });
          }
        })
      ],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.all(40.0),
              child: Text(data, style: TextStyle(fontSize: 30),),
            ),
            Container(height: 100,),
            ButtonTheme(
              minWidth: 100,
              height: 45,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: (){

                  if(data2!=null && data2.length>0){
                    var randomNum = random.nextInt(data2.length);
                    setState(() {
                      data = data2[randomNum] ?? "Null";
                    });
                  }

                  },
                child: Text("Pick",style: TextStyle(color: Colors.white,fontSize: 20),),color: Colors.deepOrange,),
            )
          ],
        ),
      ),
    );
  }

}
