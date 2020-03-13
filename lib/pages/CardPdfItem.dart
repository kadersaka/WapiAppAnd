import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wap_i/models/Bai.dart';

import 'WapiPdfFromFile.dart';

class PdfCard extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
//  final name;
//  final resume;
//  final picture;
//  final uri;
//  final categorie;
   final Bai  bai;

  PdfCard({
    @required this.bai,  Key key,
  }) : super(key: key);

  @override
  _PdfCardState createState() => _PdfCardState();
}

class _PdfCardState extends State<PdfCard> {


  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 8.0,
      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      borderOnForeground: true,
      child: Column(

        children: [
          Image.asset(
          //  'assets/images/wapipoudrefeuillebaobnab.png',
            widget.bai.baiImage.toString(),

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
                         widget.bai.baiCat.toString().toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green
                          ),
                        ),
                      ),
                      Text(
                        widget.bai.baiTitle.toString().toLowerCase(),
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),

                          Text("Téléchargement: $progressString"),
                        //  Text(' '),

                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            child:  Container(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: FutureBuilder(
                future: _pdfFileExist(widget.bai.baiName.toString()),
                builder: (_, snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data){
                      return openPdfFile();
                    }
                    else{
                      return  downloadButton();
                    }
                  }
                  return Container();
                }

    ),


              //  :Text('Downloaded'),)

            ),
          ),  //    textSection,
        ],
      ),
    );



  }

  Widget downloadButton(){
   return RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        onPressed: (){
          _wapiPdfFromFile(widget.bai.baiName.toString());
        },
        textColor: Colors.white,
        color: Colors.red,
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
                Text(progressString),
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
    );
  }

  Widget openPdfFile (){
    return    RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        onPressed: (){
          _wapiPdfFromFile(widget.bai.baiName.toString());
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
                  child: Text('Ouvrir',
                    style: TextStyle(color: Colors.white),),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                  child: Icon(
                    Icons.insert_drive_file,
                    color:Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ))
    );
}
  void _wapiPdfFromFile(String name) async {
    print('wapi pdf from file sur trainingH appelé');
    var dir = await getExternalStorageDirectory();
    var fullPath = dir.path+'/'+name+'.pdf';

    if(await _pdfFileExist(name)){
      print('file est: '+name);
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => new WapiPdfFromFile(file: fullPath,)),
      );
    }
    else{
      print('le fichier nexiste pas, nous allons le télécharger from wapipdf');
      downloadFile(name);
      print('Téléchargement en cours from wapipdf');
    }

  }
  // final pdfUrl = "https://test.noworri.com/uploads/pdfs/baobab/";
  final pdfUrl = "http://firstlogistics.fr/pdfs/";
  bool isDownloaded;
  bool fileExit = false;
  var progressString = "";
  var downloaded;



  Future<bool> _pdfFileExist(String name) async {
    var dir = await getExternalStorageDirectory();
    var fullPath = dir.path+'/'+name+'.pdf';
    print('_hasToDownloadAssets appelé from Traininghp, le path est: ');
    print(fullPath);
    //  print(dir.path+'/baobab1.pdf');
    var file = File(fullPath);
    bool resultat = (await file.exists());
    print('bool resultat exists = $resultat');
//
    return resultat;
  }

  Future <void> downloadFile(String name) async{
    if(!await _pdfFileExist(name)){
      Dio dio = Dio();
      var dir = await getExternalStorageDirectory();


      print('downloadFile called file is: ${dir.path}/$name.pdf');
      try{
        await dio.download(pdfUrl+'/$name.pdf', '${dir.path}/$name.pdf', onReceiveProgress: (rec, total){
          if(total != -1){
            setState(() {
              progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
              downloaded = rec;
            });
            print('progression:'+progressString);
            print('Rec: $rec, Total: $total');
          }

        });
        print('download finished by kader from downloadfile async');
      }
      catch(e){
        print(e);
      }
      setState(() {
        progressString = "Terminé";
      });
      print('Download exited, finished if no exception');
    }
    else{
      print('file exists, no need to download from downloadFile');
    }
  }

}
