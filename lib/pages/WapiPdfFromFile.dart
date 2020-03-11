import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:native_pdf_view/native_pdf_view.dart';

import 'package:wap_i/pages/TrainingHomePage.dart';

class WapiPdfFromFile extends StatefulWidget {

 String file;
 WapiPdfFromFile({this.file}) ;

  @override
  createState() => new WapiPdfFromFileState();
}

class WapiPdfFromFileState extends State<WapiPdfFromFile> {
  final globalKey = new GlobalKey<ScaffoldState>();

  GlobalKey _bottomNavigationKey = GlobalKey();


  Future<PDFDocument> _getDocument(String file) async {
    // if (await _hasSupportPdfRendering()) {*/
    return PDFDocument.openFile(file);
    /* } else {
      throw Exception(
        'PDF Rendering does not '
            'support on the system of this version',
      );
    }*/
  }
  @override
  void initState(){
    print('file path and name:');
    //print('assets/pdfs/'+widget.asset+'.pdf');
    print(widget.file);
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
              child: Text('Boite à image',
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

        ],
      ),
      body: Stack(
        children: <Widget>[

          new Container(
            child:FutureBuilder<PDFDocument>(
              //  future: _getDocument('assets/pdfs/'+widget.asset+'.pdf'),
              future: _getDocument(widget.file),
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
                      'snapshot.haserror from wapipdffromfile PDF Rendering does not '
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
