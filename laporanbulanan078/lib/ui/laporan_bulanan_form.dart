import 'package:flutter/material.dart';
import '../bloc/laporan_bulanan_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/laporan_bulanan.dart';
import 'laporan_bulanan_page.dart';

// ignore: must_be_immutable
class LaporanBulananForm extends StatefulWidget {
  LaporanBulanan? laporanBulanan;
  LaporanBulananForm({Key? key, this.laporanBulanan}) : super(key: key);
  @override
  _LaporanBulananFormState createState() => _LaporanBulananFormState();
}

class _LaporanBulananFormState extends State<LaporanBulananForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH LAPORAN BULANAN";
  String tombolSubmit = "SIMPAN";
  final _monthTextboxController = TextEditingController();
  final _incomeTextboxController = TextEditingController();
  final _expensesTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.laporanBulanan != null) {
      setState(() {
        judul = "UBAH LAPORAN BULANAN";
        tombolSubmit = "UBAH";
        _monthTextboxController.text = widget.laporanBulanan!.month!;
        _incomeTextboxController.text =
            widget.laporanBulanan!.income.toString();
        _expensesTextboxController.text =
            widget.laporanBulanan!.expenses.toString();
      });
    } else {
      judul = "TAMBAH LAPORAN BULANAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(
            fontFamily: 'ComicSans',
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _monthTextField(),
                const SizedBox(height: 16),
                _incomeTextField(),
                const SizedBox(height: 16),
                _expensesTextField(),
                const SizedBox(height: 30),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox untuk Bulan
  Widget _monthTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Bulan",
        labelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          color: Colors.orange,
          fontSize: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _monthTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bulan harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox untuk Pemasukan (Income)
  Widget _incomeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Pemasukan",
        labelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          color: Colors.orange,
          fontSize: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _incomeTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Pemasukan harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox untuk Pengeluaran (Expenses)
  Widget _expensesTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Pengeluaran",
        labelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          color: Colors.orange,
          fontSize: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _expensesTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Pengeluaran harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return ElevatedButton(
      child: Text(
        tombolSubmit,
        style: const TextStyle(
          fontFamily: 'ComicSans',
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.laporanBulanan != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    LaporanBulanan createLaporanBulanan = LaporanBulanan(id: null);
    createLaporanBulanan.month = _monthTextboxController.text;
    createLaporanBulanan.income = int.parse(_incomeTextboxController.text);
    createLaporanBulanan.expenses = int.parse(_expensesTextboxController.text);
    LaporanBulananBloc.addLaporanBulanan(laporan: createLaporanBulanan).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const LaporanBulananPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    LaporanBulanan updateLaporanBulanan =
        LaporanBulanan(id: widget.laporanBulanan!.id!);
    updateLaporanBulanan.month = _monthTextboxController.text;
    updateLaporanBulanan.income = int.parse(_incomeTextboxController.text);
    updateLaporanBulanan.expenses = int.parse(_expensesTextboxController.text);
    LaporanBulananBloc.updateLaporanBulanan(laporan: updateLaporanBulanan)
        .then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const LaporanBulananPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
