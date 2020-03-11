import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper{

  String serverUrl = "https://test.noworri.com/api";
  var status ;
  var rData;

  var token ;
  _save(String token, String name, String email, String phone, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    prefs.setString('name', name);
    prefs.setString('phone', phone);
    prefs.setString('email', email);
    prefs.setInt('id', id);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }

  readPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key ) ?? 0;
    print('read phone: $value');
  }

  readName() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'name';
    final value = prefs.get(key ) ?? 0;
    print('read name: $value');
  }



  checkUser(String phone) async{

    print('phone : $phone');

    String myUrl = "$serverUrl/checkuser";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "phone": "$phone"
        } ) ;
    print(response.body);
    status = response.body.contains('error');

    var data = json.decode(response.body);
    rData = json.decode(response.body);

    if(status){
      print('datahelper.checkuser data error: ${data["error"]}');
    }else{
      print('datahelper.checkuser data success: $data');
      //_save(data["token"], data["name"], data["email"], data["phone"]);
    }

  }



  verifySms(String code , String contact_number) async{

    String myUrl = "$serverUrl/verifysms";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "code": "$code",
          "contact_number" : "$contact_number"
        } ) ;

    var data = json.decode(response.body);
  //  status = data["success"];
    print('verify sms called from databasehelper');
    print(data);
    if(data["success"].toString() == 'true'){
      print('phone Verified');
      status = true;
    }else{
      print('phone not verified');
      status = false;
     // _save(data["token"], data["name"], data["email"], data["phone"]);
    }

  }
  sendHelpRequest(String object ,String resume, String name , String base64Image) async{
    print('databasehelper.registerData, try to register');
    print('name : $name');
    print('object : $object');
    print('resume : $resume');
    print('base64Image : $base64Image');

    String myUrl = "$serverUrl/wapihelp";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          "object": "$object",
          "resume": "$resume",
          "base64Image": "$base64Image"
        } ) ;
    print('Saving help request from dbhelper: ');
    print(response.body);
    status = response.body.contains('error');
    print('statut: $status');
    var data = json.decode(response.body);
    rData = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"], data["name"], data["email"], data["phone"], data["id"]);
    }
  }


  registerData(String name ,String phone, String email , String password, String code) async{
    print('databasehelper.registerData, try to register');
    print('name : $name');
    print('phone : $phone');
    print('email : $email');
    print('password : $password');
    print('code : $code');

    String myUrl = "$serverUrl/register";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          // "phone": int.parse(phone),
          "phone": "$phone",
          "email": "$email",
          "code": "$code",
          "password" : "$password"
        } ) ;
   print('registering function runned, return is: ');
     print(response.body);
    status = response.body.contains('error');
    print('statut: $status');
    var data = json.decode(response.body);
    rData = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"], data["name"], data["email"], data["phone"], data["id"]);
    }

  }



  loginData(String phone , String password) async{

    String myUrl = "$serverUrl/login";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "phone": "$phone",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');

    var data = json.decode(response.body);
    print(data);
    data = data['currentUser'];
    print(data);
    if(status){
      print('dhelper data error: ${data["error"]}');
    }else{
      print('dhelper data success : ${data["token"]}');
      _save(data["token"], data["name"], data["email"], data["phone"], data["id"]);
//    _save(data["token"], data["name"], data["email"], data["phone"]);
    }

  }


  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/products/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
    });
    print(response.body);
    return json.decode(response.body);
  }
  Future<List> getAnnonces() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/wapiannonces/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getAchats() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/wapiachats/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getVentes() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/wapiventes/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getMyAnnonces() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    final id = prefs.get('id') ?? 2;

    String myUrl = "$serverUrl/wapiannonces/$id";
     http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
     }
    );
    print(response.body);
    return json.decode(response.body);
  }

  void deleteData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/products/$id";
    http.delete(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
    } ).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void addData(String name , String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/products";
    http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "product_name": "$name",
          "product_price" : "$price"
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  registerData2(String name ,String phone, String email , String password, String code) async{
    print('databasehelper.registerData, try to register');
    print('name : $name');
    print('phone : $phone');
    print('email : $email');
    print('password : $password');
    print('code : $code');

    String myUrl = "$serverUrl/register";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          // "phone": int.parse(phone),
          "phone": "$phone",
          "email": "$email",
          "code": "$code",
          "password" : "$password"
        } ) ;
   print('registering function runned, return is: ');
     print(response.body);
    status = response.body.contains('error');
    print('statut: $status');
    var data = json.decode(response.body);
    rData = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"], data["name"], data["email"], data["phone"], data["id"]);
    }

  }

   addAnnonce(String nom , String lieu,  String  prix, String quantite, String unite, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    final user_id = prefs.get('id' ) ?? 2;

    String myUrl = "$serverUrl/wapiannonce";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "nom": "$nom",
          "lieu" : "$lieu",
          "prix" : "$prix",
          "quantite" : "$quantite",
          "unite": "$unite",
          "type" : "$type",
          "user_id" : "$user_id"
        }
    );

      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
      status = response.body.contains('id');
      print('statut: $status');
      rData = response.body;
     status;
  }


  void editData(int id,String name , String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "http://flutterapitutorial.codeforiraq.org/api/products/$id";
    http.put(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "product_name": "$name",
          "product_price" : "$price"
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }





  
  
  
  
}


