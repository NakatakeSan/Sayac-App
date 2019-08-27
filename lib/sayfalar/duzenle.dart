import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sayac/models/sayac.dart';
import 'package:toast/toast.dart';
import 'package:date_format/date_format.dart';
import 'anasayfa.dart';

class SayacDuzenle extends StatefulWidget {

  int id = 0;
  int tiklanan = 0;
  String isim;
  int tarihh;
  int kategori;
  String gonderilenTarih;

  SayacDuzenle({int id,String isim,int tiklananListe,int tarih, int kategorii}){
    this.id = id;
    this.isim = isim;
    this.tiklanan = tiklananListe;
    this.tarihh = tarih;
    this.kategori = kategorii;
  }

  @override
  _SayacDuzenleState createState() => _SayacDuzenleState();
}

class _SayacDuzenleState extends State<SayacDuzenle> {
  final myController = TextEditingController();
  final tarihKontrol = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    myController.text = "${widget.isim}";
    tarihKontrol.text = "${widget.tarihh}";
    //${((widget.tarihh - DateTime.now().millisecondsSinceEpoch) /(24 * 60 * 60 * 1000)).floor()} Gün ${((widget.tarihh - DateTime.now().millisecondsSinceEpoch)  % (1000 * 60 * 60 * 24) / (1000 * 60 * 60)).floor()} Saat ${((widget.tarihh - DateTime.now().millisecondsSinceEpoch)  % (1000 * 60 * 60) / (1000 * 60)).floor()} Dakika
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isim +"  Düzenle"),),
      body: Form(
        key : _formKey,
              child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: myController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit),
                    border: OutlineInputBorder()
                  ),
                  onSaved: (deger){
                    widget.isim = deger;
                  },
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: tarihKontrol,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder()
                  ),
                  onSaved: (deger){
                    widget.tarihh = int.parse(deger);
                  },
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
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black38)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButtonHideUnderline(
                            
                            child: DropdownButton(
                                
                                hint: Text("Kategori Seç",style: TextStyle(color: Colors.white,)),
                                value: widget.kategori,
                                onChanged: (gelenDeger) {
                                  setState(() {
                                    widget.kategori = gelenDeger;
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
                                      Icon(FontAwesomeIcons.handHoldingHeart)
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
                                      Icon(Icons.favorite)
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
                            tarihKontrol.text = date.millisecondsSinceEpoch.toString();
                          },currentTime: DateTime.now(),
                          locale: LocaleType.tr);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
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
                                "Tarih Seçiniz",
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
              Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                      onTap: (){
                          _formKey.currentState.save();
                          guncelle(Sayac.withdID(widget.id,widget.isim,widget.kategori,widget.tarihh),widget.tiklanan);                       
                         showToast(                       
                        "Güncellendi. Yönlendiriliyor...",
                         gravity: Toast.CENTER,
                        duration: Toast.LENGTH_LONG              
                        );
                        Future.delayed(Duration(seconds: 2), () {    
                          Navigator.pop(context);  
                          });     
                      },
                     child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                       gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green,Colors.lightGreen]
                      )
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                      Text("Güncelle",style: TextStyle(fontSize: 18,color: Colors.white),),
                      SizedBox(width: 10,),
                      Icon(Icons.save,size: 25,color: Colors.white,)
                    ],)
                  ),
                ),
              )
          ],
           
        ),
      ),
      
    ); 
  }
  void showToast(String msg,{int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity,backgroundColor: Colors.green);
  }

    guncelle(Sayac sayac, int tiklananListe) async{
     await databasehelper.sayacGuncelle(sayac).then((gelenDeger){ 
        setState(() {
          tumListe[tiklananListe] = sayac;
         });   
      });
      
  }
}