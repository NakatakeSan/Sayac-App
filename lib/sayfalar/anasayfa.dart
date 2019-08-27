import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sayac/models/sayac.dart';
import 'package:sayac/sayfalar/duzenle.dart';
import 'package:sayac/sayfalar/genel.dart';
import 'package:sayac/sayfalar/sayacekle.dart';
import 'package:sayac/utils/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart'; 
import 'package:admob_flutter/admob_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:dynamic_theme/dynamic_theme.dart';

DatabaseHelper databasehelper;
List<Sayac> tumListe;
AdmobInterstitial interstitialAd;


bool girisYaptimi = false;
int tikListe;
int gunX;


GlobalKey<ScaffoldState> scKey = GlobalKey<ScaffoldState>();

AnimationController control;


class AnaSayfaMain extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return  DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sayaç Pro',
          theme: theme,
          home: AnaSayfa(),
        );
      }
    );
  }
}

class AnaSayfa extends StatefulWidget {
  
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}
class _AnaSayfaState extends State<AnaSayfa>with SingleTickerProviderStateMixin {


    Future girisKontrol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
    } else {
      prefs.setBool('seen', true);
      ekle(Sayac("Yaz Tatili",2,1560582900000,6,null));
    }
      databasehelper.tumSayaclar().then((gelenDeger){
      print("TUM DEGERLER : "+ gelenDeger.toString());
    });  
}

 void changeBrightness() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  }


  @override
  void initState() {
    super.initState();
    girisKontrol();
    tumListe = List<Sayac>();
    databasehelper = DatabaseHelper();
    databasehelper.tumSayaclar().then((gelenMap) {
      for (Map map in gelenMap) {
        tumListe.insert(0,Sayac.fromMap(map));
      } 
      setState(() {
      });
    control = new AnimationController(
    vsync: this, duration: new Duration(seconds: 1)); 
      control.repeat();
    });

  }
  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: SafeArea(
              child: Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                 DrawerHeader(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Center(
                         child: CircleAvatar(
                           backgroundImage: AssetImage("assets/images/sayacc.png"),
                         ),
                       ),
                       SizedBox(height: 10,),
                       Center(
                         child: Text(
                           'Sayaç Uygulaması',style: TextStyle(color: Colors.white,fontSize: 16),
                         ),
                       ),
                     ],
                   ),
                   decoration: BoxDecoration(
                       gradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [Colors.blue, Colors.indigo])),
                 ),
                 InkWell(
                   onTap: () => sayfayaGit("mailto:ercngp@gmail.com?subject=Sayaç App"),
                    child: ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: Text("İletişim",style: TextStyle(fontSize: 16),),
                    trailing: Icon(Icons.navigate_next),
                     ),
                 ),
                 Divider(
                   color: Colors.grey,
                 ),
                 InkWell(
                   onTap: () {
                       
                   },
                     child: ListTile(
                     leading: Icon(Icons.perm_device_information),
                     title: Text("Gizlilik Politikası",style: TextStyle(fontSize: 16),),
                     trailing: Icon(Icons.navigate_next),
                   ),
                 ),
                 Divider(
                   color: Colors.grey,
                 ),
                 InkWell(
                     child: InkWell(
                     onTap: () => LaunchReview.launch(androidAppId: "com.macozetizle.sayacpro"),
                       child: ListTile(
                       leading: Icon(Icons.star),
                       title: Text("Uygulamayı Puanla",style: TextStyle(fontSize: 16),),
                       trailing: Icon(Icons.navigate_next),
                     ),
                   ),
                 ),
                 Divider(
                   color: Colors.grey,
                 ),
                 /*InkWell(
                     onTap: () => LaunchReview.launch(androidAppId: "com.macozetizle.sayacpro"),
                       child: ListTile(
                       leading: Icon(FontAwesomeIcons.googlePlay),
                       title: Text("Sayac Pro+ Satın Al",style: TextStyle(fontSize: 16),),
                       trailing: Icon(Icons.navigate_next),
                     ),
                 ),
                 Divider(
                   color: Colors.grey,
                 ),*/
                 InkWell(
                   onTap: () {
                     changeBrightness();
                   },
                   child: ListTile(
                     leading: Icon(FontAwesomeIcons.mobileAlt),
                     title: Text("Tema Değiştir",style: TextStyle(fontSize: 16),),
                     trailing: Icon(Icons.navigate_next),
                   ),
                 ),
                  Divider(
                   color: Colors.grey,
                 ),
                 InkWell(
                   onTap: () => Navigator.pop(context),
                   child: ListTile(
                     leading: Icon(Icons.exit_to_app),
                     title: Text("Kapat",style: TextStyle(fontSize: 16),),
                   ),
                 ),
                 Divider(
                   color: Colors.grey,
                 ),
                 
                    ],
                  ),
              ),
            ),
            appBar: AppBar(
              actions: <Widget>[
                IconButton(icon: Icon(Icons.delete_forever,color: Colors.white,),onPressed : mesajGoster,color: Colors.white),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.dashboard),
                        Text("  Sayaçlar",style: TextStyle(fontSize: 14),),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Icon(Icons.filter_frames),
                      Text("  Resmi Tatiller",style: TextStyle(fontSize: 14),),
                      ],
                    ),
                  ),
                ],
              ),
              title: Text("Sayaç Uygulaması",style: TextStyle(fontSize: 20)),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                          itemCount: tumListe.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Stack(
                                  children : <Widget>[             
                                  Container(
                                 // height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: tumListe[index].resim == null ? AssetImage("assets/images/noresim.png") : tumListe[index].resim == "null" ? AssetImage("assets/images/noresim.png") : FileImage(File(tumListe[index].resim)),
                                      repeat: ImageRepeat.noRepeat,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                        gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: (tumListe[index].renk == 1 
                                          ? [Colors.indigo,Colors.blueAccent] 
                                          : tumListe[index].renk == 2 
                                          ? [Colors.red,Colors.redAccent] 
                                          : tumListe[index].renk == 3 
                                          ? [Colors.green,Colors.lightGreen]
                                          : tumListe[index].renk == 4 
                                          ? [Colors.deepOrange,Colors.orangeAccent]
                                          : tumListe[index].renk == 5
                                          ? [Colors.brown,Colors.brown.shade100]
                                          : tumListe[index].renk == 6
                                          ? [Colors.deepPurple,Colors.deepPurple]
                                          : tumListe[index].renk == 7
                                          ? [Colors.grey,Colors.blueGrey]
                                          : [Colors.deepPurple,Colors.deepPurple])
                                        ), 
                                  ),
                                  child: Column(             
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15) ),
                                        ),
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(tumListe[index].kategori == 1
                                                        ? FontAwesomeIcons.tint
                                                        : tumListe[index].kategori == 2
                                                            ? FontAwesomeIcons.graduationCap
                                                            : tumListe[
                                                                            index]
                                                                        .kategori ==
                                                                    3
                                                                ? FontAwesomeIcons.birthdayCake
                                                                : tumListe[index]
                                                                            .kategori ==
                                                                        4
                                                                    ? FontAwesomeIcons.skiing
                                                                    : tumListe[index]
                                                                                .kategori ==
                                                                            5
                                                                        ? FontAwesomeIcons.bell
                                                                        : tumListe[index]
                                                                                    .kategori ==
                                                                                6
                                                                            ? Icons.star
                                                                            : FontAwesomeIcons.handHoldingHeart,color: Colors.white,),
                                                    Text("     "+
                                                      tumListe[index].isim,
                                                      style: TextStyle(fontSize: 13,color: Colors.white,fontFamily: 'SkyFont'),
                                                    ),
                                                  ],
                                                )),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      await databasehelper
                                                          .sayacSil(tumListe[index].id)
                                                          .then((silinendeger) {});
                                                      setState(() {
                                                        tumListe.removeAt(index);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_sweep,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SayacDuzenle(
                                                                    id: tumListe[index]
                                                                        .id,
                                                                    isim:
                                                                        tumListe[index]
                                                                            .isim,
                                                                    tiklananListe:
                                                                        index,
                                                                    tarih:
                                                                        tumListe[index]
                                                                            .tarih,
                                                                    kategorii:
                                                                        tumListe[index]
                                                                            .kategori,
                                                                  )));
                                                    },
                                                    icon: Icon(
                                                      Icons.mode_edit,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),               
                                                MyButton(
                                                  tumListe[index].isim + " Sayacın : " +
                                                  ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inDays)).toString()+" GÜN " +
                                                  ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inHours)%24).toString()+" SAAT " +
                                                  ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inMinutes)%60).toString()+" DAKİKA "+
                                                  ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inSeconds)%60).toString()+" SANİYESİ "+
                                                  " KALDI " " -Sayaç Pro-"
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                     
                                      
                            
                                          new AnimatedBuilder(    
                                           animation: new CurvedAnimation(
                                           parent: control,
                                           curve: Curves.easeInOut,
                                           ),
                                            builder:(context, child){
                                             return Padding(
                                               padding: const EdgeInsets.all(8.0),
                                               child: Wrap( 
                                                 alignment: WrapAlignment.center,
                                                 children: <Widget>[ 
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Wrap(
                                                          alignment: WrapAlignment.center,
                                                           spacing: 20,
                                                          //alignment: WrapAlignment.center,
                                                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: <Widget>[
                                                            Column(
                                                             children: <Widget>[
                                                               Text("Gün  ",style: TextStyle(fontFamily: 'SkyFont',fontSize: 11,color: Colors.white54,fontWeight: FontWeight.bold),),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(right: 10),
                                                                          child: Text(
                                                                            ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inDays)).toString(),
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    20,color: Colors.white,fontFamily: 'SkyFont'),
                                                                          ),
                                                                        ),
                                                                      
                                                                      ],
                                                                    ),
                                                          Column(
                                                            
                                                                      children: <Widget>[
                                                                        Text("Saat  ",style: TextStyle(fontFamily: 'SkyFont',fontSize: 11,color: Colors.white54,fontWeight: FontWeight.bold),),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(right: 10),
                                                                          child: Text(
                                                                            ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inHours)%24).toString(),
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    20,color: Colors.white,fontFamily: 'SkyFont'),
                                                                          ),
                                                                        ),
                                                                       
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: <Widget>[
                                                                        Text("Dakika  ",style: TextStyle(fontFamily: 'SkyFont',fontSize: 11,color: Colors.white54,fontWeight: FontWeight.bold),),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(right: 10),
                                                                          child: Text(
                                                                            ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inMinutes)%60).toString(),
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    20,color: Colors.white,fontFamily: 'SkyFont'),
                                                                          ),
                                                                        ),
                                                                        
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: <Widget>[
                                                                        Text("Saniye  ",style: TextStyle(fontFamily: 'SkyFont',fontSize: 11,color: Colors.white54,fontWeight: FontWeight.bold),),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(right: 10),
                                                                          child: Text(
                                                                            ((DateTime.fromMillisecondsSinceEpoch(tumListe[index].tarih).difference(DateTime.now()).inSeconds)%60).toString(),
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    20,color: Colors.white,fontFamily: 'SkyFont'),
                                                                          ),
                                                                        ),
                                                                       
                                                                      ],
                                                                    ),
                                                        ],),
                                                      ),                    
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                       child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Wrap(
                                                        children: <Widget>[
                                                        SizedBox(width: 200,),
                                                        Text(formatDate(
                                                        DateTime.fromMillisecondsSinceEpoch(
                                                      tumListe[index].tarih),[dd, '-', M, '-', yyyy]),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),),
                                                      ],),
                                                    ),
                                                  )
                                                    
                                                 ],
                                               ),
                                             );

                                            },
                                          ),
                                    
                                    /*  Column(crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,right: 20,top: 8,bottom: 8),
                                          child: Text(formatDate(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                tumListe[index].tarih),[dd, '-', M, '-', yyyy]),style: TextStyle(color: Colors.white),),
                                        ),
                                      ],)*/
                                      
                                    ],
                                  ),
                                ),
                                ]
                              ),
                                  
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SayacEkle()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.red, Colors.redAccent]),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 26,
                              ),
                              Text(
                                "    Sayaç  Ekle  ",
                                style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'SkyFont'),
                              ),
                            ],
                          ),
                        ),
                      ), 
                      /*AdmobBanner(
                      adUnitId: getBannerAdUnitId(),
                      adSize: AdmobBannerSize.FULL_BANNER,
                    ),*/
                    ],
                  ),
                ),
                Genel(),
              ],
            ),
          ),
    );
  }
  void mesajGoster(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Silme İşlemi"),
          content: Text("Tüm Listeyi Silmek İstediğinizden Emin misiniz ?"),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              onPressed: (){
                silTablo();
                Navigator.pop(context);
              },
              child: Text("Sil",style: TextStyle(color: Colors.white)),
            ),
            FlatButton(
              color: Colors.green,
              onPressed: () => Navigator.pop(context),
              child: Text("Vazgeç",style: TextStyle(color: Colors.white),),
            )
          ],
        );
      }
    );
  }
  // Fonksiyonlar
  ekle(Sayac sayac) async{ 
     await databasehelper.sayacEkle(sayac).then((gelenDeger){ 
        setState(() {
          sayac.id = gelenDeger;
          tumListe.insert(0, sayac);
         });   
      });   
  }
  String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7652329323278280/1701775621';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7652329323278280/3477714116';
  }
  return null;
}

sayfayaGit(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  void silTablo() async {
    databasehelper.tumTabloyuSil().then((silinenDeger) {});
    setState(() {
      tumListe.clear();
    });
  }
}
class MyButton extends StatelessWidget {
 String text;
     MyButton(String yazi){
       this.text = yazi;
    }
    @override
    Widget build(BuildContext context) {
      return IconButton(
        icon: Icon(Icons.share,size: 25,color: Colors.white,),
        onPressed: (){
           final RenderBox box = context.findRenderObject();
          Share.share(text,
              sharePositionOrigin:
              box.localToGlobal(Offset.zero) &
              box.size);
        },
      );
    }
  }