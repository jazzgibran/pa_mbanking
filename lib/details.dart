// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:pa_mbanking/mainpage.dart';

import 'item_card.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference mutasi = firestore.collection("mutasi");
CollectionReference users = FirebaseFirestore.instance.collection('users');

late String saldo;
void add(
  BuildContext context,
  TextEditingController tujuanctrl,
  TextEditingController jumlahctrl,
  Function _buildPopupDialogFail,
  Function _buildPopupDialogSukses,
  String Jenis,
) {
  String cdate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  mutasi
      .add({
        'tujuan': tujuanctrl.text,
        'jumlah': int.tryParse(jumlahctrl.text) ??
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialogFail(context),
            ),
        'jenis': Jenis,
        'waktu': cdate
      })
      .then((result) => showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialogSukses(context),
          ))
      .then((value) => Get.off(
          Struk(Jenis, int.parse(jumlahctrl.text), tujuanctrl.text, cdate)))
      .catchError((e) {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialogFail(context),
        );
      });
}

void onPressed(
    BuildContext context,
    TextEditingController tujuanctrl,
    TextEditingController jumlahctrl,
    Function _buildPopupDialogFail,
    Function _buildPopupDialogSukses,
    String Jenis,
    int total) {
  if (tujuanctrl.text == "" || jumlahctrl.text == "") {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialogFail(context),
    );
  } else {
    try {
      int tujuan = int.parse(tujuanctrl.text);
      if (int.parse(saldo) > int.parse(jumlahctrl.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Konfirmasi Transaksi?"),
                Text("Saldo anda : $saldo"),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Kembali'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      total = int.parse(saldo) - int.parse(jumlahctrl.text);
                      saldo = total.toString();
                      users
                          .doc("USsYV3qsASm5LHd3WFL8")
                          .update({'saldo': saldo});
                      add(
                          context,
                          tujuanctrl,
                          jumlahctrl,
                          _buildPopupDialogFail,
                          _buildPopupDialogSukses,
                          Jenis);
                    },
                    child: const Text('Konfirmasi'),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Gagal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Saldo tidak cukup"),
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
          ),
        );
      }
    } on FormatException {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialogFail(context),
      );
    }
  }
}

class Struk extends StatelessWidget {
  final String jenis;
  final int jumlah;
  final String tujuan;
  final String waktu;

  Struk(this.jenis, this.jumlah, this.tujuan, this.waktu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "STRUK PEMBAYARAN",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(
        children: [
          getSaldo(),
          SizedBox(
            height: 50,
          ),
          Container(
              width: 300,
              margin: EdgeInsets.only(bottom: 7),
              child: Text(
                "Transaksi anda telah berhasil",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: 300,
              height: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Sumber Rekening : 0002001300248960",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "Date Time : $waktu",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "Jenis Transaksi : $jenis",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "Tujuan : $tujuan",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "Jumlah : Rp $jumlah",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: Text(
                    "Saldo : Rp $saldo",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => MyHomePage());
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                'KEMBALI KE HOME',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 17, 66, 98)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RekSumber extends StatefulWidget {
  const RekSumber({Key? key}) : super(key: key);

  @override
  State<RekSumber> createState() => _RekSumberState();
}

class _RekSumberState extends State<RekSumber> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSaldo(),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Column(
            children: [
              Text(
                "Rekening Sumber",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 320,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    "0002001300248960",
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 66, 98), fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

Widget _buildPopupDialogFail(BuildContext context) {
  return AlertDialog(
    title: const Text('Gagal'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Masukkan inputan yang sesuai"),
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
        Text("Anda Berhasil Transfer"),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Get.back();
          Get.back();
        },
        child: const Text('Menuju Struk'),
      ),
    ],
  );
}

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
            return Text("");
          }
          return Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          );
        })));
  }
}

class CekSaldo extends StatefulWidget {
  const CekSaldo({Key? key}) : super(key: key);

  @override
  State<CekSaldo> createState() => _CekSaldoState();
}

class _CekSaldoState extends State<CekSaldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SALDO",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(
        children: [
          getSaldo(),
          SizedBox(
            height: 50,
          ),
          Container(
              width: 300,
              margin: EdgeInsets.only(bottom: 7),
              child: Text(
                "Informasi Rekening :",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: 300,
              height: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Rekening / Giro",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            width: 300,
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "0002001300248960",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Text(
                    "Saldo : Rp $saldo",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          // Container(
          //   margin: EdgeInsets.only(bottom: 20),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          //     ),
          //     child: Text(
          //       'KEMBALI',
          //       style: TextStyle(
          //           fontSize: 12, color: Color.fromARGB(255, 17, 66, 98)),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final tujuanctrl = TextEditingController();
  final jumlahctrl = TextEditingController();
  int total = 0;
  @override
  void dispose() {
    tujuanctrl.dispose();
    jumlahctrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TRANSFER",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "Rekening Tujuan",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor Rekening"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Jumlah",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, jumlahctrl, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "TRF_BANK", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class CekMutasi extends StatefulWidget {
  const CekMutasi({Key? key}) : super(key: key);

  @override
  State<CekMutasi> createState() => _CekMutasiState();
}

class _CekMutasiState extends State<CekMutasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MUTASI",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text(
            "Menampilkan Mutasi Rekening",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          width: 330,
          height: 2,
          color: Colors.white,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 330,
          height: 390,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream:
                        mutasi.orderBy("waktu", descending: true).snapshots(),
                    builder: (_, snapshot) {
                      return (snapshot.hasData)
                          ? Column(
                              children: snapshot.data!.docs
                                  .map((e) => ItemCard(
                                      e.get('jenis'),
                                      e.get('jumlah'),
                                      e.get('tujuan'),
                                      e.get('waktu')))
                                  .toList(),
                            )
                          : Text("Gagal");
                    }),
              ],
            )),
          ),
        ),
      ]),
    );
  }
}

