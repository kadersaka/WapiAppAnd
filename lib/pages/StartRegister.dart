
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/pages/VerifyPhone.dart';
import 'package:wap_i/pages/TrainingHomePage.dart';
import 'package:wap_i/pages/login_page.dart';
import 'package:wap_i/utils/constants.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartRegister extends StatefulWidget {
  StartRegister({Key key , this.title}) : super(key : key);
  final String title;

  @override
  createState() => new StartRegisterState();
}

class StartRegisterState extends State<StartRegister> {
  final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_REGISTER);

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';
 
  TextEditingController phoneController = new TextEditingController(text: "");

  var user = Map();
  String phoneNum;

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[_loginContainer(), progressDialog],
        ),
    );
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
                //  _phoneContainer(),
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
                  SizedBox(
                    height: 20.0,
                  ),

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
  Widget _phoneContainer() {
    return new Container(
        child: new TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.phone,
                  color: Colors.brown,
                ),
                labelText: Texts.PHONE,
                labelStyle: TextStyle(fontSize: 18.0)),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 25.0));
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
  void _goToVerifyScreen() {
    //  Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new HomePage()),);
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new VerifyPhone(user: user)),
    );
  }
//------------------------------------------------------------------------------

  _onPressed() {
    //  setState(() {
    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();
    if(phoneNum != null){
    if (phoneNum
        .trim()
        .isNotEmpty) {
      // databaseHelper.checkUser(nameController.text.trim(), phoneController.text.trim() ,emailController.text.trim().toLowerCase(), passwordController.text.trim()).whenComplete((){
      databaseHelper.checkUser(phoneNum.trim()).whenComplete(() {
        print('statut: ');
        print(databaseHelper.status);
        if (databaseHelper.status.toString() == 'true') {
          //_showDialog();
          setState(() {
            print('error checking account - account may not be available');
            globalKey.currentState.showSnackBar(new SnackBar(
              //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
              content: new Text(databaseHelper.rData.toString()),
            ));
            progressDialog.hideProgress();
            msgStatus = '';
          });
        } else {
          //Navigator.pushReplacementNamed(context, '/dashboard');
          setState(() {
            // AppSharedPreferences.setUserLoggedIn(true);
            //  AppSharedPreferences.setUserProfile(eventObject.object);
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
//              ));
            print('user account checked successfully');
            progressDialog.hideProgress();
            user['phone'] = phoneNum.trim();
            print(user);
            _goToVerifyScreen();
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

    // });
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
