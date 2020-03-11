import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/futures/app_futures.dart';
import 'package:wap_i/models/base/EventObject.dart';
import 'package:wap_i/pages/StartRegister.dart';
import 'package:wap_i/pages/TrainingHomePage.dart';
import 'package:wap_i/pages/WellcomePage.dart';
import 'package:wap_i/utils/app_shared_preferences.dart';
import 'package:wap_i/utils/constants.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {



  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    if(value != 0){
      //_goToRegisterScreen();
      //go to home page
      print('read appelé à partir de login page, token est:');
      print(value);
     // globalKey.currentState.showSnackBar(new SnackBar(
      //  content: new Text(SnackBarText.LOGGED_SUCCESSFUL),
     // ));
      _goToHomeScreen();
    }
    else{
      print('read appelé à partir de login page, aucune donnée trouvée:');
      print(value);
    }
  }

  @override
  initState(){
    super.initState();
    read();
  }

  final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_LOG_IN);

  TextEditingController emailController = new TextEditingController(text: "");

  TextEditingController passwordController =  new TextEditingController(text: "");

  String phoneNum;

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[_loginContainer(), progressDialog],
        ));
  }

//------------------------------------------------------------------------------
  Widget _loginContainer() {
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
        height: 100.0,
        width: 100.0,
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
                 // _emailContainer(),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                      setState(() {
                        phoneNum = int.parse(number.phoneNumber).toString();
                        print ('phoneNum is: ');
                        print(phoneNum);
                      });


                    },
                    isEnabled: true,
                    autoValidate: true,
                    formatInput: false,
                    initialCountry2LetterCode: 'BJ',
                    ignoreBlank: true,
                    onInputValidated: (bool value) {
                      print(value);
                      // getPhoneNumber(PhoneNumber number)
                      //phoneNUm = int.parse(number.ph)
/*
                        setState(() {
                         // mynum = PhoneNumber number;
                        phoneNum = int.parse(number.phoneNumber);
                      });
*/

                    },
                  ),
        /*          SizedBox(
                    height: 20.0,
                  ),
*/
//------------------------------------------------------------------------------
                  _passwordContainer(),
//------------------------------------------------------------------------------
                  _loginButtonContainer(),
//------------------------------------------------------------------------------
                  _registerNowLabel(),
//------------------------------------------------------------------------------
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _emailContainer() {
    return new Container(
        child: new TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.phone,
                  color: Colors.brown,
                ),
                labelText: Texts.PHONE,
                labelStyle: TextStyle(fontSize: 18.0)),
            keyboardType: TextInputType.emailAddress),
        margin: EdgeInsets.only(bottom: 20.0));
  }

//------------------------------------------------------------------------------
  Widget _passwordContainer() {
    return new Container(
        child: new TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
              suffixIcon: new Icon(
                Icons.vpn_key,
                color: Colors.brown,
              ),
              labelText: Texts.PASSWORD,
              labelStyle: TextStyle(fontSize: 18.0)),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        margin: EdgeInsets.only(bottom: 35.0));
  }

//------------------------------------------------------------------------------
  Widget _loginButtonContainer() {
    return new Container(
        width: double.infinity,
        decoration: new BoxDecoration(color: Colors.green[600]),
        child: new MaterialButton(
          textColor: Colors.white,
          padding: EdgeInsets.all(15.0),
        //  onPressed: _loginButtonAction,
          onPressed: _onPressed,
          child: new Text(
            Texts.LOGIN,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ),
        margin: EdgeInsets.only(bottom: 30.0));
  }

//------------------------------------------------------------------------------
  Widget _registerNowLabel() {
    return new GestureDetector(
      onTap: _goToRegisterScreen,
      child: new Container(
          child: new Text(
            Texts.REGISTER_NOW,
            style: TextStyle(fontSize: 18.0, color: Colors.brown),
          ),
          margin: EdgeInsets.only(bottom: 30.0)),
    );
  }

//------------------------------------------------------------------------------
  void _loginButtonAction() {
    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.ENTER_EMAIL),
      ));
      return;
    }

    if (passwordController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.ENTER_PASS),
      ));
      return;
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();
    _loginUser(emailController.text, passwordController.text);
  }

//------------------------------------------------------------------------------
  void _loginUser(String id, String password) async {
    EventObject eventObject = await loginUser(id, password);
    switch (eventObject.id) {
      case EventConstants.LOGIN_USER_SUCCESSFUL:
        {
          setState(() {
            AppSharedPreferences.setUserLoggedIn(true);
            AppSharedPreferences.setUserProfile(eventObject.object);
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
            _goToHomeScreen();
          });
        }
        break;
      case EventConstants.LOGIN_USER_UN_SUCCESSFUL:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
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

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  _onPressed() {
    // setState(() {
    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();
if(phoneNum != null){
    if (phoneNum
        .trim()
        .toLowerCase()
        .isNotEmpty && passwordController.text
        .trim()
        .isNotEmpty) {
      databaseHelper.loginData(phoneNum.trim(), passwordController.text.trim())
          .whenComplete(() {
        if (databaseHelper.status) {
          //  _showDialog();
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
          });
          msgStatus = 'Check email or password';
        } else {
          //Navigator.pushReplacementNamed(context, '/dashboard');
          setState(() {
            // AppSharedPreferences.setUserLoggedIn(true);
            //  AppSharedPreferences.setUserProfile(eventObject.object);
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
            _goToHomeScreen();
          });
        }
      });
    }
    else {
      globalKey.currentState.showSnackBar(new SnackBar(
        //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
        content: new Text('Vous devez remplir tous les champs'),
      ));
      setState(() {
        progressDialog.hideProgress();
      });
    }
  }
  else {
  globalKey.currentState.showSnackBar(new SnackBar(
  //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
  content: new Text('Vous devez remplir tous les champs'),
  ));
  setState(() {
  progressDialog.hideProgress();
  });
  }

    //  });
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


}
