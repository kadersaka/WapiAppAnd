import 'package:flutter/material.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:wap_i/pages/ProfilePage.dart';

import 'EditAnnounce.dart';

class ShowMyAnnounces extends StatefulWidget{

  List list;
  int index;
  ShowMyAnnounces({this.index , this.list}) ;


  @override
  ShowMyAnnouncesState  createState() => ShowMyAnnouncesState();
}

class ShowMyAnnouncesState extends State<ShowMyAnnounces> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Mes Annonces',
      home: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[600],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new ProfilePage(),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(
                "Annonces",
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.w400),
              ),

            ),
          ],
        ),

        ),



        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[

              Container(
                height: 50,
                child: new Text(
                 "Nom : ${widget.list[widget.index]['nom']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(
                  padding: new EdgeInsets.only(top: 44.0),
                ),

              Container(
                height: 50,
                child: new Text(
                  " Addresse : ${widget.list[widget.index]['lieu']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

//String nom , String lieu,  String  prix, String quantite, String unite, String type
              Container(
                height: 50,
                child: new Text(
                  " Prix : ${widget.list[widget.index]['prix']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),


              Container(
                height: 50,
                child: new Text(
                  " Quantité : ${widget.list[widget.index]['quantite']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),


              Container(
                height: 50,
                child: new Text(
                  " Unite : ${widget.list[widget.index]['unite']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),


              Container(
                height: 50,
                child: new Text(
                  " Offre : ${widget.list[widget.index]['type']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new EditAnnounce(list:widget.list , index:widget.index),
                        )
                    ) ,
                    color: Colors.green,
                    child: new Text(
                      'Edit',
                      style: new TextStyle(
                        color: Colors.white,
                      ),),
                  ),
                ),

                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: (){
                      databaseHelper.deleteData(widget.list[widget.index]['id']);
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new ProfilePage(),
                          )
                      );
                    },
                    color: Colors.blue,
                    child: new Text(
                      'Delete',
                      style: new TextStyle(
                        color: Colors.red,
                      ),),
                  ),
                ),
              ],
            )
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















