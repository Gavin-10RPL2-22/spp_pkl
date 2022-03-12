import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spp_pkl/Cara%20Bayar%20Page/step_one.dart';
import 'package:spp_pkl/Cara%20Bayar%20Page/step_two.dart';

class CaraBayarPage extends StatefulWidget {
  @override
  _CaraBayarPageState createState() => _CaraBayarPageState();
}

class _CaraBayarPageState extends State<CaraBayarPage> {
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    _timer?.cancel();
    EasyLoading.dismiss();
    return WillPopScope(
      onWillPop: () {
        outapp(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text('Petunjuk Pembayaran Uang SPP',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white),
          body: Container(
            color: Color(0xFFF2F5FD),
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 5, left: 10),
                    child: Text("Kode BSM : 451",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text("Kode BPI Pendidikan : 900",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text("Kode SMK RUS Kudus : 3370",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                buildFirstStep(),
                buildSecondStep(),
                SizedBox(
                  height: 150,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width: 500,
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                        "MOHON UNTUK SIMPAN DAN COPY BUKTI PEMBAYARAN INI SEBAGAI TANDA BUKTI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void outapp(BuildContext ctx) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(ctx).pop();
      },
    );

    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        exit(0);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Yakin mau keluar?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildFirstStep() => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => Pertama()),
          );
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                      height: 75,
                      width: 75,
                      image: AssetImage("images/mandiri.png"),
                    ),
                    Image(
                      height: 100,
                      width: 100,
                      image: AssetImage("images/atm_bersama.png"),
                    ),
                    Image(
                      height: 53,
                      width: 53,
                      image: AssetImage("images/atm_prima.png"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      height: 65,
                      width: 65,
                      image: AssetImage("images/bca.png"),
                    ),
                  ],
                ),
                Text(
                  '1. Pembayaran Melalui ATM',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
  Widget buildSecondStep() => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => Kedua()),
          );
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image(
                  height: 100,
                  width: 100,
                  image: AssetImage("images/mandiri_syariah.png"),
                ),
                Text(
                  '2. Pembayaran Melalui BSM Netbanking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
}
