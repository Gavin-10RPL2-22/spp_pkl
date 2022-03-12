import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spp_pkl/Page/splash_screen_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Timer _timer;
  String name = '';
  String user = '';
  String jumlah = '';
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    getsetpreference();
  }

  void getsetpreference() async {
    setState(() {
      isloading = true;
      _timer?.cancel();
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('nama_siswa') ?? '';
    user = prefs.getString('user') ?? '';
    jumlah = prefs.getString('jumlah') ?? '';
    setState(() {
      isloading = false;
      _timer?.cancel();
      EasyLoading.dismiss();
    });
  }

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
            title: Text('Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          body: Container(
            child: isloading
                ? Center()
                : name.isEmpty || user.isEmpty || jumlah.isEmpty
                    ? Center(
                        child: Text("No Data Available"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 75),
                            Center(
                              child: Image(
                                image: AssetImage("images/profile_picture.png"),
                              ),
                            ),
                            SizedBox(height: 70),
                            Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nama Siswa",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50, top: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "NIS",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50, top: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  user,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total Pembayaran :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50, top: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  jumlah,
                                  style: TextStyle(
                                      color: (jumlah == "Rp. 0"
                                          ? Colors.green
                                          : Colors.red),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              minWidth: 300.0,
                              height: 50.0,
                              color: Color(0xFFFF3A3A),
                              textColor: Colors.white,
                              onPressed: () {
                                logoutUser(context);
                              },
                              child: Text('Keluar'),
                            ),
                          ],
                        ),
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

  void logoutUser(BuildContext ctx) async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(ctx).pop();
      },
    );

    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.of(ctx).push(MaterialPageRoute(
            builder: (BuildContext context) => SplashScreenPage()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Yakin mau logout?"),
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
}
