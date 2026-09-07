main() {
    // Inisialisasi nilai awal uas dan uts
    int uts = 70;
    int uas = 70;
    double kehadiran = 75;

    // Menghitung rata-rata nilai UTS dan UAS
    double rataRata = (uts + uas) / 2;

    // Menampilkan nilai
    print(rataRata);
    print("nilai UTS: $uts");
    print("nilai UAS: $uas");
    print("Nilai Rata-rata: $rataRata");
    print("Kehadiran: $kehadiran%");

    // Mengecek semua syarat kelulusan
    if(rataRata >=70 && kehadiran >=75 && uts >=60 && uas >=60)
    {
    print("LULUS");
    }else{
    print("Tidak Lulus");
    }
    
  }