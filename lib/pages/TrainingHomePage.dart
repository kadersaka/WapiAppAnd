import 'dart:async';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wap_i/models/Bai.dart';
import 'package:http/http.dart' as http;

import 'package:wap_i/models/VideoItemModel.dart';
import 'package:wap_i/models/YtbVid.dart';
import 'package:wap_i/pages/CardPdfItem.dart';
import 'package:wap_i/pages/WapiPdf.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:wap_i/pages/WapiPdfFromFile.dart';
import 'package:wap_i/pages/YtbPlayerItem.dart';
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

 // YoutubePlayerController _ytbController;
  @override
  void dispose() {
  //  if (_ytbController != null) _ytbController.dispose();

    if(_tabController != null) _tabController.dispose();

    super.dispose();
  }

  TabController _tabController;

  List<Bai> baiList =  List();
  List<YtbVid> ytbvidList =  List();

  YoutubePlayerController makeController(String url){
    String videoId = YoutubePlayer.convertUrlToId(url);
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          forceHideAnnotation: false,
          enableCaption: false
      ),
    );
  }


  @override
  void initState(){
    Timer(Duration(seconds: 2), () {
      print("Yeah, this line is printed after 3 seconds");
    });

    _tabController = new TabController(length: 2, vsync: this);
    baiList
      ..add(Bai(id: "1", baiName: 'baobab1', baiCat:"baobab", baiTitle:"BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FEUILLE DE BAOBAB EN POUDRE", baiImage:"assets/images/wapipoudrefeuillebaobnab.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.pdf"))
      ..add(Bai(id: "2", baiName: 'baobab2', baiCat:"baobab", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES FRUITS DE BAOBAB EN POUDRE", baiImage:"assets/images/wapibaobabpoudre.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab2.pdf"))
      ..add(Bai(id: "3", baiName: 'baobab3', baiCat:"baobab", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES  GRAINES DE BAOBAB EN AMANDES", baiImage:"assets/images/wapitransgrainebaobab.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab3.pdf"))
      ..add(Bai(id: "4", baiName: 'baobab4', baiCat:"baobab", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION ARTISANALE DES GRAINES DES AMANDES EN HUILE DE BAOBAB", baiImage:"assets/images/wapihuilebaobab.jpeg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab4.pdf"))
      ..add(Bai(id: "5", baiName: 'baobab5', baiCat:"baobab", baiTitle:"TECHNIQUE DE PRODUCTION DE LA POUDRE DE FEUILLES SECHEES DE BAOBAB", baiImage:"assets/images/wapibaobabpoudre.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab5.pdf"))
      ..add(Bai(id: "6", baiName: 'baobab6', baiCat:"baobab", baiTitle:"PRODUCTION DE FEUILLES FRAICHES DE BAOBAB", baiImage:"assets/images/wapifeuillefraichebaobab.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab6.pdf"))
      ..add(Bai(id: "7", baiName: 'apiculture',  baiCat:"apiculture", baiTitle:"LES BONNES PRATIQUES EN APICULTURE MODERNE POUR LA PRODUCTION ET LA PROMOTION DU MIEL PUR DE TRES BONNE  QUALITE", baiImage:"assets/images/wapibonnepratiqueapiculture.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab7.pdf"))
      ..add(Bai(id: "8", baiName: 'environnement', baiCat:"environnement", baiTitle:"BONNES PRATIQUES DE FERTILISATION DES SOLS POUR LA PRODUCTION BIOLOGIQUE", baiImage:"assets/images/wapibonnepratiquefertilisation.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab1.pdf"))
      ..add(Bai(id: "9", baiName: 'karite', baiCat:"karite", baiTitle:"BONNES PRATIQUES DE DE TRAITEMENT ET D\'HYGIENE DE TRANSFORMATION DES AMANDES DE KARITE EN BEURE", baiImage:"assets/images/wapibeurekarite.png", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab8.pdf"))
      ..add(Bai(id: "10", baiName: 'moringa1', baiCat:"moringa", baiTitle:"CREATION DES CHAINES DE VALEUR AJOUTEEE DE MORINGA", baiImage:"assets/images/wapicvamoringa.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab9.pdf"))
      ..add(Bai(id: "11", baiName: 'moringa2', baiCat:"moringa", baiTitle:"ITINERAIRE TECHNIQUE DE PRODUCTION DU MORINGA OLEIFERA", baiImage:"assets/images/wapiproductionmoringa.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab10.pdf"))
      ..add(Bai(id: "12", baiName: 'detarium1', baiCat:"detarium", baiTitle:"BONNE PRATIQUES DE TRANSFORMATION ARTISANALE DES FRUITS DE DETARIUM EN POUDRE", baiImage:"assets/images/wapitransdetarium.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab11.pdf"))
      ..add(Bai(id: "13", baiName: 'sesame1', baiCat:"sesame", baiTitle:"BONNES PRATIQUES D’OBTENTION DU SESAME GRILLE SUPPORT FORMATION ET APPUI CONSEIL", baiImage:"assets/images/wapisesamegrille.jpeg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab12.pdf"))
      ..add(Bai(id: "14", baiName: 'sesame2', baiCat:"sesame", baiTitle:"BONNES PRATIQUES DE PRODUCTION DE SESAMES BIOLOGIQUES", baiImage:"assets/images/wapisesame.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab13.pdf"))
      ..add(Bai(id: "15", baiName: 'soja1',  baiCat:"soja", baiTitle:"BONNES PRATIQUES DE TRANSFORMATION DU SOJA EN FROMAGE", baiImage:"assets/images/wapifromagesoja.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab14.pdf"))
      ..add(Bai(id: "16", baiName: 'soja2', baiCat:"soja", baiTitle:"BONNES PRATIQUES D’OBTENTION DE FARINE ENRICHIE A BASE DE SOJA", baiImage:"assets/images/wapifarinesoja.jpg", baiPdf:"https://test.noworri.com/uploads/pdfs/baobab/baobab15.pdf"));

ytbvidList
      ..add(YtbVid(id:'1', title:'Engrais Organiques', resume:'Vous apprendrez comment produire des engrais organiques', link:'https://www.youtube.com/watch?v=qS01oRF1U1k'))
      ..add(YtbVid(id:'1', title:'Plantules de Baobab', resume:'Vous apprendrez comment faire et suivre les plantules de Baobab', link:'https://www.youtube.com/watch?v=KZDJmFSTnVw'))
      ..add(YtbVid(id:'1', title:'Mung Bean', resume:'Préparation à bas de Mung Bean', link:'https://www.youtube.com/watch?v=KTKnE2aY4qI'))
      ..add(YtbVid(id:'1', title:'Feuilles de Baobab', resume:'DIfférentes techniques de séchage des feuiles de Baobab', link:'https://www.youtube.com/watch?v=KG3__qwQEkg'))
      ..add(YtbVid(id:'1', title:'Baobab', resume:'Utilité des produits dérivés de Baobab', link:'https://www.youtube.com/watch?v=wJa4YB_PFVo&t=42s'));

    super.initState();
  }



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

      body: TabBarView(
        children: [


        new ListView.builder(
          itemCount: baiList.length,
          itemBuilder: (_, index){
            print('baiList[index].name: ');
            print(baiList[index]);

            return PdfCard(bai: baiList[index],);

          }
        ),

          new ListView.builder(
            itemCount: ytbvidList.length,
            itemBuilder: (_, index){
              return YtbPlayerItem(ytbVid: ytbvidList[index],);
            }


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



}
