
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wap_i/customviews/progress_dialog.dart';
import 'package:wap_i/pages/StartRegister.dart';
import 'package:wap_i/pages/WellcomePage.dart';
import 'package:wap_i/pages/login_page.dart';
import 'package:wap_i/pages/register_page.dart';
import 'package:wap_i/utils/constants.dart';
import 'package:wap_i/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';

class HelpRequest extends StatefulWidget {
  HelpRequest({Key key , this.title}) : super(key : key);
  final String title;
  //final Map user;

  @override
  createState() => new HelpRequestState();
}

class HelpRequestState extends State<HelpRequest> {
  final globalKey = new GlobalKey<ScaffoldState>();


  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_REGISTER);

  DatabaseHelper databaseHelper = new DatabaseHelper();

  String msgStatus = '';
  String phpEndPoint = '';

  TextEditingController objectController = new TextEditingController(text: "");
  TextEditingController resumeController = new TextEditingController(text: "");


 // File file;
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Erreur de chargement de l\'image';

  /*void _choose() async {
    file = (await ImagePicker.pickImage(source: ImageSource.camera)) ;
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }*/

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
    setStatus('');
  }
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post('192.168.0.1', body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Erreur de choix de photo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),

          );
        } else {
          return const Text(
            'Vous devez prendre une photo avant d\'envoyer les informations',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          );
        }
      },
    );
  }
 /* void _upload() {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    http.post(phpEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }*/

  int a = 0;
  var req = Map();
//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //  print(widget.user);
    return new Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
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
                  "Quitter",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.w400),
                ),

              ),
            ],
          ),

        ),
       /* body: new Stack(
          children: <Widget>[_verifyContainer(), progressDialog],
        ));*/
      body: new Container(
        padding: EdgeInsets.all(30.0),
        child: ListView(
       //   crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),

            //------------------------------------------------------------------
            Center(child:Text('Faites la photo et décrivez votre problème'
            )
            ),
            _photoContainer(),
//------------------------------------------------------------------------------
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //------------------------------------------------------------------------------
            _objectContainer(),
//------------------------------------------------------------------------------
            _resumeContainer(),
//------------------------------------------------------------------------------

            _registerButtonContainer(),
            progressDialog

          ],

        ),
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
           //       _appIcon(),
//------------------------------------------------------------------------------
                  _formContainer(),

//------------------------------------------------------------------------------
         /*         file == null
                      ? Text('No Image Selected')
                      :  Image.file(file)*/
                  SizedBox(
                    height: 20.0,
                  ),
                  showImage(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

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
                  _objectContainer(),
//------------------------------------------------------------------------------
                  _resumeContainer(),
//------------------------------------------------------------------------------
                  _photoContainer(),
//------------------------------------------------------------------------------
                  _registerButtonContainer(),
//------------------------------------------------------------------------------
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _objectContainer() {
    return new Container(
        child: new TextFormField(
            controller: objectController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.info_outline,
                  color: Colors.green,
                ),
                labelText: 'Objet',
                labelStyle: TextStyle(fontSize: 18.0)),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 20.0));
  }
//------------------------------------------------------------------------------
  Widget _resumeContainer() {
    return new Container(
        child: new TextFormField(
            controller: resumeController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.help_outline,
                  color: Colors.green,
                ),
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 18.0)),
            keyboardType: TextInputType.multiline),
        margin: EdgeInsets.only(bottom: 20.0));
  }

//------------------------------------------------------------------------------
  Widget _photoContainer() {
    return new Container(
    child: RaisedButton(
      color: Colors.green,
      onPressed: chooseImage,
      child: Icon(Icons.photo_camera, color: Colors.white,),
    ),
        margin: EdgeInsets.only(bottom: 20.0)
    );
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
          child: new Text('Envoyer',
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
      new MaterialPageRoute(builder: (context) => new WellcomePage()),
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
    progressDialog.showProgress();
    print('a envoyer button pressed');

    //if (objectController.text.trim().isNotEmpty && resumeController.text.trim().isNotEmpty && widget.user['phone'].trim().isNotEmpty) {
    //  databaseHelper.verifySms(objectController.text.trim(), widget.user['phone'].trim()).whenComplete((){
    if(objectController.text.trim().isNotEmpty && resumeController.text.trim().isNotEmpty){
      setStatus('Téléchargement de l\'image...');
      if (null == tmpFile) {
        setStatus(errMessage);
        setState(() {
          globalKey.currentState.showSnackBar(new SnackBar(
            //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
            content: new Text('image non valide - prenez en une autre'),
          ));
          progressDialog.hideProgress();
        });
        return;
      }
      Timer(Duration(seconds: 10), () {
        print("Yeah, this line is printed after 10 seconds");
        setState(() {
          globalKey.currentState.showSnackBar(new SnackBar(
            content: new Text('Données envoyées'),
          ));
        });
        /*  String fileName = tmpFile.path.split('/').last;
       databaseHelper.sendHelpRequest(objectController.text.trim(), resumeController.text.trim(), fileName, base64Image).whenComplete((){

      print(databaseHelper.status);
      if(databaseHelper.status.toString() == 'true'){
        //_showDialog();
        setStatus('Erreur de l\'image...');
        print('error saving help');
        setState(() {
          globalKey.currentState.showSnackBar(new SnackBar(
            //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
            content: new Text(databaseHelper.rData.toString()),
          ));
          progressDialog.hideProgress();
        });
      }else{
        //Navigator.pushReplacementNamed(context, '/dashboard');
        print('helprequest registered successfully from helprequest');
        setState(() {
          // AppSharedPreferences.setUserLoggedIn(true);
          //  AppSharedPreferences.setUserProfile(eventObject.object);
//              globalKey.currentState.showSnackBar(new SnackBar(
//                content: new Text(SnackBarText.LOGIN_SUCCESSFUL),
//              ));
          _goToHomeScreen();
        });
      */
      });

/*    Timer(Duration(seconds: 2), () {
      print("Yeah, this line is printed after 2 seconds");
      setState(() {
        _goToHomeScreen();
      });
    });*/
  }
    else{
      globalKey.currentState.showSnackBar(new SnackBar(
        //content: new Text(SnackBarText.LOGIN_UN_SUCCESSFUL),
        content: new Text('Vous devez remplir le formulaire'),
      ));
      progressDialog.hideProgress();
    }

  }








  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    if(value != 0){
      //_goToRegisterScreen();
      //go to home page
      print(value);
    /*  globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.LOGGED_SUCCESSFUL),
      ));
      _goToHomeScreen();*/
    }
  }
  readPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key ) ?? 0;
    print('read phone: $value');
    String phone = prefs.getString('phone');
    return phone;
  }

  readName() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'name';
    final value = prefs.get(key ) ?? 0;
    print('read name: $value');

  }



  @override
  initState(){
    read();


  }




}
