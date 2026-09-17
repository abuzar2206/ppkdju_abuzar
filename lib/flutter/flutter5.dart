import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Interaksi Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 102, 175, 235),
        ),
        useMaterial3: true,
      ),
      home: const Aboy(),
    );
  }
}

class Aboy extends StatefulWidget {
  const Aboy({super.key});

  @override
  State<Aboy> createState() => _AboyState();
}

class _AboyState extends State<Aboy> {
  bool showSecretText = false;
  bool isFavorite = false;
  bool showDescription = false;
  String inkWellMessage = '';
  int counter = 10;

  void toggleSecretText() {
    setState(() {
      showSecretText = !showSecretText;
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void toggleDescription() {
    setState(() {
      showDescription = !showDescription;
    });
  }

  void handleInkWell() {
    setState(() {
      inkWellMessage = 'Sentuhan terdeteksi!';
    });

    print('Sentuhan terdeteksi');
  }

  void handleTap() {
    setState(() {
      counter += 1;
    });

    print('Ditekan sekali');
  }

  void handleDoubleTap() {
    setState(() {
      counter += 2;
    });

    print('Ditekan dua kali');
  }

  void handleLongPress() {
    setState(() {
      counter += 3;
    });

    print('Tahan lama');
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab Interaksi Flutter',
        ),
        backgroundColor: const Color.fromARGB(255, 34, 144, 235),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '1. ElevatedButton',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: toggleSecretText,
              child: Text(
                showSecretText ? 'Sembunyikan' : 'Klik Saya!',
              ),
            ),
            const SizedBox(height: 10),
            if (showSecretText)
              const Text(
                'Halo, saya Developer!',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 30),
            const Text(
              '2. IconButton',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: toggleFavorite,
              icon: Icon(
                Icons.favorite,
                size: 50,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
            Text(
              isFavorite
                  ? 'Sudah Disukai'
                  : 'Belum disukai',
              style: TextStyle(
                color: isFavorite ? Colors.red : Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '3. TextButton',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: toggleDescription,
              child: Text(
                showDescription
                    ? 'Sembunyikan Informasi'
                    : 'Lihat Informasi Tambahan',
              ),
            ),
            if (showDescription)
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'aplikasi ini dibuat oelh Abuzar,'
                  ' aplikasi ini merupakan contoh penerapan, '
                  ' StatefulWidget pada Flutter. Setiap interaksi, '
                  ' pengguna akan mengubah state dan menyebabkan, '
                  ' tampilan diperbarui secara real-time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            const SizedBox(height: 30),
            const Text(
              '4. InkWell',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: handleInkWell,
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.white54,
                child: Ink(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 4, 131, 236),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Sentuh ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              inkWellMessage,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '5. GestureDetector',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Angka: $counter',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: handleTap,
              onDoubleTap: handleDoubleTap,
              onLongPress: handleLongPress,
              child: Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Tekan / Tekan 2 kali / Tahan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Di tekan seakli = +1  |  Di Tekan dua kali = +2  |  Tahan lama = +3',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: decrementCounter,
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}
