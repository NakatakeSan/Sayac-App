import 'dart:async';
import 'dart:io';
import 'package:sayac/models/sayac.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {


  static DatabaseHelper _databaseHelper;
  static Database _database;

  String _sayacTablo = 'sayac';
  String _columnID = 'id';
  String _columnIsim = 'isim';
  String _columnKategori = 'kategori';
  String _columnTarih = 'tarih';
  String _columnRenk = 'renk';
  String _columnResim = 'resim';

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    if (_databaseHelper == null) {
      print("DATA BASE HELPER NULL, OLUSTURULACAK");
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      print("DATA BASE HELPER NULL DEGIL");
      return _databaseHelper;
    }
  }

  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("DATA BASE NESNESI NULL, OLUSTURULACAK");
      _database = await _initializeDatabase();
      return _database;
    } else {
      print("DATA BASE NESNESI NULL DEĞİL");
      return _database;
    }
  }

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String path = join(klasor.path, "sayac.db");
    print("Olusan veritabanının tam yolu : $path");

    var ogrenciDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return ogrenciDB;
  }

  Future _createDB(Database db, int version) async {
    print("CREATE DB METHODU CALISTI TABLO OLUSTURULACAK");
    await db.execute(
        "CREATE TABLE $_sayacTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnKategori INTEGER,$_columnTarih INTEGER,$_columnRenk INTEGER,$_columnResim TEXT)");
  }

  Future<int> sayacEkle(Sayac gege) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_sayacTablo, gege.toMap());
    return sonuc;
  }

  Future<List<Map<String,dynamic>>> tumSayaclar() async{
    var db = await _getDatabase();
    var sonuc = db.query(_sayacTablo);
    return sonuc;
  }

  Future<int> sayacGuncelle(Sayac gege) async{
    var db = await _getDatabase();
    var sonuc = db.update(_sayacTablo, gege.toMap(),where: '$_columnID = ?' , whereArgs: [gege.id]);
    return sonuc;
  }
  Future<int> sayacSil(int id) async{
    var db = await _getDatabase();
    var sonuc = db.delete(_sayacTablo , where: '$_columnID = ?', whereArgs: [id]);
    return sonuc;
  }

  Future<int> tumTabloyuSil() async{
    var db = await _getDatabase();
    var sonuc = db.delete(_sayacTablo);
    return sonuc;
  }

}