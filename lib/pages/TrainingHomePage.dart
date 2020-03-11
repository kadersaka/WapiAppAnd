import 'dart:async';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wap_i/models/Bai.dart';
import 'package:http/http.dart' as http;

import 'package:wap_i/models/VideoItemModel.dart';
import 'package:wap_i/pages/WapiPdf.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:wap_i/pages/WapiPdfFromFile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'CompanyHomePage.dart';
import 'MarketHomePage.dart';
import 'MenageHomePage.dart';
import 'WellcomePage.dart';


 import 'package:native_pdf_view/native_pdf_view.dart';


class TrainingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyTrainingHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class MyTrainingHomePage extends StatefulWidget {
  @override
  _MyTrainingHomePageState createState() => new _MyTrainingHomePageState();
}

class _MyTrainingHomePageState extends State<MyTrainingHomePage> with SingleTickerProviderStateMixin{
  final globalKey = new GlobalKey<ScaffoldState>();


  GlobalKey _bottomNavigationKey = GlobalKey();


  Widget _showPage = new WellcomePage();

  void _pageChooser(int pg){
    switch(pg){
      case 0:
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new WellcomePage()),
        );       // return _showPage;
        //return _showPage;
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new TrainingHomePage()),
        );       // return _showPage;

        break;
      case 2:
      // return _companyHomePage;
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new CompanyHomePage()),
        );       // return _showPage;
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new MenageHomePage()),
        );       // return _showPage;
        //  return _menageHomePage;
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new MarketHomePage()),
        );       // return _showPage;
        // return _marketHomePage;
        break;
      default:
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new WellcomePage()),
        );       // return _showPage;
    }

  }


  Future<PDFDocument> _getDocument(String uri) async {
   // if (await _hasSupportPdfRendering()) {
      return PDFDocument.openAsset(uri);
   /* } else {
      throw Exception(
        'PDF Rendering does not '
            'support on the system of this version',
      );
    }*/
  }

  /*Future<bool> _hasSupportPdfRendering() async {
    final deviceInfo = DeviceInfoPlugin();
    bool hasSupport = false;
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      hasSupport = int.parse(iosInfo.systemVersion.split('.').first) >= 11;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      hasSupport = androidInfo.version.sdkInt >= 21;
    }
    return hasSupport;
  }*/

  YoutubePlayerController _controller;
  @override
  void dispose() {
    if (_controller != null) _controller.dispose();

    if(_tabController != null) _tabController.dispose();

    super.dispose();
  }

  var mais = [
    VideoItemModel("MAÎS - Le semis", "A la découverte de la Ganni, HIstorique et origine de la célébration", "assets/images/youtube_play_button_big.jpg", "https://www.youtube.com/watch?v=PgR6cJbXqqw&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=1"),
    VideoItemModel("MAÎS - Entretien", "Par cour du guerrier, de sa naissance puis son asce,ssion au trone à ses combats", "assets/images/youtube_three.jpg",  "https://www.youtube.com/watch?v=KJK-9PZdBZw&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=2"),
    VideoItemModel("MAÎS - Recolte", "Légende ou vérité, venez à la découverte du palais Béninois des pythons", "assets/images/youtube_two.jpg",  "https://www.youtube.com/watch?v=-JB8so2U44Q&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=3"),
    VideoItemModel("MAÎS - La conservation", "A la découverte de la Ganni, HIstorique et origine de la célébration", "assets/images/youtube_play_button_big.jpg", "https://www.youtube.com/watch?v=kq3sjVq4zU0&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=10"),
    VideoItemModel("MAÎS - Le tri", "Par cour du guerrier, de sa naissance puis son asce,ssion au trone à ses combats", "assets/images/youtube_three.jpg",  "https://www.youtube.com/watch?v=jgP3uiZYUSU&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=11"),
    VideoItemModel("MAÎS - Le marché", "Légende ou vérité, venez à la découverte du palais Béninois des pythons", "assets/images/youtube_two.jpg",  "https://www.youtube.com/watch?v=0a8eeH3oYmQ&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=12")
  ];

  var sorgho = [
    VideoItemModel("MAÎS - Le semis", "A la découverte de la Ganni, HIstorique et origine de la célébration", "assets/images/youtube_play_button_big.jpg", "https://www.youtube.com/watch?v=2IJLvgF8vEI&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=4"),
    VideoItemModel("MAÎS - Entretien", "Par cour du guerrier, de sa naissance puis son asce,ssion au trone à ses combats", "assets/images/youtube_three.jpg",  "https://www.youtube.com/watch?v=JPx1c5HWScQ&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=5"),
    VideoItemModel("MAÎS - Recolte", "Légende ou vérité, venez à la découverte du palais Béninois des pythons", "assets/images/youtube_two.jpg",  "https://www.youtube.com/watch?v=-Tgm1KJDP9k&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=6")
  ];

  var cajoux = [
    VideoItemModel("MAÎS - Le semis", "A la découverte de la Ganni, HIstorique et origine de la célébration", "assets/images/youtube_play_button_big.jpg", "https://www.youtube.com/watch?v=2_vPRfVMPE8&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=7"),
    VideoItemModel("MAÎS - Entretien", "Par cour du guerrier, de sa naissance puis son asce,ssion au trone à ses combats", "assets/images/youtube_three.jpg",  "https://www.youtube.com/watch?v=jaLm9_YgEvM&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=8"),
    VideoItemModel("MAÎS - Recolte", "Légende ou vérité, venez à la découverte du palais Béninois des pythons", "assets/images/youtube_two.jpg",  "https://www.youtube.com/watch?v=xusH299VCpI&list=PLZldeVTLmOaS4d2tPaspLW7Jldd7Ay_ew&index=9")
  ];

  TabController _tabController;

