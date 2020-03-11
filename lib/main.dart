import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wap_i/pages/WellcomePage.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/pages/StartRegister.dart';
import 'package:wap_i/utils/constants.dart';

void main(){
  runApp(new MaterialApp(
    theme: ThemeData(fontFamily: 'Andika'),
    home: new WapiApp(),
  ));
}
class WapiApp extends StatefulWidget {
  _WapiAppState createState() => new _WapiAppState();
  final globalKey = new GlobalKey<ScaffoldState>();
}

class _WapiAppState extends State<WapiApp> {
  @override
  Widget build(BuildContext context) {

    return new SplashScreen(
      seconds: 1,

     navigateAfterSeconds: new AfterSplashPage(),
 //     navigateAfterSeconds: new HomePage(),
      title: new Text('world app for poor’s incomes ',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
      image: Image.asset("assets/images/ic_launcher.png"),
    //  image: new Image.network('https://flutter.io/images/catalog-widget-placeholder.png'),
     // gradientBackground: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Wapi"),
      loaderColor: Colors.red[700],
    );
  }
}

class AfterSplashPage extends StatefulWidget {
  @override
  createState() => new AfterSplashPageState();
}

class AfterSplashPageState extends State<AfterSplashPage> {

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final id_key = 'id';
    final value = prefs.get(key ) ?? 0;
    if(value != 0){
      //_goToRegisterScreen();
      //go to home page
      print('read appelé à partir de login page, token est:');
      print(value);
      print('id est :' );
      print(prefs.get(id_key));
      // globalKey.currentState.showSnackBar(new SnackBar(
      //  content: new Text(SnackBarText.LOGGED_SUCCESSFUL),
      // ));
      _goToHomeScreen();
      //_goToTrainScreen();
    }
    else{
      print('read appelé à partir de login page, aucune donnée trouvée:');
      print(value);
      _goToRegisterScreen();
    }
  }
//------------------------------------------------------------------------------
  void _goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new WellcomePage()),
    );
  }


//------------------------------------------------------------------------------
  void _goToRegisterScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new StartRegister()),
    );
  }
//------------------------------------------------------------------------------

  @override
  initState(){
    read();
    super.initState();

  }

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_LOG_IN);

  final globalKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
  return Text('');
  }

}
