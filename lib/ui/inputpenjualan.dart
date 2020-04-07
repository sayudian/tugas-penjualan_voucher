import  'package:flutter/material.dart';
import  'package:hello_world/models/penjualan.dart';
import  'package:intl/intl.dart';
import  'package:datetime_picker_formfield/datetime_picker_formfield.dart'; 

class  InputPenjualan  extends  StatefulWidget  {
  final  Penjualan  penjualan; 
  InputPenjualan(this.penjualan);
  @override
  _InputPenjualanState  createState()  =>  _InputPenjualanState(this.penjualan);
}

class  _InputPenjualanState  extends  State<InputPenjualan>  {
  Penjualan  penjualan;
  _InputPenjualanState(this.penjualan);
  TextEditingController  nameController=TextEditingController();
  TextEditingController  keteranganController  =TextEditingController(); 
  TextEditingController  jumlahController  =  TextEditingController(); 
  TextEditingController  tanggalController  =  TextEditingController(); 
  final  format=DateFormat('yyyy-MM-dd');
  @override
  Widget  build(BuildContext  context) {
    if(penjualan  !=  null){
      nameController.text=penjualan.name; 
      keteranganController.text=penjualan.keterangan; 
      jumlahController.text=penjualan.jumlah; 
      tanggalController.text=penjualan.tanggal;
      }
      return  Scaffold( 
        appBar:  AppBar(
          title:  penjualan==null?Text("Transaksi  Baru"):Text("Update  Transaksi"), 
          leading:  Icon(Icons.keyboard_arrow_left),
        ),
          body:  Padding(
            padding:  EdgeInsets.only(
              top:  15.0,left:  10.0,  right:  10.0
          ),
          child:  ListView( 
            children:  <Widget>[
              Padding(
                padding:  EdgeInsets.all(10.0),
                child:  TextField(
                  controller:  nameController, 
                  keyboardType:  TextInputType.text,
                  decoration:  InputDecoration(
                  labelText:  "Nama",
                  border:  OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(3.0)
                  ),
                ),
              onChanged:  (value){

              },
              ),
            ),
              Padding(
                padding:  EdgeInsets.all(10.0), 
                child:  TextField(
                  controller:  jumlahController,
                  keyboardType:  TextInputType.number, decoration:  InputDecoration(
                  labelText:  "Jumlah", 
                  border:  OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(3.0)
                    ),
                  ),
                onChanged:  (value){

                },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(10.0), 
                child:  TextField(
                  controller:  keteranganController, 
                  keyboardType:  TextInputType.text, 
                  decoration:  InputDecoration(
                    labelText:  "Keterangan", 
                    border:  OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(3.0)
                    ),
                  ),
                onChanged:  (value){

                },
                ),
              ),
              Padding(
                padding:  const  EdgeInsets.all(10.0), 
                child:  Column(
                  children:  <Widget>[
                    DateTimeField(
                      controller:  tanggalController, 
                      format:  format,
                      onShowPicker:  (context,  currentValue){ 
                        return  showDatePicker(
                          context:  context, 
                          firstDate:  DateTime(2020),
                          initialDate:  currentValue??DateTime.now(), 
                          lastDate:  DateTime(2045)
                        );
                      },
              decoration:  InputDecoration( 
                labelText:  "Tanggal", 
                border:  OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(3.0)
                ),
              )
            )
          ],
        ),
      ),
              Padding(
                padding:  EdgeInsets.all(10.0), 
                child:  Row(
                  children:  <Widget>[
                  Expanded(
                    child:  RaisedButton(
                      color:  Theme.of(context).primaryColorDark, 
                      textColor:  Theme.of(context).primaryColorLight, 
                      child:  Text("Simpan",  textScaleFactor:  1.5,), 
                      onPressed:  (){
                      if(penjualan  ==  null){
                        penjualan=Penjualan(nameController.text,  keteranganController.
                        text,    jumlahController.text,  tanggalController.text);
                        }else{
                          penjualan.name=nameController.text; 
                          penjualan.keterangan=keteranganController.text; 
                          penjualan.jumlah=jumlahController.text; 
                          penjualan.tanggal=tanggalController.text;
                          print("ini  Update  ya");
                        }
                      Navigator.pop(context,  penjualan);
                    },
                  ),
                ),
                Container(width:  5.0,), 
                Expanded(
                  child:  RaisedButton(
                    color:  Theme.of(context).primaryColorDark, 
                    textColor:  Theme.of(context).primaryColorLight, 
                    child:  Text("Batal",  textScaleFactor:  1.5,), 
                    onPressed:  (){
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        )
      ],
    ),
  ),
);
}
}