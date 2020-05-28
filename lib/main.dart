import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
import 'package:flutter_database/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLlite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('SQLlite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              height: 50,
              width: 200,
              margin: EdgeInsets.all(10),
              child : RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            ),
           
           Container(
             height: 50,
              width: 200,
              margin: EdgeInsets.all(10),
             child: RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
           ),


            Container(
              height: 50,
              width: 200,
               margin: EdgeInsets.all(10),
             child:  RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
           ),


            Container(
              height: 50,
              width: 200,
               margin: EdgeInsets.all(10),
             child:  RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
           ),


            
           
           
          ],
        ),
      ),
    );
  }
  
  // Button onPressed methods
  
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnAge  : 23
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}