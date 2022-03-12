import 'dart:convert';

ListModel listModelFromJson(String str) => ListModel.fromJson(json.decode(str));

String listModelToJson(ListModel data) => json.encode(data.toJson());

class ListModel {
  ListModel({
    this.walikelas,
    this.kelas,
    this.tagihan,
  });

  String walikelas;
  dynamic kelas;
  List<Tagihan> tagihan;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        walikelas: json["walikelas"],
        kelas: json["kelas"] == null ? "no data" : json["kelas"],
        tagihan:
            List<Tagihan>.from(json["tagihan"].map((x) => Tagihan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "walikelas": walikelas,
        "kelas": kelas,
        "tagihan": List<dynamic>.from(tagihan.map((x) => x.toJson())),
      };
}

class Tagihan {
  Tagihan({
    this.id,
    this.nis,
    this.namaTagihan,
    this.jumlah,
    this.jumlah_text,
  });

  int id;
  String nis;
  String namaTagihan;
  String jumlah;
  String jumlah_text;

  factory Tagihan.fromJson(Map<String, dynamic> json) => Tagihan(
        id: json["id"],
        nis: json["nis"],
        namaTagihan: json["namaTagihan"],
        jumlah: json["jumlah"],
        jumlah_text: json["jumlah_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nis": nis,
        "namaTagihan": namaTagihan,
        "jumlah": jumlah,
        "jumlah_text": jumlah_text,
      };
}
