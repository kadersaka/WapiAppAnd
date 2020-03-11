import 'package:flutter/material.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:wap_i/pages/ProfilePage.dart';


class EditAnnounce extends StatefulWidget{

  List list;
  int index;
  EditAnnounce({this.index , this.list}) ;


  @override
  EditAnnounceState  createState() => EditAnnounceState();
}

class EditAnnounceState extends State<EditAnnounce> {
  DatabaseHelper databaseHelper = new DatabaseHelper();


    TextEditingController _nameController  ;
    TextEditingController _priceController  ;

  @override
  void initState(){
        _nameController = new TextEditingController(text: widget.list[widget.index]['name']);
        _priceController = new TextEditingController(text: widget.list[widget.index]['price']);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Update Announce',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Update Announce'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Product Name',
                    icon: new Icon(Icons.email),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Place your price',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                height: 50,
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.editData(widget.list[widget.index]['id']
                        , _nameController.text.trim(), _priceController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new ProfilePage(),
                        )
                    );
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Update',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),




            ],
          ),
        ),
      ),
    );
  }



  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Erreur'),
            content:  new Text('Vérifiez votre email et votre mot de passe'),
            actions: <Widget>[
              new RaisedButton(

                child: new Text(
                  'Fermer',
                ),

                onPressed: (){
                  Navigator.of(context).pop();
                },

              ),
            ],
          );
        }
    );
  }



}