//  @override
//  void initState() {
//    _tabController = new TabController(length: 3, vsync: this);
//    //_getDoc();
//    // ignore: unnecessary_statements
//  //  _getAssetDoc;
//    super.initState();
//  }

  final pdfUrl = "https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip";
  bool isDownloadling = true;
  bool fileExit = false;
  var progressString = "";

  Future <void> downloadFile() async{
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    try{
      await dio.download(pdfUrl, '${dir.path}/baobab2.pdf', onReceiveProgress: (rec, total){
        print('Rec: $rec, Total: $total');
//        setState(() {
//          //isDownloadling = true;
//          //progressString = ((rec/total)*100).toStringAsFixed(0)+' %';
//        });
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

  /********************************************************************************
   *
   */

  int _counter = 0;
  final imgUrl = "https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip";
  var dio = Dio();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  /*******************************************************************************************
   *
   */

  Future<File> _downloadFile(String url, String filename) async {
   // var req = await http.Client().get(Uri.parse(url));
    Dio dio = Dio();
    var req ;
   var dir = await getApplicationDocumentsDirectory();
    try{
       req = await dio.download(pdfUrl, '${dir.path}/baobab2.pdf', onReceiveProgress: (rec, total){
        print('Rec: $rec, Total: $total');
//        setState(() {
//          //isDownloadling = true;
//          //progressString = ((rec/total)*100).toStringAsFixed(0)+' %';
//        });
      });
    }catch(e){
      print(e);
    }
    var file = File(req);
    return file.writeAsBytes(req.bodyBytes);
  }

  /***********************************************************************************************
   *
   */


  List<Bai> baiList =  List();

  @override
  void initState(){
    Timer(Duration(seconds: 2), () {
      print("Yeah, this line is printed after 3 seconds");
    });

//    String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=VHoT4N43jK8&list=RDUKftOH54iNU&index=16");
//    _controller = YoutubePlayerController(
//      initialVideoId: videoId,
//      flags: YoutubePlayerFlags(
//        mute: false,
//        autoPlay: false,
//        forceHideAnnotation: true,
//        enableCaption: false
    //      ),
    //    );'assets/pdfs/'+widget.title+'.pdf'

    _tabController = new TabController(length: 2, vsync: this);
    baiList
      ..add(Bai(id: "1", baiCat:"baobab", baiTitle:"BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FEUILLE DE BAOBAB EN POUDRE", baiImage:"assets/images/wapipoudrefeuillebaobnab.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "2", baiCat:"baobab", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES FRUITS DE BAOBAB EN POUDRE", baiImage:"assets/images/wapibaobabpoudre.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "3", baiCat:"baobab", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES  GRAINES DE BAOBAB EN AMANDES", baiImage:"assets/images/wapitransgrainebaobab.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "4", baiCat:"baobab", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES GRAINES DES AMANDES EN HUILE DE BAOBAB", baiImage:"assets/images/wapihuilebaobab.jpeg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "5", baiCat:"baobab", baiTitle:"TECHNIQUE DE PRODUCTION DE LA POUDRE DE FEUILLES SECHEES DE BAOBAB", baiImage:"assets/images/wapibaobabpoudre.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "6", baiCat:"baobab", baiTitle:"PRODUCTION DE FEUILLES FRAICHES DE BAOBAB", baiImage:"assets/images/wapifeuillefraichebaobab.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "7", baiCat:"apiculture", baiTitle:"LES BONNES PRATIQUES EN APICULTURE MODERNE POUR LA PRODUCTION ET LA PROMOTION DU MIEL PUR DE TRES BONNE  QUALITE", baiImage:"assets/images/wapibonnepratiqueapiculture.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "8", baiCat:"environnement", baiTitle:"BONNES PRATIQUES DE FERTILISATION DES SOLS POUR LA PRODUCTION BIOLOGIQUE", baiImage:"assets/images/wapibonnepratiquefertilisation.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "9", baiCat:"karite", baiTitle:"BONNES PRATIQUES DE DE TRAITEMENT ET D\'HYGIENE DE TRANSFORMATION DES AMANDES DE KARITE EN BEURE", baiImage:"assets/images/wapibeurekarite.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "10", baiCat:"moringa", baiTitle:"CREATION DES CHAINES DE VALEUR AJOUTEEE DE MORINGA", baiImage:"assets/images/wapicvamoringa.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "11", baiCat:"moringa", baiTitle:"ITINERAIRE TECHNIQUE DE PRODUCTION DU MORINGA OLEIFERA", baiImage:"assets/images/wapiproductionmoringa.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "12", baiCat:"detarium", baiTitle:"BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FRUITS DE DETARIUM EN POUDRE", baiImage:"assets/images/wapitransdetarium.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "13", baiCat:"sesame", baiTitle:"BONNES PRATIQUES D’OBTENTION DU SESAME GRILLE SUPPORT FORMATION ET APPUI CONSEIL", baiImage:"assets/images/wapisesamegrille.jpeg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "14", baiCat:"sesame", baiTitle:"BONNES PRATIQUES DE PRODUCTION DE SESAMES BIOLOGIQUES", baiImage:"assets/images/wapisesame.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "15", baiCat:"soja", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION DU SOJA EN FROMAGE", baiImage:"assets/images/wapifromagesoja.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"))
      ..add(Bai(id: "16", baiCat:"soja", baiTitle:"BONNES PRATIQUES D’OBTENTION DE FARINE ENRICHIE A BASE DE SOJA", baiImage:"assets/images/wapifarinesoja.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.zip"));


    super.initState();
  }

  /********************************************************************************************************
   *
   */
  String _dir;

   _getWapiPdf(String name, String dir) {
  //  if (_theme != AppTheme.candy) {
      var file = _getLocalFile(name, dir);

      //ici on peut appeler pdf viewer.FromFile
  //   _wapiPdf(name, dir+name+'.pdf');
      _wapiPdfFromFile(dir+name+'.pdf');

 //   }
    //return Image.asset('assets/images/$name');
  }

  File _getLocalFile(String name, String dir) => File('$dir/$name.pdf');

  Future<void> _downloadAssets(String name, String uri) async {

    if (_dir == null) {
      _dir = (await getApplicationDocumentsDirectory()).path;
    }

    if (!await _hasToDownloadAssets(name, _dir)) {
      return;
    }
    var zippedFile = await _downloadFiles(
        uri,
        '$name.zip',
        _dir);

    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);

    for (var file in archive) {
      var filename = '$_dir/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  Future<bool> _hasToDownloadAssets(String name, String dir) async {
    var file = File('$dir/$name.zip');
    return !(await file.exists());
  }

  Future<File> _downloadFiles(String url, String filename, String dir) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$dir/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }

  /**********************************************************************************************************
   *
   */
  Widget maCarte = Card(
    elevation: 5.0,
    margin: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //  borderOnForeground: true,
    child: ListView(
      children: [
        Image.asset(
          'assets/images/wapipoudrefeuillebaobnab.png',
//              width: 600,
          height: 240,
          alignment: Alignment.bottomCenter,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*2*/
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Baobab',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            child:  Container(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),

//                  width: 210,

                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: (){ print('Button Clicked.'); },
                    textColor: Colors.white,
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(5, 10, 5,10),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Container(
                              //color: Colors.pink,
                              padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                              child: Text('Télécharger',
                                style: TextStyle(color: Colors.white),),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                              child: Icon(
                                Icons.file_download,
                                color:Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ))))

        ),
        //    textSection,
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    var leng = baiList.length;
    print('ma list bai : $leng.');

    return new Scaffold(
      appBar: new AppBar(

        backgroundColor: Colors.green[600],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(
                "MY WAPI",
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
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
        ],
        bottom: TabBar(
          unselectedLabelColor: Colors.grey[300],
          labelColor: Colors.white,
          tabs: [
            new Tab(icon: new Icon(Icons.insert_drive_file)),
            new Tab(icon: new Icon(Icons.video_library),),
        //    new Tab(icon: new Icon(Icons.assistant_photo),)
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,

      ),

//      body: Stack(
//        children: [
//          new Center(
//            child: Text('Coming Soon training'),
//          ),
//
//        ],
//      ),

      body: TabBarView(
        children: [

//           // child: _isLoa () ? Center(child: CircularProgressIndicator()):PDFViewer(document: ,),
//            child: FutureBuilder<Object>(
//              future: _getDoc(),
//              builder: (context, snapshot){
//                print(snapshot.data);
//                if(snapshot.hasData){
//                  return Center(
//                    child: PDFViewer(document: doc, indicatorBackground: Colors.green[600],),
//                  );
//                }
//                else{
//                  return CircularProgressIndicator();
//                }
//
//              },
//            ),
        //  child: _isLoading ? Center(child: CircularProgressIndicator()) : PDFViewer(document: mydoc, ),

//            child:FutureBuilder<PDFDocument>(
//              future: _getDocument('assets/pdfs/maisrte.pdf'),
//              builder: (_, snapshot) {
//                if (snapshot.hasData) {
//                  return PDFView(
//                    document: snapshot.data,
//                    scrollDirection: Axis.vertical,
//                  );
//                }
//
//                if (snapshot.hasError) {
//                  return Center(
//                    child: Text(
//                      'PDF Rendering does not '
//                          'support on the system of this version',
//                    ),
//                  );
//                }
//
//                return Center(child: CircularProgressIndicator());
//              },
//            ),

        new ListView(
          children: <Widget>[
            Card(

              elevation: 5.0,
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                borderOnForeground: true,
              child: Column(

                children: [
                  Image.asset(
                    'assets/images/wapipoudrefeuillebaobnab.png',
                    width: 600,
                    height: 240,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      children: [
                        Expanded(
                          /*1*/
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Baobab',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FEUILLE DE BAOBAB EN POUDRE'.toLowerCase(),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child:  Container(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),

//                  width: 210,

                          child:
                          //isDownloadling?

                         RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              onPressed: (){
                                //print('Button baobab1 Clicked .');
                               //downloadFile();
                                _downloadAssets('baobab3', 'https://test.noworri.com/uploads/pdfs/baobab/baobab3.zip');
                              },
                              textColor: Colors.white,
                              color: Colors.green,
                              padding: EdgeInsets.fromLTRB(5, 10, 5,10),
                              child: Padding(

                                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Container(
                                        //color: Colors.pink,
                                        padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                        child: Text('Télécharger',
                                          style: TextStyle(color: Colors.white),),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                        child: Icon(
                                          Icons.file_download,
                                          color:Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ))
                          ),
                      //  :Text('Downloaded'),)

                  ),
                  ),  //    textSection,
                ],
              ),
            ),

            Card(

              elevation: 5.0,
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              borderOnForeground: true,
              child: Column(

                children: [
                  Image.asset(
                    'assets/images/wapibaobabpoudre.png',
                    width: 600,
                    height: 240,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      children: [
                        Expanded(
                          /*1*/
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Baobab',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FEUILLE DE BAOBAB EN POUDRE.'.toLowerCase(),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child:  Container(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 30),

//                  width: 210,

                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              onPressed: (){ print('Button baobab2 Clicked.'); },
                              textColor: Colors.white,
                              color: Colors.green,
                              padding: EdgeInsets.fromLTRB(5, 10, 5,10),
                              child: Padding(

                                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Container(
                                        //color: Colors.pink,
                                        padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                        child: Text('Télécharger',
                                          style: TextStyle(color: Colors.white),),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                        child: Icon(
                                          Icons.file_download,
                                          color:Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ))
                          ))

                  ),
                  //    textSection,
                ],
              ),
            ),

          ],
        ),

         /* new ListView(

            children: <Widget>[
               Card(
                 child: isDownloadling
                     ? Container(
                   height: 120.0,
                   width: 200.0,
                   child: Card(
                     color: Colors.black,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         CircularProgressIndicator(),
                         SizedBox(
                           height: 20.0,
                         ),
                         Text(
                           "Downloading File: $progressString",
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         )
                       ],
                     ),
                   ),
                 )
               :ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapipoudrefeuillebaobnab.png'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('BAOBAB',),
                   subtitle: Text('BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FEUILLE DE BAOBAB EN POUDRE'.toLowerCase(), ),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () async{
                     var tempDir = await getTemporaryDirectory();
                     String fullPath = tempDir.path + "/boo2.pdf'";
                     print('full path ${fullPath}');

                     download2(dio, imgUrl, fullPath);                     //donwloadFile();
                    // _wapiPdf('Baobab', 'baobab');
                   },
                 ),
               ),

                Card(
                   child: ListTile(
                     leading: CircleAvatar(

                       backgroundImage: AssetImage('assets/images/wapibaobabpoudre.png'),
                       radius: 25.0,
                     backgroundColor: Colors.white,
                     ),
                     title: Text('BAOBAB',),
                     subtitle: Text('BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES FRUITS DE BAOBAB EN POUDRE'.toLowerCase(),),
                     isThreeLine: true,
                     trailing: Icon(Icons.keyboard_arrow_right),
                     onTap: () {
                       _wapiPdf('Baobab', 'baobab');
                     },

                   ),
                 ),
               //),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapitransgrainebaobab.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('BAOBAB',),
                   subtitle: Text('BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES  GRAINES DE BAOBAB EN AMANDES'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),


               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapihuilebaobab.jpeg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('BAOBAB',),
                   subtitle: Text('BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES GRAINES DES AMANDES EN HUILE DE BAOBAB'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),


               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapibaobabpoudre.png'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('BAOBAB',),
                   subtitle: Text('TECHNIQUE DE PRODUCTION DE LA POUDRE DE FEUILLES SECHEES DE BAOBAB'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),


               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapifeuillefraichebaobab.png'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('BAOBAB',),
                   subtitle: Text('PRODUCTION DE FEUILLES FRAICHES DE BAOBAB'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),



               /******************************************************************************
                * ****************************************************************************
                */

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapibonnepratiqueapiculture.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('APICULTURE',),
                   subtitle: Text('LES BONNES PRATIQUES EN APICULTURE MODERNE POUR LA PRODUCTION ET LA PROMOTION DU MIEL PUR DE TRES BONNE  QUALITE'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),

               /***********************************************************************************
                *
                */
               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapibonnepratiquefertilisation.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('ENVIRONNEMENT',),
                   subtitle: Text('BONNES PRATIQUES DE FERTILISATION DES SOLS POUR LA PRODUCTION BIOLOGIQUE'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),
               /***********************************************************************
                *
                */

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapibeurekarite.png'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('KARITE',),
                   subtitle: Text('BONNES PRATIQUES DE DE TRAITEMENT ET D\'HYGIENE DE TRANSFORMATION DES AMANDES DE KARITE EN BEURE'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),

               /**************************************************************************
                *
                */

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapicvamoringa.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('MORINGA',),
                   subtitle: Text('CREATION DES CHAINES DE VALEUR AJOUTEEE DE MORINGA'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),


               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapiproductionmoringa.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('MORINGA',),
                   subtitle: Text('ITINERAIRE TECHNIQUE DE PRODUCTION DU MORINGA OLEIFERA'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),
               /*****************************************************************************
                *
                */

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapitransdetarium.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('DETARIUM',),
                   subtitle: Text('BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FRUITS DE DETARIUM EN POUDRE'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),
               /**********************************************************************************
                *
                */

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapisesamegrille.jpeg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('SESAME',),
                   subtitle: Text('BONNES PRATIQUES D’OBTENTION DU SESAME GRILLE SUPPORT FORMATION ET APPUI CONSEIL'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),


               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapisesame.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('SESAME',),
                   subtitle: Text('BONNES PRATIQUES DE PRODUCTION DE SESAMES BIOLOGIQUES'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),

               /********************************************************************************BONNES PRATIQUES DE TRANSFORMATION DU SOJA EN FROMAGE
                *
                */

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapifromagesoja.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('SOJA',),
                   subtitle: Text('BONNES PRATIQUES DE TRANSFORMATION DU SOJA EN FROMAGE'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(

                     backgroundImage: AssetImage('assets/images/wapifarinesoja.jpg'),
                     radius: 25.0,
                     backgroundColor: Colors.white,
                   ),
                   title: Text('SOJA',),
                   subtitle: Text('BONNES PRATIQUES D’OBTENTION DE FARINE ENRICHIE A BASE DE SOJA'.toLowerCase(),),
                   isThreeLine: true,
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Baobab', 'baobab');
                   },

                 ),
               ),




               /*             Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/apiculture.png'),
                     foregroundColor: Colors.green,
                   ),
                   title: Text('Apiculture',
                    style: GoogleFonts.andika(
                    textStyle: TextStyle(
                    color: Colors.black54, fontSize: 18),
                    ),
                  ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('Apiculture', 'apiculture');
                   },
                 ),
               ),
               

               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/environnement.png'),
                   ),
                   title: Text('Environnement ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('environnement', 'environnement');
                   },
                 ),
               ),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/karite.png'),
                   ),
                   title: Text('Karité ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('karite', 'karite');
                   },
                 ),
               ),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/moringa.png'),
                   ),
                   title: Text('Moringa ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('moringa', 'moringa');
                   },
                 ),
               ),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/nutrition.png'),
                   ),
                   title: Text('Nutrition ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('nutrition', 'nutrition');
                   },
                 ),
               ),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/pfnl.png'),
                   ),
                   title: Text('Bonnes pratique de transformation ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('BONNE PRATIQUES DE TRANSFORMATION', 'pfnl');
                   },
                 ),
               ),


               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/sesame.png'),
                   ),
                   title: Text('Sésame ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('sesame', 'sesame');
                   },
                 ),
               ),

               Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/images/soja.png'),
                   ),
                   title: Text('Maize ',
                     style: GoogleFonts.andika(
                       textStyle: TextStyle(
                           color: Colors.black54, fontSize: 18),
                     ),
                   ),
                   trailing: Icon(Icons.keyboard_arrow_right),
                   onTap: () {
                     _wapiPdf('soja', 'soja');
                   },
                 ),
               ),
*/

             ],


          ),*/


          new Container(
            child: YoutubePlayer(

                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amber
                ),
                onReady:(){
                  print('player is ready');
                }
            ),

          ),
        ],
        controller: _tabController,),


      bottomNavigationBar: ConvexAppBar.badge({0: '', 1: '', 2: '', 3:'', 4:''},
        key: _bottomNavigationKey,
        backgroundColor: Colors.green[600],
        initialActiveIndex: 1,

        items: [

          TabItem(icon: Icons.notifications_active, title: 'Home'),
          TabItem(icon: Icons.people, title: 'Formation'),
          TabItem(icon: Icons.business_center, title: 'Entreprise'),
          TabItem(icon: Icons.home, title: 'Menage'),
         // TabItem(icon: Icons.monetization_on, title: 'Marché'),
          //  TabItem(icon: Icons.settings, title: 'Paramètres'),
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

    );
  }

  void _wapiPdf(String s, String p) {
    print('wapi appelé');
    print(s);
    print(p);
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new WapiPdf(title: s, asset: p,)),
    );
  }

  void _wapiPdfFromFile(String file) {
    print('wapi pdf from file sur trainingH appelé');
    //print(s);
    print(file);
//    print(_dir);
//    String uri = _dir+file+'.pdf';
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new WapiPdfFromFile(file: file,)),
    );
  }

}
