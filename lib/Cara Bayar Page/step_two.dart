import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:steps/steps.dart';

class Kedua extends StatefulWidget {
  const Kedua({Key key}) : super(key: key);

  @override
  _KeduaState createState() => _KeduaState();
}

class _KeduaState extends State<Kedua> {
  String font = 'OpenSans';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: const Text('Cara Melakukan Pembayaran',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white),
        body: Container(
          alignment: Alignment.topCenter,
          child: Steps(
            direction: Axis.vertical,
            size: 15.0,
            path: {'color': Colors.lightGreen.shade200, 'width': 3.0},
            steps: [
              {
                'color': Colors.white,
                'background': Colors.lightGreen.shade300,
                'label': '1',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '''
Pilih menu "Pembayaran"''',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: font,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              },
              {
                'color': Colors.white,
                'background': Colors.lightGreen.shade400,
                'label': '2',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Isi kolom nomor rekening anda, pilih jenis pembayaran :',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: font,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '''
                        
1. Akademik SMK RUS Kudus
2. Input No. Pembayaran dengan Nomor Induk Siswa/i
3. Klik "Verifikasi Aplikasi Pembayaran"''',
                      style: TextStyle(fontSize: 12.7, fontFamily: font),
                    ),
                  ],
                )
              },
              {
                'color': Colors.white,
                'background': Colors.lightGreen.shade500,
                'label': '3',
                'content': Text(
                  '''
Pastikan jenis pembayaran, nama & jumlah telah sesuai isi kolom nomor TAN dan PIN Otorisasi. Nomor TAN dan PIN Otorisasi akan anda dapatkan saat membuka aplikasi BSM Netbanking''',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: font,
                      fontWeight: FontWeight.bold),
                ),
              },
              {
                'color': Colors.white,
                'background': Colors.lightGreen.shade600,
                'label': '4',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '''
Transaksi Selesai''',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: font,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '''
simpan/cetak struk sebagai bukti pembayaran yang sah''',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.lightGreen.shade600,
                          fontFamily: font,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                )
              },
            ],
          ),
        ),
      ),
    );
  }
}
