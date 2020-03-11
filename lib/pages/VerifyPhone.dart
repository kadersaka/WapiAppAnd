
import 'package:flutter/material.dart';
import 'package:wap_i/pages/StartRegister.dart';
import 'package:wap_i/pages/TrainingHomePage.dart';
import 'package:wap_i/pages/login_page.dart';
import 'package:wap_i/pages/register_page.dart';
import 'package:wap_i/utils/constants.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPhone extends StatefulWidget {
  VerifyPhone({Key key , this.title, @required this.user}) : super(key : key);
  final String title;
  final Map user;

  @override
  createState() => new VerifyPhoneState();
}

class VerifyPhoneState extends State<VerifyPhone> {
  final globalKey = new GlobalKey<ScaffoldState>();


  //ProgressDialog progressDialog = ProgressDialog.getProgressDialog('Enregistrement en cours....');

  DatabaseHelper databaseHelper = new DatabaseHelper();

  String msgStatus = '';

  TextEditingController codeController = new TextEditingController(text: "");
  int a = 0;
  var req = Map();
  @override
//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
  //  print(widget.user);
    return new Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[_verifyContainer(), /*progressDialog*/],
        ));
  }

//------------------------------------------------------------------------------
  Widget _verifyContainer() {
    return new Container(
        child: new ListView(
          children: <Widget>[
            new Center(
              child: new Column(
                children: <Widget>[
//------------------------------------------------------------------------------
                  _appIcon(),
//------------------------------------------------------------------------------
                  _formContainer(),
//------------------------------------------------------------------------------
                ],
              ),
            ),
          ],
        ));
  }

//------------------------------------------------------------------------------
  Widget _appIcon() {
    return new Container(
      // decoration: new BoxDecoration(color: Colors.blue[400]),
      child: new Image(
        image: new AssetImage("assets/images/ic_launcher.png"),
        height: 170.0,
        width: 170.0,
      ),
      margin: EdgeInsets.only(top: 20.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _formContainer() {
    return new Container(
      child: new Form(
          child: new Theme(
              data: new ThemeData(primarySwatch: Colors.brown),
              child: new Column(
                children: <Widget>[
//------------------------------------------------------------------------------
                  _codeContainer(),
//------------------------------------------------------------------------------
                  _registerButtonContainer(),
//------------------------------------------------------------------------------
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _codeContainer() {
    return new Container(
        child: new TextFormField(
            controller: codeController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.vpn_key,
                  color: Colors.green,
                ),
                labelText: Texts.CODE,
                labelStyle: TextStyle(fontSize: 18.0)),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 20.0));
  }

//------------------------------------------------------------------------------
  Widget _registerButtonContainer() {
    return new Container(
        width: double.infinity,
        decoration: new BoxDecoration(color: Colors.green[600]),
        child: new MaterialButton(
          textColor: Colors.white,
          padding: EdgeInsets.all(15.0),
          onPressed: _onPressed,
          child: new Text(
            Texts.REGISTER,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ),
        margin: EdgeInsets.only(bottom: 30.0));
  }

//------------------------------------------------------------------------------

  void _goToLoginScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }
//------------------------------------------------------------------------------
  void _goToHomeScreen() {
    //  Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new HomePage()),);
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new TrainingHomePage()),
    );
  }

//------------------------------------------------------------------------------

  bool isValidEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

//------------------------------------------------------------------------------
  void _goToRegisterScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new RegisterPage(req: req)),
    );
  }
//------------------------------------------------------------------------------
  void _goToStartRegisterScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new StartRegister()),
    );
  }
