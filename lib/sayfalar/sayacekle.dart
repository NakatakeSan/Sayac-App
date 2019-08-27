import 'dart:async';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sayac/models/sayac.dart';
import 'package:sayac/utils/database_helper.dart';
import 'package:toast/toast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'anasayfa.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:launch_review/launch_review.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';


class SayacEkle extends StatefulWidget {
  @override
  _SayacEkleState createState() => _SayacEkleState();
}

class _SayacEkleState extends State<SayacEkle> {

 File _image;

  
 Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print(_image.path);
    });
  }


AdmobInterstitial interstitialAd;
  final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
    ]);
  int tarih=0;
  var formKey = GlobalKey<FormState>();
  int secilenKategori;
  int secilenRenk;
  String sayacIsmi;

  @override
  void initState() {
    super.initState();
    interstitialAd = AdmobInterstitial(
    adUnitId: 'ca-app-pub-7652329323278280/7856120438',
        );
interstitialAd.load();
    databasehelper = DatabaseHelper();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
    title: Text("Sayaç Ekle"),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.add_alert),
      )
    ],
        ),
        body: Container(
    child: Stack(
      children: <Widget>[
        ControlledAnimation(
           playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
         builder: (context, animation) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [animation["color1"], animation["color2"]])),
                    child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                     style: TextStyle(
                     color: Colors.white,
                ),  
                      decoration: InputDecoration(  
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                       disabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.white
                         )
                       ),
                        prefixIcon: Icon(Icons.info_outline,color: Colors.white),   
                        labelStyle: TextStyle(color: Colors.white),
                          labelText: "Başlık", 
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white

                            )
                          )),
                          validator: (gelenDeger){
                            if(gelenDeger.length<3){
                              return "En az 3 karakter giriniz";
                            }else{

                            }
                          },
                      onSaved: (gelenDeger) {
                        setState(() {
                          sayacIsmi = gelenDeger;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(                              
                                  hint: Text("Kategori Seç",style: TextStyle(color: Colors.white,)),
                                  value: secilenKategori,
                                  onChanged: (gelenDeger) {
                                    setState(() {
                                      secilenKategori = gelenDeger;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Genel"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(FontAwesomeIcons.tint)
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Eğitim"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(FontAwesomeIcons.graduationCap)
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Doğum Günü"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(FontAwesomeIcons.birthdayCake)
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Spor"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(FontAwesomeIcons.skiing)
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Bayram"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(FontAwesomeIcons.bell)
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Özel Gün"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(Icons.star)
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Romantik"),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Icon(FontAwesomeIcons.handHoldingHeart)
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),                 
                      Expanded(
                        child: GestureDetector(
                          onTap: () {  
                            DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                                 onChanged: (date) {
                                print(date.millisecondsSinceEpoch);
                                tarih=date.millisecondsSinceEpoch;
                              },currentTime: DateTime.now(),
                              locale: LocaleType.tr);
                              },                         
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue,Colors.indigo]
                        ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Tarih Seç",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                Icon(Icons.date_range, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                         child: Padding(
                          padding: const EdgeInsets.only(left:10,right: 10),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    hint: Text("Arka Plan Rengi Seç",style: TextStyle(color: Colors.white)),
                                    value: secilenRenk,
                                    onChanged: (gelenDeger) {
                                      setState(() {
                                        secilenRenk = gelenDeger;
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 160,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.indigo,Colors.blueAccent]
                                                  )
                                                ),  
                                                ),
                                            ),       
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                           Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 100,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.red,Colors.redAccent]
                                                  )
                                                ),  
                                                ),
                                            ), 
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 100,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.green,Colors.lightGreen]
                                                  )
                                                ),  
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                           Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 100,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.deepOrange,Colors.orangeAccent]
                                                  )
                                                ),  
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                           Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 100,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.brown,Colors.brown.shade100]
                                                  )
                                                ),  
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                         Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 100,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.deepPurple,Colors.purpleAccent]
                                                  )
                                                ),  
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                           Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                               height: 100,
                                               width: 310,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Colors.grey,Colors.blueGrey]
                                                  )
                                                ),  
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      getImage();
                    },
                          child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                             gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue,Colors.indigo]
                            )
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                            Text("Resim Seç",style: TextStyle(fontSize: 18,color: Colors.white),),
                            SizedBox(width: 10,),
                            Icon(Icons.image,size: 32,color: Colors.white,)
                          ],)
                        ),
                  ),
                ),

                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.maxFinite,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white
                      )
                    ),
                    child: Center(child: _image == null ?  Image.file(File("/storage/emulated/0/WhatsApp/Media/WhatsApp Images/IMG-20190603-WA0059.jpg"),fit: BoxFit.fill,) :Image.file(_image)),
                  ),               
                ),*/

                Padding(
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                        onTap: (){
                          setState(() {      
                            if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            print("BUTONN : "+ _image.toString());
                            if(tarih == 0){
                              mesajGoster();
                            }else{
                              ekle(Sayac(sayacIsmi,secilenKategori,tarih,secilenRenk,_image == null ? "null" : _image.path)); 
                              showToast(                       
                            "Sayaç Eklendi. Yönlendiriliyor...",
                             gravity: Toast.CENTER,
                            duration: Toast.LENGTH_LONG              
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              reklam();
                              popUpKontrol();
                              Navigator.pop(context);     
                              });  
                            }  
                            }
                          });
                          },
                       child:Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                         gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.redAccent,Colors.red]
                        )
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                        Text("Sayacı Ekle",style: TextStyle(fontSize: 18,color: Colors.white),),
                        SizedBox(width: 10,),
                        Icon(Icons.add_box,size: 25,color: Colors.white,)
                      ],)
                    ),
                  ),
                ),
                
              ],
              
            ),
          ),
          );
        },
        ), 
                    /*  Align(
                        alignment: Alignment.bottomCenter,
                        child: AdmobBanner(
                        adUnitId: getBannerAdUnitId(),
                        adSize: AdmobBannerSize.LARGE_BANNER,
                    ),
                      ), */
      ],
    ),
        ),
      );
  }
