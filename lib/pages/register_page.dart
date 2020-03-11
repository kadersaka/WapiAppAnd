
import 'package:flutter/material.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/pages/TrainingHomePage.dart';
import 'package:wap_i/pages/login_page.dart';
import 'package:wap_i/utils/constants.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key , this.title, @required this.req}) : super(key : key);
  final String title;
  final Map req;

  @override
  createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_REGISTER);

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  TextEditingController nameController = new TextEditingController(text: "");

  //TextEditingController phoneController = new TextEditingController(text: "");

  TextEditingController emailController = new TextEditingController(text: "");

  TextEditingController passwordController =  new TextEditingController(text: "");

  var user = Map();


//------------------------------------------------------------------------------

  bool isValidEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

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
                  _nameContainer(),
//------------------------------------------------------------------------------
     //             _phoneContainer(),
//------------------------------------------------------------------------------
                  _emailContainer(),
//------------------------------------------------------------------------------
                  _passwordContainer(),
//------------------------------------------------------------------------------
                  _registerButtonContainer(),
//------------------------------------------------------------------------------
                  _loginNowLabel(),
//------------------------------------------------------------------------------
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _nameContainer() {
    return new Container(
        child: new TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.face,
                  color: Colors.brown,
                ),
                labelText: Texts.NAME,
                labelStyle: TextStyle(fontSize: 18.0)),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 5.0));
  }

//------------------------------------------------------------------------------
//  Widget _phoneContainer() {
//    return new Container(
//        child: new TextFormField(
//            controller: phoneController,
//            decoration: InputDecoration(
//                suffixIcon: new Icon(
//                  Icons.phone,
//                  color: Colors.brown,
//                ),
//                labelText: Texts.PHONE,
//                labelStyle: TextStyle(fontSize: 18.0)),
//            keyboardType: TextInputType.text),
//        margin: EdgeInsets.only(bottom: 5.0));
//  }

//------------------------------------------------------------------------------
  Widget _emailContainer() {
    return new Container(
        child: new TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.email,
                  color: Colors.brown,
                ),
                labelText: Texts.EMAIL,
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
  Widget _loginNowLabel() {
    return new GestureDetector(
      onTap: _goToLoginScreen,
      child: new Container(
          child: new Text(
            Texts.LOGIN_NOW,
            style: TextStyle(fontSize: 18.0, color: Colors.brown),
          ),
          margin: EdgeInsets.only(bottom: 30.0)),
    );
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

  _onPressed(){
    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();
   // setState(() {
    print('la req = ');
    print(widget.req);
      if(emailController.text.trim().toLowerCase().isNotEmpty &&  passwordController.text.trim().isNotEmpty && widget.req['phone'].trim().isNotEmpty  && widget.req['code'].trim().isNotEmpty &&  nameController.text.trim().isNotEmpty  ){
        if (!isValidEmail(emailController.text)) {
          globalKey.currentState.showSnackBar(new SnackBar(
            content: new Text(SnackBarText.ENTER_VALID_MAIL),
          ));
          return;
        }
       // databaseHelper.checkUser(nameController.text.trim(), phoneController.text.trim() ,emailController.text.trim().toLowerCase(), passwordController.text.trim()).whenComplete((){
          databaseHelper.registerData(nameController.text.trim(), widget.req['phone'].trim(), emailController.text.trim().toLowerCase(), passwordController.text.trim(), widget.req['code']).whenComplete((){
            print('registerData called from registration page: ');
            print('statut: ');
          print(databaseHelper.status);
          if(databaseHelper.status){
            //_showDialog();
            print('error registering');
            setState(() {
              globalKey.currentState.showSnackBar(new SnackBar(
               //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
                content: new Text(databaseHelper.rData.toString()),
              ));
              progressDialog.hideProgress();
            });
            msgStatus = 'Check email or password';
          }else{
            //Navigator.pushReplacementNamed(context, '/dashboard');
            print('user registered successfully');
            setState(() {
              // AppSharedPreferences.setUserLoggedIn(true);
              //  AppSharedPreferences.setUserProfile(eventObject.object);
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
//              ));
              progressDialog.hideProgress();
              user['name'] = nameController.text.trim();
              user['phone'] = widget.req['phone'].trim();
              user['email'] = emailController.text.trim();
              user['password'] = passwordController.text.trim();
              print(user);
             _goToHomeScreen();
            });
          }
        });
      }
      else{
        globalKey.currentState.showSnackBar(new SnackBar(
          //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
          content: new Text('Vous devez remplir tous les champs'),
        ));
        setState(() {
          progressDialog.hideProgress();

        });
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


//------------------------------------------------------------------------------
//  void _registerButtonAction() {
//    if (nameController.text == "") {
//      globalKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(SnackBarText.ENTER_NAME),
//      ));
//      return;
//    }
//
//    if (phoneController.text == "") {
//      globalKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(SnackBarText.ENTER_PHONE),
//      ));
//      return;
//    }
//
//    if (emailController.text == "") {
//      globalKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(SnackBarText.ENTER_EMAIL),
//      ));
//      return;
//    }
//
//    if (!isValidEmail(emailController.text)) {
//      globalKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(SnackBarText.ENTER_VALID_MAIL),
//      ));
//      return;
//    }
//
//    if (emailController.text == "") {
//      globalKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(SnackBarText.ENTER_EMAIL),
//      ));
//      return;
//    }
//
//    if (passwordController.text == "") {
//      globalKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(SnackBarText.ENTER_PASS),
//      ));
//      return;
//    }
//    FocusScope.of(context).requestFocus(new FocusNode());
//    progressDialog.showProgress();
//    //_registerUser(nameController.text, emailController.text, passwordController.text);
//
//  }

//------------------------------------------------------------------------------
//  void _registerUser(String name, String emailId, String password) async {
//    EventObject eventObject = await registerUser(name, emailId, password);
//    switch (eventObject.id) {
//      case EventConstants.USER_REGISTRATION_SUCCESSFUL:
//        {
//          setState(() {
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.REGISTER_SUCCESSFUL),
//            ));
//            progressDialog.hideProgress();
//            _goToLoginScreen();
//          });
//        }
//        break;
//      case EventConstants.USER_ALREADY_REGISTERED:
//        {
//          setState(() {
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.USER_ALREADY_REGISTERED),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//      case EventConstants.USER_REGISTRATION_UN_SUCCESSFUL:
//        {
//          setState(() {
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.REGISTER_UN_SUCCESSFUL),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//      case EventConstants.NO_INTERNET_CONNECTION:
//        {
//          setState(() {
//            globalKey.currentState.showSnackBar(new SnackBar(
//              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
//            ));
//            progressDialog.hideProgress();
//          });
//        }
//        break;
//    }
//  }


}
