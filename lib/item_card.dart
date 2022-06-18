import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String jenis;
  final int jumlah;
  final String tujuan;
  final String waktu;

  ItemCard(this.jenis, this.jumlah, this.tujuan, this.waktu);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$waktu $jenis",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "IDR $jumlah Bill Pay to $tujuan",
              )
            ],
          ),
        ],
      ),
    );
  }
}
