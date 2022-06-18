// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mbanking/landingpage.dart';
import 'option.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  static final List<Widget> _pages = [
    Home(),
    Pay(),
    Contact(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text("MBANK"),
            backgroundColor: Color.fromARGB(255, 17, 66, 98),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(LandingPage());
                  },
                  child: Text("LOGOUT"),
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _index,
              onTap: (int index) {
                setState(() {
                  _index = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: _index == 0
                        ? Icon(Icons.home)
                        : Icon(Icons.home_outlined)),
                BottomNavigationBarItem(
                    label: "Pay", icon: Icon(Icons.currency_exchange)),
                BottomNavigationBarItem(
                  label: "Contact",
                  icon: _index == 2
                      ? Icon(Icons.contact_support)
                      : Icon(Icons.contact_support_outlined),
                )
              ]),
          body: _pages.elementAt(_index)),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Get.to(CekSaldo());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/bank_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      Text(
                        "CEK SALDO",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(Transfer());
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
                        'assets/transfer_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "TRANSFER",
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
                  Get.to(CekMutasi());
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
                        'assets/paper_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "CEK MUTASI",
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
        ],
      ),
    );
  }
}

class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Get.to(Pembayaran());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/pay_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      Text(
                        "PEMBAYARAN",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(Pembelian());
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
                        'assets/buy_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "PEMBELIAN",
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
        ],
      ),
    );
  }
}

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 112, 163),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(ContactUs());
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
                        'assets/contact_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "HUBUNGI KAMI",
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
        ],
      ),
    );
  }
}
