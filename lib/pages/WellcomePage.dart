import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/pages/CompanyHomePage.dart';
import 'package:wap_i/pages/HelpRequest.dart';
import 'package:wap_i/pages/MarketHomePage.dart';
import 'package:wap_i/pages/MenageHomePage.dart';
import 'package:wap_i/pages/TrainingHomePage.dart';
import 'package:wap_i/utils/constants.dart';
import 'package:wap_i/values/values.dart' as values;


import 'AddAnnounce.dart';
import 'ProfilePage.dart';
import 'ShowMyAnnounces.dart';

class WellcomePage extends StatefulWidget {
  @override
  createState() => new WellcomePageState();
}

class WellcomePageState extends State<WellcomePage> with SingleTickerProviderStateMixin{
  final globalKey = new GlobalKey<ScaffoldState>();
Map user;
  String userPhone;
  String userName;

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_REGISTER);
  DatabaseHelper databaseHelper = new DatabaseHelper();


//------------------------------------------------------------------------------
   _goToHelpRequestScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => HelpRequest()),
    );
  }
//------------------------------------------------------------------------------
  void _goToAddAnnounceScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new AddAnnounce()),
    );
  }
//------------------------------------------------------------------------------
  int date = DateTime.now().day;
  static int m = DateTime.now().month;
  String month = values.months[m];
  int year = DateTime.now().year;


  GlobalKey _bottomNavigationKey = GlobalKey();
  final TrainingHomePage _trainingHomePage = new TrainingHomePage();
  final MenageHomePage _menageHomePage = new MenageHomePage();
  final MarketHomePage _marketHomePage = new MarketHomePage();

  Future <String>   readPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key ) ?? 0;
    print('read phone: $value');
    String phone = prefs.getString('phone');
    return phone;
  }

 Future <String> readName() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'name';
    final value = prefs.get(key ) ?? 0;
    print('read name: $value');
    return value;

  }
  var _fabMiniMenuItemList;

  void updateName(String name){
    setState(() {
      this.userName = name;
     // this.user['name'] = name;
    });
    print('name:$userName');
  }

  void updatePhone(String phone){
    setState(() {
      this.userPhone = phone;
     // this.user['phone'] = phone;
    });
  }

  @override
  void initState(){
    readName().then(updateName);
    readPhone().then(updatePhone);
    _tabController = new TabController(length: 2, vsync: this);


//    userName = readName();
//    userPhone = readPhone();
 //   donwloadFile();
     super.initState();
  }




  Widget _showPage = new WellcomePage();

   _pageChooser(int pg){
    switch(pg){
      case 0:
     return    Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new WellcomePage()),
        );       // return _showPage;
        //return _showPage;
        break;
      case 1:
       return  Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new TrainingHomePage()),
        );       // return _showPage;
        break;
      case 2:
       // return _companyHomePage;
      return new CompanyHomePage();
        break;
      case 3:
      return  Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new MenageHomePage()),
        );       // return _showPage;
      //  return _menageHomePage;
        break;
      case 4:
      return  Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new MarketHomePage()),
        );       // return _showPage;
       // return _marketHomePage;
        break;
      default:
     return   Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new WellcomePage()),
        );       // return _showPage;
    }
  }

        TabController _tabController;
        AnimationController ipController;
        Animation ipAnimation;
        AnimationController conController;
        Animation conAnimation;

        String pdfUrl ='https://www.undp.org/content/dam/undp/library/corporate/UNDP-in-action/2014/UNDP_AR2014_french.pdf';
        bool isDownloadling = false;
        var progressString = '';

        Future <void> donwloadFile() async{
          Dio dio = Dio();
          var dir = await getApplicationDocumentsDirectory();
          try{
            await dio.download(pdfUrl, '${dir.path}/mypdf.pdf', onReceiveProgress: (rec, total){
              print('Rec: $rec, Total: $total');
              setState(() {
                isDownloadling = true;
                progressString = ((rec/total)*100).toStringAsFixed(0)+' %';
              });
            });
          }
          catch(e){
            print(e);
          }

          setState(() {
            isDownloadling = false;
            progressString = 'Download completed';
          });
          print('Download completed');

        }
          
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
            var childButtons = List<UnicornButton>();

            childButtons.add(UnicornButton(
                hasLabel: true,
                labelText: "Demander une aide",
                currentButton: FloatingActionButton(
                  heroTag: "help",
                  backgroundColor: Colors.purple,
                  mini: true,
                  child: Icon(Icons.help_outline),
                  onPressed: () {
                    _goToHelpRequestScreen();
                  },
                )));

            childButtons.add(UnicornButton(
                hasLabel: true,
                labelText: "Publier une annonce",
                currentButton: FloatingActionButton(
                  heroTag: "notification",
                  backgroundColor: Colors.purple,
                  mini: true,
                  child: Icon(Icons.notifications_active),
                  onPressed: () {
                    _goToAddAnnounceScreen();
                  },
                )));

            return MaterialApp(
              title: 'Profil Page',
              key: globalKey,
              home: Scaffold(

                floatingActionButton: UnicornDialer(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
                    parentButtonBackground: Colors.purple,
                    orientation: UnicornOrientation.VERTICAL,
                    parentButton: Icon(Icons.add),
                    childButtons: childButtons),


                appBar: new AppBar(

                  backgroundColor: Colors.green[600],
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Text(
                          "ANNONCES",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: -1.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child:  IconButton(
                            icon: Icon(Icons.account_circle),
                            onPressed: ()=>Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (BuildContext context) => new ProfilePage(),
                                )
                            ),
                        ),
                    ),
                  ],
                  bottom: TabBar(
                    unselectedLabelColor: Colors.grey[300],
                    labelColor: Colors.white,
                    tabs: [
                    //  new Tab(icon: FaIcon(FontAwesomeIcons.blind),),
                      new Tab(icon: FaIcon(FontAwesomeIcons.moneyBillWave),),
                      new Tab(icon: FaIcon(FontAwesomeIcons.commentsDollar),),
                   //   new Tab(icon: new Icon(Icons.assistant_photo),)
                    ],
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,),
                  bottomOpacity: 1,

                ),



                body:
                /*Stack(
                  children:<Widget>[ */
                    TabBarView(

                      children: [
                     /*   new FutureBuilder<List>(
                          future: databaseHelper.getVentes(),
                          builder: (context ,snapshot){
                            if(snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? new ItemList(list: snapshot.data)
                                : new Center(child: new CircularProgressIndicator(),);
                          },
                        ),*/
                        new FutureBuilder<List>(
                            future: databaseHelper.getAchats(),
                            builder: (context ,snapshot){
                              if(snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                  ? new ItemList(list: snapshot.data)
                                  : new Center(child: new CircularProgressIndicator(),);
                            },
                          ),
                        new FutureBuilder<List>(
                          future: databaseHelper.getVentes(),
                          builder: (context ,snapshot){
                            if(snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? new ItemList(list: snapshot.data)
                                : new Center(child: new CircularProgressIndicator(),);
                          },
                        ),

                   ],
                    controller: _tabController,
                  ),




                bottomNavigationBar: ConvexAppBar.badge({0: '', 1: '', 2: '', 3:''},
        key: _bottomNavigationKey,
        backgroundColor: Colors.green[600],
        initialActiveIndex: 0,

        items: [
          TabItem(icon: Icons.notifications_active, title: 'Home'),
          TabItem(icon: Icons.people, title: 'Formation'),
          TabItem(icon: Icons.business_center, title: 'Entreprise'),
          TabItem(icon: Icons.home, title: 'Menage'),
      /*  //  TabItem(icon: FaIcon(FontAwesomeIcons.gamepad), title: 'Annonces'),
          TabItem(icon: Icons.notifications_active, title: 'Home'),
          TabItem(icon: FaIcon(FontAwesomeIcons.chalkboardTeacher, color: Colors.white,), title: 'Formation'),
          TabItem(icon: FaIcon(FontAwesomeIcons.building, color: Colors.white,), title: 'Entreprise'),
          TabItem(icon: FaIcon(FontAwesomeIcons.home, color: Colors.white,), title: 'Menage'),
         // TabItem(icon: Icons.monetization_on, title: 'Marché'),
          //  TabItem(icon: Icons.settings, title: 'Paramètres'),*/
        ],
        //  onTap: (int i) => print('click index=$i'),
        //onTap: (int i) => _pageChooser(i),
        onTap: (int i){
          //setState(() {
          print('click index=$i');
          _pageChooser(i);
          //});
        },
      ),
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
          /*child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ShowMyAnnounces(list:list , index:i,) ),

            ) ,*/
            child: 
             Card(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                     ListTile(
                      
                     leading: CircleAvatar(
                 //      backgroundImage: FaIcon(FontAwesomeIcons.commentsDollar),
                       //icon: FaIcon(FontAwesomeIcons.commentsDollar),
                       backgroundImage: (list[i]['type'] == "achat") ? AssetImage('assets/images/buy.png') : AssetImage('assets/images/sale.png'),
                      // backgroundImage: (list[i]['type'] == "achat") ? Icons. : AssetImage('assets/images/sale.png'),
                     foregroundColor: Colors.green,
                     backgroundColor: Colors.purple[200],
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
                        color: Colors.purple,
                        onPressed: () {_showToast(context);
                        },
                      ),
                       
                   ),
                 ],
               ),
             )

         // ),
        );

        }
    );
  }
  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Votre requête a été enregistré', style: TextStyle(color: Colors.green),),
        action: SnackBarAction(
            label: 'Fermer', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.red,),
      ),
    );
  }

}

