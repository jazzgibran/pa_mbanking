import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mbanking/details.dart';
import 'mainpage.dart';
import 'registrasi.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

var uname, pass;
final unamectrl = TextEditingController();
final passctrl = TextEditingController();
List<String> docIDs = [];

class _LoginPageState extends State<LoginPage> {
  Future getDocID() async {
    await FirebaseFirestore.instance.collection("users").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
            print(docIDs);
          }),
        );
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 71, 104),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                  child: const Text(
                    "WELCOME JAZZ, ENTER YOUR PASSWORD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'JosefinSans',
                    ),
                  ))),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: TextFormField(
              controller: passctrl,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  label: Center(child: Text('PASSWORD')),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (passctrl.text == pass) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialogSukses(context),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialogFail(context),
                    );
                  }
                },
                child: const Text("LOGIN"),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {
                  Get.to(ContactUs());
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GetUsername extends StatelessWidget {
  final String documentID;
  GetUsername({required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            uname = data['uname'];
            return Text("");
          }
          return Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          );
        })));
  }
}

class GetPass extends StatelessWidget {
  final String documentID;
  GetPass({required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            pass = data['pass'];
            return Text("");
          }
          return Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          );
        })));
  }
}
