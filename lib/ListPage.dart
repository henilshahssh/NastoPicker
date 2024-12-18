import 'dart:math';

import 'package:flutter/material.dart';
import 'package:np_3/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  TextEditingController textEditingController = TextEditingController();
  // ignore: deprecated_member_use
  List<String> dataList = [];
  String listKey = "listKey";

  @override
  void initState() {
    super.initState();
    getStringList();
  }

  getStringList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dataList = prefs.getStringList(listKey) ?? [];
    });
  }

  void storeStringList(List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listKey, list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Page"),centerTitle: true,actions: [
        IconButton(icon: Icon(Icons.check), onPressed: (){
          Navigator.pop(context,true);
        }),
      ],automaticallyImplyLeading: false,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: dataList.length ?? 1,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: (){},
                  leading: Icon(Icons.emoji_food_beverage_rounded,color: Colors.deepOrange,),
                  trailing: IconButton(icon: Icon(Icons.remove,color: Colors.deepOrange,),onPressed: (){

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete this item?"),
                            actions: [
                              FlatButton(onPressed: (){
                                Navigator.pop(context);
                              },
                                  child: Text("Cancel")),
                              FlatButton(onPressed: (){
                                setState(() {
                                  dataList.remove(dataList[index]);
                                  storeStringList(dataList);
                                });
                                  Navigator.pop(context);
                                }, child: Text("Delete")),
                            ],
                          );
                        });

                  },),
                  title: Text(dataList[index] ?? "Null"),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.emoji_food_beverage_rounded,color: Colors.deepOrange,),
              trailing: IconButton(icon: Icon(Icons.add,color: Colors.deepOrange,),onPressed: (){
                saveDialog();
              },),
              title: Text("...",style: TextStyle(color: Colors.deepOrange),),
            ),
          ),
        ],
      ),
    );
  }

  void saveDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add an item?"),
            content: TextField(
              style: TextStyle(fontSize: 20),
              controller: textEditingController,
            ),
            actions: [
              FlatButton(onPressed: (){
                Navigator.pop(context);
                textEditingController.clear();
              },
                  child: Text("Cancel")),
              FlatButton(onPressed: (){
                  setState(() {
                    if (textEditingController.text.isNotEmpty){
                      dataList.add(textEditingController.text);
                      storeStringList(dataList);
                    }
                  });
                  Navigator.pop(context);
                  textEditingController.clear();
                }, child: Text("Save")),
            ],
          );
        });
  }

}
