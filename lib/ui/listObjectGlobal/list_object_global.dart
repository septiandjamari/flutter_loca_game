class ListObjectGlobal {
  static List<RadioKategori> listRadioKategori = [
    RadioKategori(index: 0, keterangan: "Semua"),
    RadioKategori(index: 1, keterangan: "Makanan"),
    RadioKategori(index: 2, keterangan: "Rokok Eceran"),
    RadioKategori(index: 3, keterangan: "Minuman Dingin"),
  ];

  static List<DaftarBarang> listDaftarBarang = [
    DaftarBarang(index: 0, stok: 178, nama: "aqua", harga: "Rp.2,500"),
    DaftarBarang(index: 1, stok: 0, nama: "rokok eaaa", harga: "Rp.1,300"),
    DaftarBarang(index: 2, stok: 38, nama: "rokok surya ecer", harga: "Rp.1,500"),
    DaftarBarang(index: 3, stok: 0, nama: "sayur kol", harga: "Rp.2,000"),
    DaftarBarang(index: 4, stok: 0, nama: "tahu", harga: "Rp.1,000"),
  ];
}

class RadioKategori {
  int index;
  String keterangan;
  RadioKategori({required this.index, required this.keterangan});
}

class DaftarBarang {
  int index;
  int stok;
  String nama;
  String harga;
  DaftarBarang({
    required this.index,
    required this.stok,
    required this.nama,
    required this.harga,
  });
}
