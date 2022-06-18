// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details.dart';

class Pembayaran extends StatefulWidget {
  const Pembayaran({Key? key}) : super(key: key);

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PEMBAYARAN"),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: Color.fromARGB(255, 36, 112, 163),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Get.to(Listrik());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/listrik_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      Text(
                        "LISTRIK",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(PDAM());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Center(
                      child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/water_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "PDAM",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      Spacer(),
                    ],
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(VirtualAkun());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/va_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            "VIRTUAL ACCOUNT",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
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

class Pembelian extends StatefulWidget {
  const Pembelian({Key? key}) : super(key: key);

  @override
  State<Pembelian> createState() => _PembelianState();
}

class _PembelianState extends State<Pembelian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PEMBELIAN"),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: Color.fromARGB(255, 36, 112, 163),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Get.to(Pulsa());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/pulsa_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      Text(
                        "ISI ULANG PULSA",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                    ],
                  ),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(LinkAja());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Center(
                      child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/linkaja_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "TOP UP LINKAJA",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                    ],
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(Gopay());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/gopay_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            "TOP UP GOPAY",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(Ovo());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/ovo_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            "TOP UP OVO",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
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
