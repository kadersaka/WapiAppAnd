import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wap_i/pages/ProfilePage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'CompanyHomePage.dart';
import 'MenageHomePage.dart';
import 'TrainingHomePage.dart';
import 'WellcomePage.dart';


class MarketHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: new MyMarketHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyMarketHomePage extends StatefulWidget {
  @override
  _MyMarketHomePageState createState() => new _MyMarketHomePageState();
}

class _MyMarketHomePageState extends State<MyMarketHomePage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  GlobalKey _bottomNavigationKey = GlobalKey();
//  final CompanyHomePage _companyHomePage = new CompanyHomePage();
//  final TrainingHomePage _trainingHomePage = new TrainingHomePage();
//  final MenageHomePage _menageHomePage = new MenageHomePage();
//  final MarketHomePage _marketHomePage = new MarketHomePage();

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
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => TrainingHomePage()),
//        );
        // return 0;
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





  @override
  void initState() {


    super.initState();


  }



  @override
  Widget build(BuildContext context) {
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
                    fontWeight: FontWeight.w600),
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
            child:  IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new ProfilePage(),
                  )
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          new Center(
            child: Text('Coming Soon'),
          ),

        ],
      ),
      bottomNavigationBar: ConvexAppBar.badge({0: '', 1: '', 2: '', 3:'', 4:''},
        key: _bottomNavigationKey,
        backgroundColor: Colors.green[600],
        initialActiveIndex: 4,


        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.school, title: 'Formation'),
          TabItem(icon: Icons.business, title: 'Entreprise'),
          TabItem(icon: Icons.people, title: 'Menage'),
          TabItem(icon: Icons.monetization_on, title: 'Marché'),
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


}
