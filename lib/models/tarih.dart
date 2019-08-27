class Tarih {
  int id;
  String isim;
  String tarih;

  Tarih({this.id, this.isim});

  Tarih.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isim = json['isim'];
    tarih = json['tarih'];
  }
}