Widget reklamGoster(){
  return  AdmobBanner(
      adUnitId: getBannerAdUnitId(),
      adSize: AdmobBannerSize.FULL_BANNER,
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
popUpKontrol() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('TOPLAM TIKLANMA :  $counter ');
  await prefs.setInt('counter', counter).then((olduMu){
        if(counter %3 == 0){
        //popUp();
        }else{

        }
  });
}

  void popUp(){
  showDialog(
  context: context,builder: (_) => FlareGiffyDialog(
    flarePath: 'assets/images/space_demo.flr',
    flareAnimation: 'loading',
    title: Text('Uygulamayı Puanla',
           style: TextStyle(
           fontSize: 22.0, fontWeight: FontWeight.w600,color: Colors.deepPurple),),
           description: Text("Uygulamayı Değerlendirerek Bize Destek Olabilirsiniz. \n Eğer Beğendiyseniz 5 Yıldız \n Vermeyi Unutmayınız :)",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
    onOkButtonPressed: () {
      LaunchReview.launch(androidAppId: "com.macozetizle.sayac");
    },
  ) );
  }
  void mesajGoster(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Tarih Hatası"),
          content: Text("Lütfen Geçerli Tarih Seçiniz..."),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              onPressed: () => Navigator.pop(context),
              child: Text("Tamam",style: TextStyle(color: Colors.white),),
            )
          ],
        );
      }
    );
  }
  void reklam() async{
    if (await interstitialAd.isLoaded) {
      interstitialAd.show();
}
  }
  void showToast(String msg,{int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity,backgroundColor: Colors.blue);
  }
  ekle(Sayac sayac) async{
     await databasehelper.sayacEkle(sayac).then((gelenDeger){ 
        setState(() {
          sayac.id = gelenDeger;
          tumListe.insert(0, sayac);
         });   
      });   
  }
}