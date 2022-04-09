import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:steps/steps.dart';

class Pertama extends StatefulWidget {
  const Pertama({Key key}) : super(key: key);

  @override
  _PertamaState createState() => _PertamaState();
}

class _PertamaState extends State<Pertama> {
  String font = 'OpenSans';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      top: true,
      right: true,
      maintainBottomViewPadding: true,
      minimum: EdgeInsets.zero,
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
              path: {'color': Colors.lightBlue.shade200, 'width': 3.0},
              steps: [
                {
                  'color': Colors.white,
                  'background': Colors.lightBlue.shade300,
                  'label': 'A',
                  'content': Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '''
1. Pilih menu transfer
2. Pilih menu rakening''',
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
                  'background': Colors.lightBlue.shade400,
                  'label': 'B',
                  'content': Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Input tujuan rekening dengan mengisi :',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: font,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '''
                        
1. Ketik kode Bank Syariah Mandiri (BSM) : 451
2. Ketik kode pembayaran pendidikan : 900
3. Ketik kode SMK RUS Kudus : 3370
4. Ketik NIM siswa/i atau nomor tagihan pembayaran''',
                        style: TextStyle(fontSize: 12.7, fontFamily: font),
                      ),
                      Text(
                        '''
5. Khusus untuk mesin ATM BCA
   contoh pengektikan : 
   a. Masukkan dahulu kode BSM 451
   b. Masukkan kode 9003370xxxxx''',
                        style: TextStyle(
                            color: Colors.lightBlue.shade500,
                            fontSize: 13.0,
                            fontFamily: font,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  )
                },
                {
                  'color': Colors.white,
                  'background': Colors.lightBlue.shade500,
                  'label': 'C',
                  'content': Text(
                    '''
Pilih menu : Benar / Salah''',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: font,
                        fontWeight: FontWeight.bold),
                  ),
                },
                {
                  'color': Colors.white,
                  'background': Colors.lightBlue.shade600,
                  'label': 'D',
                  'content': Text(
                    '''
Masukkan jumlah pembayaran''',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: font,
                        fontWeight: FontWeight.bold),
                  ),
                },
                {
                  'color': Colors.white,
                  'background': Colors.lightBlue.shade700,
                  'label': 'E',
                  'content': Text(
                    '''
Menu konfirmasi akan mucul, cek kembali nama rekening tujuan & jumlah sesuai tagihan.''',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: font,
                        fontWeight: FontWeight.bold),
                  ),
                },
                {
                  'color': Colors.white,
                  'background': Colors.lightBlue.shade800,
                  'label': 'F',
                  'content': Text(
                    '''
Anda akan dikenakan biaya transfer antar bank dan biaya administrasi Edupay''',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: font,
                        fontWeight: FontWeight.bold),
                  ),
                },
              ],
            ),
          )),
    );
  }
}
