import 'package:flutter/material.dart';
import '../bloc/laporan_bulanan_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/laporan_bulanan.dart';
import '/ui/laporan_bulanan_form.dart';
import 'laporan_bulanan_page.dart';

// ignore: must_be_immutable
class LaporanBulananDetail extends StatefulWidget {
  LaporanBulanan? laporanBulanan;

  LaporanBulananDetail({Key? key, this.laporanBulanan}) : super(key: key);

  @override
  _LaporanBulananDetailState createState() => _LaporanBulananDetailState();
}

class _LaporanBulananDetailState extends State<LaporanBulananDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Laporan Bulanan',
          style: TextStyle(
            fontFamily: 'ComicSans', // Menggunakan font Comic Sans
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.orange, // Warna latar belakang AppBar oranye
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bulan: ${widget.laporanBulanan!.month}",
                style: const TextStyle(
                  fontFamily: 'ComicSans',
                  fontSize: 20.0,
                  color: Colors.orange, // Warna teks oranye
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Pemasukan: Rp. ${widget.laporanBulanan!.income}",
                style: const TextStyle(
                  fontFamily: 'ComicSans',
                  fontSize: 18.0,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Pengeluaran: Rp. ${widget.laporanBulanan!.expenses}",
                style: const TextStyle(
                  fontFamily: 'ComicSans',
                  fontSize: 18.0,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              const SizedBox(height: 30),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(
              fontFamily: 'ComicSans',
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LaporanBulananForm(
                  laporanBulanan: widget.laporanBulanan!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 20),
        // Tombol Hapus
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(
              fontFamily: 'ComicSans',
              fontSize: 16,
            ),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.orange, // Warna latar belakang oranye
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'ComicSans', // Warna teks hitam dengan font Comic Sans
        ),
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text(
            "Ya",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'ComicSans', // Warna teks hitam dengan font Comic Sans
            ),
          ),
          onPressed: () {
            LaporanBulananBloc.deleteLaporanBulanan(
                    id: widget.laporanBulanan!.id!)
                .then(
                    (value) => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const LaporanBulananPage()))
                        }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text(
            "Batal",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'ComicSans', // Warna teks hitam dengan font Comic Sans
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
