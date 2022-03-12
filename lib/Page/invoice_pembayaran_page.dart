import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spp_pkl/model/list_model.dart';

class InvoicePembayaranPage extends StatefulWidget {
  @override
  _InvoicePembayaranPageState createState() => _InvoicePembayaranPageState();
}

class _InvoicePembayaranPageState extends State<InvoicePembayaranPage> {
  List<Tagihan> allList = [];
  bool isLoading = false;
  Timer _timer;
  String jumlah = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        outapp(context);
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Invoice Pembayaran',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
            ),
            body: Container(
              child: isLoading
                  ? Center()
                  : allList.length == 0
                      ? Center(
                          child: Text("No Data Available"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(),
                            child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(top: 40, left: 10),
                                        child: Text("Yang Harus Dibayar",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      indent: 30,
                                      endIndent: 30,
                                      thickness: 2,
                                      height: 50,
                                    ),
                                    SizedBox(height: 10),
                                    SPPListJudul(),
                                    SizedBox(height: 20),
                                    buildList(allList),
                                    Divider(
                                      color: Colors.black,
                                      indent: 0,
                                      endIndent: 175,
                                      thickness: 2,
                                      height: 30,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          width: 100,
                                          child: Text(
                                            "jumlah",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0,
                                          width: 100,
                                        ),
                                        Container(
                                          child: Text(jumlah,
                                              style: TextStyle(
                                                  color: (jumlah == "Rp. 0"
                                                      ? Colors.green
                                                      : Colors.red),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ),
            )),
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

  @override
  void initState() {
    super.initState();
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    setState(() {
      isLoading = true;
      _timer?.cancel();
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
    });
    final prefs = await SharedPreferences.getInstance();
    jumlah = prefs.getString('jumlah') ?? '';

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString("token"),
    };
    final res = await http.get(
      Uri.parse("https://jurnal-online-spp.herokuapp.com/api/invoice"),
      headers: headers,
    );
    print("status code : " + res.statusCode.toString());
    print("headers : " + headers.toString());
    print("url : " +
        Uri.parse("https://jurnal-online-spp.herokuapp.com/api/invoice")
            .toString());

    if (res.statusCode == 200 || res.statusCode == 400) {
      try {
        ListModel listModel =
            ListModel.fromJson(json.decode(res.body.toString()));
        allList.addAll(listModel.tagihan);
      } catch (e) {
        print(e);
      }
    } else {}
    setState(() {
      isLoading = false;
      _timer?.cancel();
      EasyLoading.dismiss();
    });
  }

  Widget buildList(List<Tagihan> allList) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: 100,
                  child: Text(
                    allList[index].namaTagihan,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 100,
                ),
                Container(
                  child: Text(allList[index].jumlah_text,
                      style: TextStyle(
                          color: (allList[index].jumlah_text == "Rp. 0"
                              ? Colors.green
                              : Colors.red),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        );
      },
      itemCount: 6,
    );
  }

  final titles = ["Jenis Tagihan", "Jumlah"];
  Widget SPPListJudul() => Container(
        height: 20,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: titles.length,
          separatorBuilder: (context, _) => SizedBox(width: 10),
          itemBuilder: (context, index) {
            return Container(
              width: 175,
              child: Container(
                child: Align(
                    child: Text(
                  titles[index].toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
            );
          },
        ),
      );
}