//------------------------------------------------------------------------------
  _onPressed(){
    FocusScope.of(context).requestFocus(new FocusNode());
 //   progressDialog.showProgress();
    print('a = $a');
   // setState(() {
      if(a>3){
        setState(() {
         // a++;
          print('dans if (a>3) a = $a');
          globalKey.currentState.showSnackBar(new SnackBar(
            //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
            content: new Text(SnackBarText.INVALID_CODE),
          ));
     //     progressDialog.hideProgress();
          _goToStartRegisterScreen();
        });
      }

      if (codeController.text.trim().isNotEmpty && widget.user['phone'].trim().isNotEmpty) {
        databaseHelper.verifySms(codeController.text.trim(), widget.user['phone'].trim()).whenComplete((){
          a++;
          print('After database.helper.verify sms we have a++ and now a = $a');
          if(!databaseHelper.status){
           // _showDialog();
            msgStatus = 'Wrong code';
            setState(() {
              globalKey.currentState.showSnackBar(new SnackBar(
                //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
                content: new Text(SnackBarText.INVALID_CODE),
              ));
        //      progressDialog.hideProgress();
            });
          }else{
            setState(() {
              print('code vérifié, va essayer de transmettre le numero et le code a la page register ');

              req['code'] = codeController.text.trim();
              req['phone'] = widget.user['phone'].trim();
              print('req = ');
              print(req);
              //progressDialog.hideProgress();
              _goToRegisterScreen();
            });
//            if (widget.user['name']
//                .trim()
//                .isNotEmpty && widget.user['password']
//                .trim()
//                .isNotEmpty && widget.user['phone']
//                .trim()
//                .isNotEmpty && widget.user['email']
//                .trim()
//                .isNotEmpty) {
//              if (!isValidEmail(widget.user['email'].trim())) {
//                globalKey.currentState.showSnackBar(new SnackBar(
//                  content: new Text(SnackBarText.ENTER_VALID_MAIL),
//                ));
//              //  return;
//                _goToRegisterScreen();
//              }
//              databaseHelper.registerData(
//                  widget.user['name'].trim(), widget.user['phone'].trim(),
//                  widget.user['email'].trim().toLowerCase(),
//                  widget.user['password'].trim(), codeController.text.trim()).whenComplete(() {
//                    print('Statu register Data after verifying');
//                    print(databaseHelper.status);
//                if (databaseHelper.status.toString() == 'true') {
//
//                  //_showDialog();
//                  setState(() {
//                    globalKey.currentState.showSnackBar(new SnackBar(
//                      //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
//                      content: new Text(databaseHelper.rData.toString()),
//                    ));
//                    progressDialog.hideProgress();
//                  });
//                  _goToRegisterScreen();
//                  msgStatus = 'Check email or password';
//                } else {
//                  //Navigator.pushReplacementNamed(context, '/dashboard');
//                  setState(() {
//                    print('utilisateur enregistré');
//                    // AppSharedPreferences.setUserLoggedIn(true);
//                    //  AppSharedPreferences.setUserProfile(eventObject.object);
//                    globalKey.currentState.showSnackBar(new SnackBar(
//                      content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
//                    ));
//                    progressDialog.hideProgress();
//                    _goToHomeScreen();
//                  });
//                }
//              });
            //}
            // Navigator.pushReplacementNamed(context, '/dashboard');
//            setState(() {
//              // AppSharedPreferences.setUserLoggedIn(true);
//              //  AppSharedPreferences.setUserProfile(eventObject.object);
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
//              ));
//              progressDialog.hideProgress();
//              _goToHomeScreen();
//            });

          }
        });
      }
      else{
        globalKey.currentState.showSnackBar(new SnackBar(
          //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
          content: new Text('Vous devez remplir tous les champs'),
        ));
      }

    //   });
  }



  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content:  new Text('Check your email or password'),
            actions: <Widget>[
              new RaisedButton(

                child: new Text(
                  'Close',
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





  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    if(value != 0){
      //_goToRegisterScreen();
      //go to home page
      print(value);
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.LOGGED_SUCCESSFUL),
      ));
      _goToHomeScreen();
    }
  }

  @override
  initState(){
    read();
  }




}
