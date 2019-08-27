import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sayac/sayfalar/anasayfa.dart';
import 'package:sayac/sayfalar/intro.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() async{ 
    Admob.initialize(getAppId());
    bool durum=false;
    
    Future girisKontrol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('gecis') ?? false);
    
    if (_seen) {
      durum = true;
      print("DURUM TRUE : "+durum.toString()); // LOG
    } else { 
      prefs.setBool('gecis', true);
       print("DURUM FALSE AMA ARTIK TRUE : "+durum.toString());
    }
}

  girisKontrol().then((deger){
     runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    home: SplashScreen(
      seconds: 3,
      navigateAfterSeconds: durum == false ? App() : AnaSayfaMain(),
      title: new Text('Sayaç Pro',style: TextStyle(fontFamily: 'SkyFont',color: Colors.white54,fontSize: 28),),
      image: new Image.asset('assets/images/sayacc.png',height: 120,width: 120),
      gradientBackground: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.purpleAccent,Colors.deepPurple]
       ),
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.white
    )
  ));
  });
 
}
String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544~1458002511';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544~3347511713';
  }
  return null;
}
