// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String uname = "", pass = "", cpass = "";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final unamectrl = TextEditingController();
  final cpassctrl = TextEditingController();
  final passctrl = TextEditingController();

  @override
  void dispose() {
    unamectrl.dispose();
    passctrl.dispose();
    cpassctrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unamectrl.addListener(() {});
  }

  Widget _buildPopupDialogFail(BuildContext context) {
    return AlertDialog(
      title: const Text('Gagal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Anda Gagal Login"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Kembali'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogSukses(BuildContext context) {
    return AlertDialog(
      title: const Text('Berhasil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Anda Berhasil Login"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.off(MyHomePage());
          },
          child: const Text('Lanjut ke Halaman Utama'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 71, 104),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: mediaQueryHeight / 7,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/icon.png',
                  ),
                ),
              ),
              Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'JosefinSans',
                        ),
                      ))),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  controller: unamectrl,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      label: Center(child: Text('USERNAME')),
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: TextFormField(
                  controller: passctrl,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      label: Center(child: Text('PASSWORD')),
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (unamectrl.text == '' || passctrl.text == '') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialogFail(context),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialogSukses(context),
                    );
                  }
                },
                child: const Text("LOGIN"),
              ),
              SizedBox(
                height: mediaQueryHeight / 6,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "JAZZ O'GIBRAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'JosefinSans',
                    ),
                  ),
                ),
              ),
              Center(
                child: const Text(
                  "POWERED BY BANK INDONESIA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'JosefinSans',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
