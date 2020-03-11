import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/pages/ProfilePage.dart';
import 'package:wap_i/pages/WellcomePage.dart';
import 'package:wap_i/utils/constants.dart';

class AddAnnounce extends StatefulWidget{

  AddAnnounce({Key key , this.title}) : super(key : key);
  final String title;



  @override
  AddAnnounceState  createState() => AddAnnounceState();
}

class AddAnnounceState extends State<AddAnnounce> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

 // Default Radio Button Item
  String radioItem = 'vente';
  String radioUnite = 'vente';

  // Group Value for Radio Button.
  int id = 1;
   
   final globalKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();

  }


  List<TypeList> fList = [
    TypeList(
      index: 1,
      name: "achat",
    ),
    TypeList(
      index: 2,
      name: "vente",
    )
  ];

  List<TypeList> uniteList = [
    TypeList(
      index: 1,
      name: "Kg",
    ),
    TypeList(
      index: 2,
      name: "Tonne",
    ),
    TypeList(
      index: 3,
      name: "Litre",
    )
  ];
  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.DATA_SAVE);

  /*List<String> _locations = ['achat', 'vente']; // Option 2
  String _selectedLocation ; // Option 2*/


  final TextEditingController _nomController = new TextEditingController();
  final TextEditingController _quantiteController = new TextEditingController();

  final TextEditingController _uniteController = new TextEditingController();
  final TextEditingController _lieuController = new TextEditingController();

  final TextEditingController _prixController = new TextEditingController();
  final TextEditingController _typeController = new TextEditingController();

  String _myActivity = "Kg";
  String _myActivityResult;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Add Product',
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
                "Nouvelle annonce",
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.w400),
              ),

            ),
          ],
        ),

        ),
        body: Stack(
          key: globalKey,
          children:<Widget>[ Center(
            //, progressDialog
            child: ListView(
              padding: const EdgeInsets.only(top: 12,left: 12.0,right: 12.0,bottom: 12.0),
              children: <Widget>[
                Container(
                  height: 60,
                  child: new TextField(
                  //  cursorColor: Colors.purple,
                    controller: _nomController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusColor: Colors.purple,
                      labelText: 'Nom',
                      hintText: 'Nom du produit',
                      icon: FaIcon(FontAwesomeIcons.productHunt),
                    ),
                  ),
                    margin: EdgeInsets.only(bottom: 20.0)
                ),

                Container(
                  height: 60,
                  child: new TextField(
                    controller: _lieuController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.purple,
                      labelText: 'Lieux',
                      hintText: 'Ex: Parakou',
                      icon: FaIcon(FontAwesomeIcons.mapMarked),
                    ),
                  ),
                    margin: EdgeInsets.only(bottom: 20.0)
                ),

              /*  Container(
                    height: 60,
                  child: new TextField(
                    controller: _uniteController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Unité',
                      hintText: 'Ex: Kg',
                      icon: new Icon(Icons.info),
                    ),
                  ),
                    margin: EdgeInsets.only(bottom: 20.0)
                ),
                */
                Container(
                  padding: EdgeInsets.all(1),
                  child: DropDownFormField(
                    titleText: 'Unité',
                    hintText: 'Veuillez choisir',
                    value: _myActivity,
                    onSaved: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity = value;
                        print('value select:');
                        print(_myActivity);
                      });
                    },
                    dataSource: [
                      {
                        "display": "Kg",
                        "value": "Kg",
                      },
                      {
                        "display": "Tonne",
                        "value": "Tonne",
                      },
                      {
                        "display": "Litre",
                        "value": "Litre",
                      },

                      {
                        "display": "Autre",
                        "value": "Autre",
                      },


                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),


                Container(
                    height: 60,
                  child: new TextField(

                    controller: _prixController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                   //   border: BorderSide(color: Colors.purple),

                     /* focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue, width: 3.0),
                      ),*/
                      //focusColor: Colors.purple,
                     // fillColor: Colors.purple,
                      //hoverColor: Colors.purple,
                      labelText: 'Prix par unité ('+_myActivity+')',
                      hintText: '5000000',
                    // labelStyle: TextStyle(color: Colors.purple, decorationColor: Colors.purple),
                     // hintStyle: TextStyle(decorationColor: Colors.purple, ),

                      icon: FaIcon(FontAwesomeIcons.moneyBillAlt),
                    ),
                  ),
                    margin: EdgeInsets.only(bottom: 20.0)
                ),



                Container(
                    height: 60,
                  child: new TextField(
                    controller: _quantiteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantité',
                      hintText: '500',
                      icon: new Icon(Icons.play_for_work),
                    ),
                  ),
                    margin: EdgeInsets.only(bottom: 20.0)
                ),

                Container(
                    child: Text('Type d\'annonce '),
                    margin: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0)
                ),

               Container(
                 child: Row(
                   children:fList.map((data) => Expanded(
                     child: RadioListTile(
                       activeColor: Colors.green,
                       title: Text("${data.name}"),
                       groupValue: id,
                       value: data.index,
                       onChanged: (val) {
                         setState(() {
                           radioItem = data.name ;
                           id = data.index;
                           print(data.name);
                             });
                           },
                         ),
                   ),
                  ).toList(),
                 ),
                   //margin: EdgeInsets.only(bottom: 10.0)
               ),


   /*             Container(
                    //height: 350.0,
                    child: Column(
                      children:fList.map((data) => RadioListTile(
                        activeColor: Colors.green,
                          title: Text("${data.name}"),
                          groupValue: id,
                          value: data.index,
                          onChanged: (val) {
                            setState(() {
                              radioItem = data.name ;
                              id = data.index;
                              print(data.name);
                            });
                          },
                        ),
                      ).toList(),
                    ),
                  ),
               */
                Container(
                  height: 50,
                  child: new RaisedButton(
                    onPressed: (){
                          FocusScope.of(context).requestFocus(new FocusNode());
                      //    progressDialog.showProgress();

                      databaseHelper.addAnnonce(_nomController.text.trim(), _lieuController.text.trim(), _prixController.text.trim().toString(), _quantiteController.text.trim().toString(), _myActivity.trim(),radioItem.toString()).whenComplete(() {
                            ;
                            print('statut from addannonce');
                            print(databaseHelper.status.toString()
                            );
                            if (databaseHelper.status.toString() == 'true') {
                              //  progressDialog.hideProgress();
                              print('data saved from addAnnounce rdata is;');
                              print(databaseHelper.rData);
                              setState(() {
                                Fluttertoast.showToast(
                                    msg: 'Votre annonce a été publiée',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.deepPurple,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (
                                          BuildContext context) => new ProfilePage(),
                                    )
                                );
                            //    progressDialog.hideProgress();
                              });
                            } else {
                              setState(() {
                                Fluttertoast.showToast(
                                    msg: 'Erreur -Veuillez vérifier votre connexion internet!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.redAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                                print(
                                    'Error registering data from AddAnnounce');
                                progressDialog.hideProgress();
                             //   print(databaseHelper.rData);
                              });
                            }
                      });
                    },
                    color: Colors.green[600],
                    child: new Icon(Icons.thumb_up,
                            color: Colors.white,

//                      style: new TextStyle(
//                          color: Colors.white,
//                         // backgroundColor: Colors.blue
//                        ),
                      ),
                  ),
                ),
                // progressDialog
              ],
            ),
          ),
          ],

        ),
      ),
    );
  }

}

class TypeList {
  String name;
  int index;
  TypeList({this.name, this.index});
}













