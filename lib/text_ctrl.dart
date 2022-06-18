import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'registrasi.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference mutasi = firestore.collection("mutasi");

class TextController extends GetxController {
  var jumlah = ''.obs;
  var tujuan = ''.obs;
  var jenis;

  final TextEditingController tujuanctrl = TextEditingController();
  final TextEditingController jumlahctrl = TextEditingController();

  onPressed() {
    tujuan(tujuanctrl.text);
    jumlah(jumlahctrl.text);

    mutasi.add(
        {'tujuan': tujuanctrl.text, 'jumlah': jumlahctrl.text, 'jenis': jenis});
  }

  @override
  void onClose() {
    // TODO: implement onClose
    tujuanctrl.dispose();
    jumlahctrl.dispose();
    super.onClose();
  }
}
