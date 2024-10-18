import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/laporan_bulanan_bloc.dart';
import '/model/laporan_bulanan.dart';
import '/ui/laporan_bulanan_detail.dart';
import '/ui/laporan_bulanan_form.dart';
import 'login_page.dart';

class LaporanBulananPage extends StatefulWidget {
  const LaporanBulananPage({Key? key}) : super(key: key);

  @override
  _LaporanBulananPageState createState() => _LaporanBulananPageState();
}

class _LaporanBulananPageState extends State<LaporanBulananPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Laporan Bulanan',
          style: TextStyle(
            fontFamily: 'ComicSans',
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add, size: 30, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaporanBulananForm(),
            ),
          );
        },
      ),
      drawer: Drawer(
        backgroundColor: Colors.orange,
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ComicSans',
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(Icons.logout, color: Colors.white),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: LaporanBulananBloc.getLaporanBulanans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ListLaporanBulanan(list: snapshot.data)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListLaporanBulanan extends StatelessWidget {
  final List? list;

  const ListLaporanBulanan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemLaporanBulanan(
          laporanBulanan: list![i],
        );
      },
    );
  }
}

class ItemLaporanBulanan extends StatelessWidget {
  final LaporanBulanan laporanBulanan;

  const ItemLaporanBulanan({Key? key, required this.laporanBulanan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LaporanBulananDetail(
              laporanBulanan: laporanBulanan,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.yellow.shade100,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          title: Text(
            laporanBulanan.month!,
            style: const TextStyle(
              fontFamily: 'ComicSans',
              fontSize: 20,
              color: Colors.orange,
            ),
          ),
          subtitle: Text(
            'Pemasukan: ${laporanBulanan.income} - Pengeluaran: ${laporanBulanan.expenses}',
            style: const TextStyle(
              fontFamily: 'ComicSans',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          leading: const Icon(Icons.account_balance_wallet, color: Colors.orange),
          trailing: const Icon(Icons.arrow_forward, color: Colors.orange),
        ),
      ),
    );
  }
}
