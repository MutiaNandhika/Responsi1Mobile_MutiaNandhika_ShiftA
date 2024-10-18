import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/laporan_bulanan.dart';

class LaporanBulananBloc {
  static Future<List<LaporanBulanan>> getLaporanBulanans() async {
    String apiUrl = ApiUrl.getAllLaporanBulanan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listLaporan = (jsonObj as Map<String, dynamic>)['data'];
    List<LaporanBulanan> laporanBulanans = [];
    for (var laporan in listLaporan) {
      laporanBulanans.add(LaporanBulanan.fromJson(laporan));
    }
    return laporanBulanans;
  }

  static Future addLaporanBulanan({LaporanBulanan? laporan}) async {
    String apiUrl = ApiUrl.createLaporanBulanan;

    var body = {
      "month": laporan!.month,
      "income": laporan.income.toString(),
      "expenses": laporan.expenses.toString(),
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateLaporanBulanan({required LaporanBulanan laporan}) async {
    String apiUrl = ApiUrl.updateLaporanBulanan(laporan.id!);
    print(apiUrl);

    var body = {
      "month": laporan.month,
      "income": laporan.income,
      "expenses": laporan.expenses
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteLaporanBulanan({int? id}) async {
    String apiUrl = ApiUrl.deleteLaporanBulanan(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
