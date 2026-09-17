void main() {
  tampilkanBiodata();
}

// Variabel informasi anggota
String nama = "Abuzar Al Gifari";
int umur = 19;
double tinggiBadan = 173;
bool statusAktif = true;

List<String> bukuFavorit = [
  "Dilan 1998",
  "Bumi",
  "Filosofi Teras"
];

Map<String, String> informasiTambahan = {
  "alamat": "Jl. CIBADAK  NO.15",
  "profesi": "Pelajar"
};

/*
  saya adalah Abuzar Al Gifari. hobby saya bermaiin bola, saya juga suka berlari.
*/

/// Menampilkan seluruh informasi biodata anggota.
void tampilkanBiodata() {
  print("=== BIODATA ANGGOTA ===");
  print("Nama           : $nama");
  print("Umur           : $umur tahun");
  print("Tinggi Badan   : $tinggiBadan cm");
  print("Status Aktif   : $statusAktif");
  print("Buku Favorit   : $bukuFavorit");
  print("Alamat         : ${informasiTambahan["alamat"]}");
  print("Profesi        : ${informasiTambahan["profesi"]}");
}

