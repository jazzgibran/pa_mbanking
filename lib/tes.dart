import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = firestore.collection("users");

late String saldo;

class getSaldo extends StatelessWidget {
  const getSaldo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc("USsYV3qsASm5LHd3WFL8").get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            saldo = data['saldo'];
            return Text(saldo);
          }
          return Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          );
        })));
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
  }

  final jumlahctrl = TextEditingController();
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 71, 104),
      body: ListView(
        children: [
          getSaldo(),
          Center(
            child: SizedBox(
              width: 320,
              child: TextFormField(
                controller: jumlahctrl,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    label: Text("Masukkan Jumlah"),
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (int.parse(saldo) > int.parse(jumlahctrl.text)) {
                  total = int.parse(saldo) - int.parse(jumlahctrl.text);
                  saldo = total.toString();
                  users.doc("USsYV3qsASm5LHd3WFL8").update({'saldo': saldo});
                }
              },
              child: Text("pencet")),
          Text("$total")
          // Container(
          //   margin: EdgeInsets.only(bottom: 20),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       hasilkurang(saldo, int.parse(jumlahctrl.text));
          //       print(saldo);
          //     },
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          //     ),
          //     child: SizedBox(
          //       width: 320,
          //       child: Center(
          //         child: Text(
          //           'KIRIM',
          //           style: TextStyle(
          //               fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