class Listrik extends StatefulWidget {
  const Listrik({Key? key}) : super(key: key);

  @override
  State<Listrik> createState() => _ListrikState();
}

class _ListrikState extends State<Listrik> {
  final tujuanctrl = TextEditingController();
  final biaya = TextEditingController(text: "500000");
  int total = 0;
  @override
  void dispose() {
    tujuanctrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PEMBAYARAN LISTRIK",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "PLN POSTPAID",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor Pelanggan"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, biaya, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "PLN", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class PDAM extends StatefulWidget {
  const PDAM({Key? key}) : super(key: key);

  @override
  State<PDAM> createState() => _PDAMState();
}

class _PDAMState extends State<PDAM> {
  final tujuanctrl = TextEditingController();
  final biaya = TextEditingController(text: "120000");
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PEMBAYARAN PDAM",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "PDAM",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor Pelanggan"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, biaya, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "PDAM", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class VirtualAkun extends StatefulWidget {
  const VirtualAkun({Key? key}) : super(key: key);

  @override
  State<VirtualAkun> createState() => _VirtualAkunState();
}

class _VirtualAkunState extends State<VirtualAkun> {
  final tujuanctrl = TextEditingController();
  final biaya = TextEditingController(text: "300000");
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "VIRTUAL ACCOUNT",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        getSaldo(),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Column(
            children: [
              Text(
                "Rekening Sumber",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 320,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    "0002001300248960",
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 66, 98), fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Virtual Account",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor Virtual Account"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, biaya, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "VA", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Pulsa extends StatefulWidget {
  const Pulsa({Key? key}) : super(key: key);

  @override
  State<Pulsa> createState() => _PulsaState();
}

class _PulsaState extends State<Pulsa> {
  final tujuanctrl = TextEditingController();
  final jumlahctrl = TextEditingController();
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ISI ULANG PULSA",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "Nomor Tujuan",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor HP"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Nominal",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                  label: Text("Masukkan Nominal Pulsa"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, jumlahctrl, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "Pulsa", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class LinkAja extends StatefulWidget {
  const LinkAja({Key? key}) : super(key: key);

  @override
  State<LinkAja> createState() => _LinkAjaState();
}

class _LinkAjaState extends State<LinkAja> {
  final tujuanctrl = TextEditingController();
  final jumlahctrl = TextEditingController();
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOP UP LINKAJA",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "Nomor Tujuan",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor LinkAja"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Nominal",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                  label: Text("Masukkan Nominal Saldo"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, jumlahctrl, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "LinkAja", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Gopay extends StatefulWidget {
  const Gopay({Key? key}) : super(key: key);

  @override
  State<Gopay> createState() => _GopayState();
}

class _GopayState extends State<Gopay> {
  final tujuanctrl = TextEditingController();
  final jumlahctrl = TextEditingController();
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOP UP GOPAY",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "Nomor Tujuan",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor GoPay"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Nominal",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                  label: Text("Masukkan Nominal Saldo"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, jumlahctrl, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "GoPay", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Ovo extends StatefulWidget {
  const Ovo({Key? key}) : super(key: key);

  @override
  State<Ovo> createState() => _OvoState();
}

class _OvoState extends State<Ovo> {
  final tujuanctrl = TextEditingController();
  final jumlahctrl = TextEditingController();
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOP UP OVO",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Column(children: [
        RekSumber(),
        Text(
          "Nomor Tujuan",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: tujuanctrl,
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
                  label: Text("Masukkan Nomor OVO"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Nominal",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                  label: Text("Masukkan Nominal Saldo"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              onPressed(context, tujuanctrl, jumlahctrl, _buildPopupDialogFail,
                  _buildPopupDialogSukses, "OVO", total);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'KIRIM',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 17, 66, 98)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CONTACT US",
        ),
        backgroundColor: Color.fromARGB(255, 17, 66, 98),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 112, 163),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 7),
                child: Text(
                  "Hubungi Kami di :",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Icon(Icons.email),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 3,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text("abcd@gmail.com"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Icon(Icons.phone),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 3,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text("0808080808"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Icon(Icons.link),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 3,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text("www.abcd.com"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
