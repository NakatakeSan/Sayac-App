import 'package:sayac/models/tarih.dart';

class Sayac {

  int _id;
  String _isim;
  String _resim;
  int _kategoriIsmi;
  int _tarih;
  int _secilenRenk;

  int get id => _id;
  set id(int value){
    this._id = value;
  }

   String get resim => _resim;
  set resim(String value){
    this._resim = value;
  }

  String get isim => _isim;
  set isim(String value){
    this._isim = value;
  }

  int get renk => _secilenRenk;
  set renk(int value){
    this._secilenRenk = value;
  }

  int get kategori => _kategoriIsmi;
  set kategori(int value){
    this._kategoriIsmi = value;
  }

  int get tarih => _tarih;
  set tarih(int value){
    this._tarih = value;
  }


  Sayac(this._isim,this._kategoriIsmi,this._tarih,this._secilenRenk,[this._resim]);
  Sayac.withdID(this._id,this._isim,this._kategoriIsmi,this._tarih);

   Map<String,dynamic> toMap(){
     var map = Map<String,dynamic>();
     map['id'] = this._id;
     map['isim'] = this._isim;
     map['kategori'] = this._kategoriIsmi;
     map['tarih'] = this._tarih;
     map['renk'] = this._secilenRenk;
     map['resim'] = this._resim;
    return map;
  }

  Sayac.fromMap(Map<String,dynamic> map){
      this._id = map['id'];
      this._isim = map['isim'];
      this._kategoriIsmi = map['kategori'];
      this._tarih = map['tarih'];
      this._secilenRenk = map['renk'];
      this._resim = map['resim'];
  }

}