import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sayac/models/tarih.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Tarih> liste;
bool yuklendimi=false;

class Genel extends StatefulWidget {
  @override
  _GenelState createState() => _GenelState();
}

class _GenelState extends State<Genel> {

    Future<List<Tarih>> veriOku() async {
    if(yuklendimi) return liste;
    var getir = await http.get("http://www.macozetizle.com/veri.json",headers: {'Content-Type': 'application/json'});
    if (getir.statusCode == 200) {
      print("Veri Getirildi.");
      var f = (json.decode(utf8.decode(getir.bodyBytes)) as List).map((gelenDeger) => Tarih.fromJson(gelenDeger)).toList();
      liste = f;
      yuklendimi = true;
      return liste;
    } else {
      throw Exception("Tarihlere Ulasilamadi Hata Kodu : ${getir.statusCode}");
    }
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: veriOku(),
      builder: (context, AsyncSnapshot<List<Tarih>> snapshot){
        if(snapshot.hasData){
          return Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey.shade700,
                      child: ListTile(
                        leading: Icon(Icons.date_range,color: Colors.white),
                        title: Text(snapshot.data[index].isim,style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(snapshot.data[index].tarih,style: TextStyle(fontSize: 18,color: Colors.yellow),),
                      ),
                    ),
                  );
                },
                ),
              ),              
             //  reklamGoster()
            ],
                 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
    String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7652329323278280/1701775621';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7652329323278280/3477714116';
  }
  return null;
}
  Widget reklamGoster(){
  return Align(
        alignment: Alignment.bottomCenter,
        child: AdmobBanner(
              adUnitId: getBannerAdUnitId(),
              adSize: AdmobBannerSize.LARGE_BANNER,
                    ),
           );
}
}