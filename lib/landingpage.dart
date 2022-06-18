// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'login.dart';
import 'registrasi.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
                    "MOBILE BANKING",
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
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(LoginPage());
                    },
                    child: const Text("LOGIN", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Container(
          //   margin: EdgeInsets.only(bottom: 4),
          //   child: const Text(
          //     "JAZZ O'GIBRAN",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 15,
          //       fontFamily: 'JosefinSans',
          //     ),
          //   ),
          // ),
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
