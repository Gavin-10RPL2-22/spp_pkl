import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spp_pkl/api/api_service.dart';
import 'package:spp_pkl/model/login_model.dart';
import 'package:spp_pkl/navigation/bottom_navigation_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer _timer;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hasValidNis = false;
  bool get canSubmitForm => hasValidNis;
  String nisErrorMessage;

  final TextEditingController _nisController = TextEditingController();

  void checkNIS(String nis) async {
    final response = await http.post(Uri.parse(
        'https://jurnal-online-spp.herokuapp.com/api/login?nis=$nis'));

    if (response.statusCode != 200) {
      setState(() {
        hasValidNis = false;
        nisErrorMessage = json.decode(response.body)["message"];
      });
    }

    if (response.statusCode == 200) {
      setState(() {
        hasValidNis = true;
      });
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _nisController.addListener(() {
      final nisInput = _nisController.value.text;
      if (nisInput.isNotEmpty) {
        checkNIS(nisInput);
      }
    });
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          outapp(context);
        },
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            body: isloading == false
                ? SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              margin: EdgeInsets.symmetric(
                                  vertical: 60, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20)
                                ],
                              ),
                              child: Form(
                                key: globalFormKey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 25),
                                    Container(
                                      width: 200,
                                      height: 200,
                                      child: Image(
                                        image: AssetImage("images/smkrus.png"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 75,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          "SMK RADEN UMAR SAID KUDUS",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 75),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        controller: _nisController,
                                        validator: (_) => hasValidNis
                                            ? null
                                            : nisErrorMessage,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5)
                                        ],
                                        onSaved: (input) =>
                                            loginRequestModel.nis = input,
                                        decoration: new InputDecoration(
                                          hintText: "NIS",
                                          enabledBorder: UnderlineInputBorder(),
                                          focusedBorder: UnderlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 100),
                                    MaterialButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 100),
                                      onPressed: () {
                                        if (validateAndSave()) {
                                          canSubmitForm ? loginapi() : null;
                                        }
                                      },
                                      child: Text(
                                        "Masuk",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Color(0xFF2CB3FF),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Center(),
          ),
        ));
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool isloading = false;
  void loginapi() {
    setState(() {
      isloading = true;
      _timer?.cancel();
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
    });
    APIService apiService = new APIService();
    apiService.login(loginRequestModel).then((value) async {
      if (value != null) {
        if (value.token.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs?.setBool("isLoggedIn", true);
          prefs.setString("token", value.token.toString());
          if (value.nama_siswa.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("nama_siswa", value.nama_siswa.toString());
            if (value.user.isNotEmpty) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("user", value.user.toString());
              if (value.jumlah.isNotEmpty) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("jumlah", value.jumlah.toString());
                setState(() {
                  isloading = false;
                  _timer?.cancel();
                  EasyLoading.dismiss();
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationBarTool()));
              }
            }
          }
        }
      }
    });
  }
}
