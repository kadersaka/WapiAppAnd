import 'dart:io';

//import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:native_pdf_view/native_pdf_view.dart';

import 'package:wap_i/pages/TrainingHomePage.dart';

class WapiPdf extends StatefulWidget {

   String title;
  String asset;
  WapiPdf({this.title , this.asset}) ;

  @override
  createState() => new WapiPdfState();
}

class WapiPdfState extends State<WapiPdf> {
  final globalKey = new GlobalKey<ScaffoldState>();

  GlobalKey _bottomNavigationKey = GlobalKey();


  Future<PDFDocument> _getDocument(String uri) async {
   // if (await _hasSupportPdfRendering()) {*/
      return PDFDocument.openAsset(uri);
   /* } else {
      throw Exception(
        'PDF Rendering does not '
            'support on the system of this version',
      );
    }*/
  }
  @override
  void initState(){
 print('lien:');
 //print('assets/pdfs/'+widget.asset+'.pdf');
 print(widget.asset+'.pdf');
     super.initState();
  }


/*  Future<bool> _hasSupportPdfRendering() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:globalKey,
      appBar: new AppBar(
        backgroundColor: Colors.green[600],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new TrainingHomePage(),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(widget.title.toString().toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.w600),
              ),

            ),
          ],
        ),
        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 12.0),
//            child: Icon(
//              Icons.videocam,
//              color: Colors.brown,
//            ),
//          ),
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
      ),
      body: Stack(
        children: <Widget>[

          new Container(
            child:FutureBuilder<PDFDocument>(
            //  future: _getDocument('assets/pdfs/'+widget.asset+'.pdf'),
              future: _getDocument(widget.asset+'.pdf'),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return PDFView(
                    document: snapshot.data,
                    scrollDirection: Axis.vertical,

                  );
                  // snapshot.data.dispose()
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'PDF Rendering does not '
                          'support on the system of this version',
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),

          ),


        ],
      ),


    );
  }

}
