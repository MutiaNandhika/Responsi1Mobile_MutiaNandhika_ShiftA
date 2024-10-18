class ApiUrl {
  // Base URL untuk laporan bulanan
  static const String baseUrlLaporanBulanan =
      'http://responsi.webwizards.my.id/api/keuangan';

  // Base URL untuk registrasi dan login
  static const String baseUrlAuth = 'http://responsi.webwizards.my.id/api';

  static const String registrasi = baseUrlAuth + '/registrasi';
  static const String login = baseUrlAuth + '/login';

  // Endpoint untuk mengambil semua laporan bulanan
  static const String getAllLaporanBulanan =
      baseUrlLaporanBulanan + '/laporan_bulanan';

  // Endpoint untuk membuat laporan bulanan baru
  static const String createLaporanBulanan =
      baseUrlLaporanBulanan + '/laporan_bulanan';

  // Endpoint untuk memperbarui laporan bulanan berdasarkan ID
  static String updateLaporanBulanan(int id) {
    return baseUrlLaporanBulanan +
        '/laporan_bulanan/' +
        id.toString() +
        '/update';
  }

  // Endpoint untuk menampilkan satu laporan bulanan berdasarkan ID
  static String showLaporanBulanan(int id) {
    return baseUrlLaporanBulanan + '/laporan_bulanan/' + id.toString();
  }

  // Endpoint untuk menghapus laporan bulanan berdasarkan ID
  static String deleteLaporanBulanan(int id) {
    return baseUrlLaporanBulanan +
        '/laporan_bulanan/' +
        id.toString() +
        '/delete';
  }
}
