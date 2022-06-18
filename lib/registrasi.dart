// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mbanking/item_card.dart';
import 'text_ctrl.dart';
import 'landingpage.dart';

class RegPage extends StatelessWidget {
  const RegPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    TextController tc = Get.put(TextController());
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
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'JosefinSans',
                        ),
                      ))),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  //controller: tc.unamectrl,
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
                margin: EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  //controller: tc.passctrl,
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
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  //controller: tc.cpassctrl,
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
                      label: Center(child: Text('CONFRIM PASSWORD')),
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("REGISTER"),
              ),
              SizedBox(
                height: mediaQueryHeight / 11,
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

class RegBerhasil extends StatelessWidget {
  RegBerhasil({Key? key}) : super(key: key);
  TextController tc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 71, 104),
      body: Column(
        children: [
          const Spacer(),
          Center(
              child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    "BERHASIL REGISTRASI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'JosefinSans',
                    ),
                  ))),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/icon.png',
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   child: Text(
          //     "USERNAME ${tc.uname.value}",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 15,
          //       fontFamily: 'JosefinSans',
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   child: Text(
          //     "PASS ${tc.pass.value}",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 15,
          //       fontFamily: 'JosefinSans',
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   child: Text(
          //     "CPASS ${tc.cpass.value}",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 15,
          //       fontFamily: 'JosefinSans',
          //     ),
          //   ),
          // ),
          StreamBuilder<QuerySnapshot>(
              // stream: users.snapshots(),
              builder: (_, snapshot) {
            return (snapshot.hasData)
                ? Column(
                    children: snapshot.data!.docs
                        .map((e) => ItemCard(e.get('jenis'), e.get('jumlah'),
                            e.get('tujuan'), e.get('waktu')))
                        .toList(),
                  )
                : Text("Gagal");
          }),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              },
              child: const Text('KEMBALI'),
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: const Text(
              "JAZZ O'GIBRAN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'JosefinSans',
              ),
            ),
          ),
          const Text(
            "POWERED BY BANK INDONESIA",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'JosefinSans',
            ),
          ),
        ],
      ),
    );
  }
}
