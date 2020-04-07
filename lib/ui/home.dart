import  'package:flutter/material.dart';
import  'package:hello_world/ui/inputpenjualan.dart'; 
import  'package:hello_world/models/penjualan.dart'; 
import  'package:hello_world/helpers/dbhelper.dart';
import  'package:sqflite/sqflite.dart'; 
import  'dart:async';

class  Home  extends  StatefulWidget  { 
  @override
  _HomeState  createState()  =>  _HomeState();
}

class  _HomeState  extends  State<Home>  { 
  DbHelper  dbHelper  =  DbHelper();
  int  count  =  0;
  List<Penjualan>  penjualanList;

  @override
  Widget  build(BuildContext  context)  { 
    if  (penjualanList  ==  null)  {
      penjualanList  =  List<Penjualan>();
    }
    return  Scaffold( appBar:  
    AppBar(
      title:  Text('Kedai Nanu'), 
      leading:  Icon(Icons.store),
    ),

    body:  createListView(),
    floatingActionButton:  FloatingActionButton(
      child:  Icon(Icons.add), 
      tooltip:  'Input  Penjualan', 
      onPressed:  ()  async  {
        var  penjualan  =  await  navigateToEntryForm(context,null);
        if(penjualan  !=  null)  addPenjualan(penjualan);
      },
    ),
  );
}

  Future<Penjualan>  navigateToEntryForm(BuildContext  context,  Penjualan  penjualan)  async
{
    var  result  =  await  Navigator.push( 
      context,
        MaterialPageRoute(
          builder:  (BuildContext  context){ 
            return  InputPenjualan(penjualan);
        }
      )
    );
    return  result;
  }
ListView  createListView()  {
  TextStyle  textStyle  =  Theme.of(context).textTheme.subhead;
  return  ListView.builder(
    itemCount:  count,
    itemBuilder:  (BuildContext  context,  int  index)  {
  return  Card(
    color:  Colors.white, 
    elevation:  2.0,
    child:  ListTile(
      title:  Text(this.penjualanList[index].name,  
      style:  textStyle,), 
      subtitle:  Row(
        children:  <Widget>[ 
          Text(this.penjualanList[index].tanggal),
          Text("  |  Rp.  "+this.penjualanList[index].jumlah,  style:  TextStyle(fontWeight:  FontWeight.bold),),
        ],
      ),
      
      trailing:  GestureDetector( 
        child:  Icon(Icons.delete), 
        onTap:  ()  {
          deletePenjualan(penjualanList[index]);
        },
      ),

      onTap:  ()  async  {
        var  penjualan  =  await  navigateToEntryForm(context,  this.penjualanList[index]);

        if  (penjualan  !=  null)  editPenjualan(penjualan);
        
      },
    ),
  );
},
);
}

void  addPenjualan(Penjualan  object)  async  { 
  int  result  =  await  dbHelper.insert(object);
    if(result  >  0){ 
      updateListView();
    }
  }

void  editPenjualan(Penjualan  object)  async{ 
  int  result  =  await  dbHelper.update(object);
    if(result>0){ 
      updateListView();
      print("ini  editPenjualan  RESULT  $result");
    }
  }

void  deletePenjualan(Penjualan  object)  async{ 
  int  result  =  await  dbHelper.delete(object.id);
    if(result>0){ 
      updateListView();
    }
  }

void  updateListView(){
  final  Future<Database>  dbFuture  =  dbHelper.initDb(); 
  dbFuture.then((datatabase){
    Future<List<Penjualan>>  penjualanListFuture=dbHelper.getPenjualanList(); 
    penjualanListFuture.then((penjualanList){
      setState(()  {
        this.penjualanList=penjualanList; 
        this.count=penjualanList.length;
        });
      });
    });
  }
}