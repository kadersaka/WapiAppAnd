import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:wap_i/pages/AddAnnounce.dart';
import 'package:wap_i/pages/ShowMyAnnounces.dart';
import 'package:wap_i/pages/WellcomePage.dart';


import 'login_page.dart';




class ProfilePage extends StatefulWidget{

  ProfilePage({Key key , this.title}) : super(key : key);
  final String title;

  @override
  ProfilePageState  createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  DatabaseHelper databaseHelper = new DatabaseHelper();
  
  _save(String token, String name, String email, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    prefs.setString('name', name);
    prefs.setString('phone', phone);
    prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Profil Page',
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
                    builder: (BuildContext context) => new WellcomePage(),
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
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          backgroundColor: Colors.green,
         onPressed: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new AddAnnounce(),
              )
          ),
        ),
        body: new FutureBuilder<List>(
          future: databaseHelper.getMyAnnonces(),
          builder: (context ,snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(list: snapshot.data)
                : new Center(child: new CircularProgressIndicator(),);
          },
        )
      ),
    );
  }


}

class ItemList extends StatelessWidget {

  List list;
  
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: list==null?0:list.length,
        itemBuilder: (context,i){
        return new Container(
          padding: const EdgeInsets.all(3.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ShowMyAnnounces(list:list , index:i,) ),

            ) ,
            child: 
             Card(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                     ListTile(
                      
                     leading: CircleAvatar(
                     backgroundImage: (list[i]['type'] == "achat") ? AssetImage('assets/images/buy.png') : AssetImage('assets/images/sale.png'),
                     foregroundColor: Colors.green,
                     backgroundColor: Colors.green[200],
                   ),
                     //leading: Icon(Icons.album),
                      title: new Text(list[i]['type'].toString().toUpperCase()+' - '+list[i]['nom'].toString().toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,),),
                      subtitle: new Text('Quantité : ${list[i]['quantite']} '+list[i]['unite']+'\nDate: '+ list[i]['created_at']), 

                     /* subtitle: new RichText(
                          text: TextSpan(
                            text: list[i]['type'].toString().toUpperCase()+"\n",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: 'Quantité: ', ),
                              TextSpan(text: list[i]['quantite']),
                            ],
                          ),
                      ), */
                      isThreeLine: true,
                      trailing:  IconButton(
                        icon: Icon(Icons.send),
                        tooltip: 'Enregistrer',
                        color: Colors.green,
                        onPressed: () {
                        },
                      ),
                       
                   ),
                   
                 /*  
                   ButtonBar(
                     children: <Widget>[
                    
                       
                       FlatButton(
                         child: Icon(
                           Icons.send,
                           color: Colors.green[600],
                         ),
                         onPressed: () { /* ... */ },
                       ),
                     ],
                   ),*/
                 ],
               ),
             )

          ),
        );

        }
    );
  }

}
