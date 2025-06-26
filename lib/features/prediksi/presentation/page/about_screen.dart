import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});
  static const routeName = "/PrediksiAbout";

  // Constants
  static const double _kDefaultPadding = 20.0;
  static const double _kSmallText = 12.0;
  static const double _kTinyText = 9.0;

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int aboutSectionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Tentang Fitur',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blueAccent,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.blueAccent),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              return states.contains(WidgetState.focused)
                  ? null
                  : Colors.transparent;
            }),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.blueAccent,
            indicator: const BoxDecoration(
              color: AppColors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(12),
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: "KADAR AMONIA"),
              Tab(text: "PERFORMA"),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(AboutScreen._kDefaultPadding),
              child: _KadarAmoniaSection(),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(AboutScreen._kDefaultPadding),
              child: _PerformaSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _KadarAmoniaSection extends StatelessWidget {
  const _KadarAmoniaSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Intro text
        const Text(
          'Fitur prediksi kadar amonia pada aplikasi Aquanotes menggunakan pendekatan estimasi berbasis rumus ilmiah dan data empiris. Tujuan fitur ini memberikan peringatan dini kepada petani tentang risiko amonia, sehingga tindakan pencegahan dapat dilakukan sebelum udang mengalami stres.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: AboutScreen._kSmallText),
        ),
        const SizedBox(height: 24),

        // Section: Metode Perhitungan
        _sectionTitle('Metode Perhitungan', color: AppColors.blueAccent),
        const SizedBox(height: 8),
        _subTitle('Estimasi TAN:'),
        const SizedBox(height: 8),
        Image.asset(
          "assets/images/home/about/TAN_Formula.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        _subTitle('Prediksi NH₃'),
        const SizedBox(height: 8),
        const Text(
          '*Koefisien 0.3 berdasarkan studi Boyd (2019) tentang konversi pakan ke amonia.',
          style: TextStyle(
              fontSize: AboutScreen._kTinyText, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        Image.asset(
          "assets/images/home/about/NH_Formula.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        const SizedBox(height: 8),
        const Text(
          '*pKa dihitung dari suhu air menggunakan persamaan Hansen & Kawasaki, 1990.',
          style: TextStyle(
              fontSize: AboutScreen._kTinyText, fontStyle: FontStyle.italic),
        ),

        const SizedBox(height: 24),

        // Section: Disclaimer
        _sectionTitle('Disclaimer Penggunaan', color: AppColors.blueAccent),
        const SizedBox(height: 8),
        _subTitle('Akurasi Data'),
        const SizedBox(height: 8),
        Column(
          children: [
            _bulletListItem(
                "Hasil prediksi merupakan perkiraan dan tidak menggantikan pengukuran laboratorium atau test kit.",
                "• "),
            _bulletListItem('Akurasi bergantung pada:', "• "),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0), // Indent nested bullets
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bulletListItem(
                      "Kesesuaian input pakan dan volume air.", "- "),
                  _bulletListItem('Kalibrasi sensor pH dan suhu', "- "),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Section: Rekomendasi Tambahan
        _subTitle('Rekomendasi Tambahan'),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bulletListItem(
              'Lakukan uji TAN manual 1–2 minggu sekali menggunakan test kit (e.g., API Ammonia Test Kit) untuk memvalidasi prediksi.',
              '• ',
            ),
            _bulletListItem(
              'Konsultasikan dengan penyuluh perikanan jika kadar NH₃ konsisten tinggi (>0.5 mg/L).',
              '• ',
            ),
          ],
        ),
        const SizedBox(height: 24),

// Section: Tanggung Jawab
        _subTitle('Tanggung Jawab Pengguna'),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bulletListItem(
              'Aerasea tidak bertanggung jawab atas kerugian akibat ketergantungan penuh pada prediksi ini.',
              '• ',
            ),
            _bulletListItem(
              'Hasil prediksi ditujukan untuk tindakan preventif, bukan diagnosis pasti.',
              '• ',
            ),
          ],
        ),
        const SizedBox(height: 24),

// Section: Referensi Ilmiah
        _subTitle('Referensi Ilmiah'),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bulletListItem(
              'Boyd, C.E. (2019). Aquaculture Pond Bottom Soil Quality Management.',
              '• ',
            ),
            _bulletListItem(
              'Hansen & Kawasaki (1990). Ammonia Toxicity in Aquatic Systems (Journal of Aquatic Health).',
              '• ',
            ),
          ],
        ),
      ],
    );
  }
}

class _PerformaSection extends StatelessWidget {
  const _PerformaSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Intro text
        const Text(
          'Fitur ini membantu Anda memantau kesehatan, pertumbuhan, dan efisiensi budidaya udang dengan menghitung parameter kunci seperti Biomassa, Populasi, FCR (Feed Conversion Ratio), dan SR (Survival Rate) secara otomatis berdasarkan data input yang Anda berikan.`',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: AboutScreen._kSmallText),
        ),
        const SizedBox(height: 24),

        // Section: Metode Perhitungan
        _sectionTitle('Metode Perhitungan', color: AppColors.blueAccent),
        const SizedBox(height: 8),
        _subTitle('Biomassa (kg)'),
        const SizedBox(height: 8),
        Image.asset(
          "assets/images/home/about/BM_Formula.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        _subTitle('Populasi'),
        const SizedBox(height: 8),
        Image.asset(
          "assets/images/home/about/PP_Formula.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        _subTitle('Feed Conversion Ratio (FCR)'),
        const SizedBox(height: 8),
        Image.asset(
          "assets/images/home/about/FCR_Formula.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        _subTitle('Survival Rate (SR)'),
        const SizedBox(height: 8),
        Image.asset(
          "assets/images/home/about/SR_Formula.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),

        const SizedBox(height: 8),
        _subTitle('Akurasi Data'),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bulletListItem(
              'Hasil perhitungan merupakan estimasi dan bergantung pada ketepatan input data (pakan, ABW, FR, dll).',
              '• ',
            ),
            _bulletListItem(
              'Untuk hasil lebih akurat, lakukan pengukuran manual (e.g., sampling berat udang, uji kualitas pakan).',
              '• ',
            ),
          ],
        ),
        const SizedBox(height: 8),
        _subTitle('Faktor yang Mempengaruhi'),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bulletListItem('Kualitas pakan (protein, daya cerna).', '• '),
            _bulletListItem('Kondisi lingkungan (suhu, pH, amonia).', '• '),
            _bulletListItem('Manajemen budidaya (padat tebar, aerasi).', '• '),
          ],
        ),
        const SizedBox(height: 8),
        _subTitle('Tindakan Lanjutan'),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bulletListItem(
              'Jika FCR >1.6, evaluasi pakan dan manajemen air.',
              '• ',
            ),
            _bulletListItem(
              'Jika SR <70%, cek kualitas benih, penyakit, atau stres lingkungan.',
              '• ',
            ),
          ],
        ),
      ],
    );
  }
}

Widget _sectionTitle(String title, {Color color = Colors.black}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: AboutScreen._kSmallText,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}

Widget _subTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: AboutScreen._kSmallText,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget _bulletListItem(String text, String bullet) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bullet,
          style: const TextStyle(fontSize: AboutScreen._kSmallText),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: AboutScreen._kSmallText),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );
}
