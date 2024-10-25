import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BeliBarangScreen(),
  ));
}

class BeliBarangScreen extends StatefulWidget {
  @override
  _BeliBarangScreenState createState() => _BeliBarangScreenState();
}

class _BeliBarangScreenState extends State<BeliBarangScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahBeliController = TextEditingController();
  int _jumlahBeli = 0;
  final int harga = 30000000;
  final int stok = 20;
  double _diskon = 0;
  double _total = 0;
  double _grandTotal = 0;

  void _calculateTotal() {
    setState(() {
      _jumlahBeli = int.tryParse(_jumlahBeliController.text) ?? 0;
      _total = harga * _jumlahBeli;

      if (_total > 10000000) {
        _diskon = _total * 10 / 100;
      } else {
        _diskon = 0;
      }

      _grandTotal = _total - _diskon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beli Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pelanggan', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 20),
            Text('Produk', style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(labelText: 'Kode Barang'),
              readOnly: true,
              controller: TextEditingController(text: 'K001'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nama Barang'),
              readOnly: true,
              controller: TextEditingController(text: 'Macbook Pro'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Harga'),
              readOnly: true,
              controller: TextEditingController(text: harga.toString()),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Stok'),
              readOnly: true,
              controller: TextEditingController(text: stok.toString()),
            ),
            TextField(
              controller: _jumlahBeliController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah Beli'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _calculateTotal();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPembelianScreen(
                      nama: _namaController.text,
                      kodeBarang: 'K001',
                      namaBarang: 'Macbook Pro',
                      harga: harga,
                      jumlahBeli: _jumlahBeli,
                      total: _total,
                      diskon: _diskon,
                      grandTotal: _grandTotal,
                    ),
                  ),
                );
              },
              child: Text('Beli'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPembelianScreen extends StatelessWidget {
  final String nama;
  final String kodeBarang;
  final String namaBarang;
  final int harga;
  final int jumlahBeli;
  final double total;
  final double diskon;
  final double grandTotal;

  DetailPembelianScreen({
    required this.nama,
    required this.kodeBarang,
    required this.namaBarang,
    required this.harga,
    required this.jumlahBeli,
    required this.total,
    required this.diskon,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pembelian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pelanggan: $nama', style: TextStyle(fontSize: 18)),
            Text('Kode Barang: $kodeBarang', style: TextStyle(fontSize: 18)),
            Text('Nama Barang: $namaBarang', style: TextStyle(fontSize: 18)),
            Text('Harga: $harga', style: TextStyle(fontSize: 18)),
            Text('Jumlah Beli: $jumlahBeli', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Total: $total', style: TextStyle(fontSize: 18)),
            Text('Diskon: ${diskon > 0 ? '10%' : '0%'}', style: TextStyle(fontSize: 18)),
            Text('Total potongan Diskon: $diskon', style: TextStyle(fontSize: 18)),
            Text('Grand Total: $grandTotal', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
