import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sayac/sayfalar/anasayfa.dart';

const sayfa1 ="assets/images/11.png";
const sayfa2 ="assets/images/22.png";
const sayfa3 ="assets/images/33.png";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sayaç Pro',
      theme: ThemeData.light(),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  List<PageViewModel> _buildPages() => [
        PageViewModel(
          "Sayaçlarınızı Paylaşın",
          "Oluşturduğunuz Sayaçları Sosyal Medya Aracılığı İle Herkesle Paylaşabilirsiniz.",
          image: Align(
            child: Image.asset(sayfa1,height: 250,),
            alignment: Alignment.bottomCenter,
          ),
          decoration: PageDecoration(
            pageColor: Colors.transparent
          )
        ),
        PageViewModel(
          "Sayaç Düzenle",
          "Eklediğiniz Sayaçları İstediğiniz Zaman \nKendi Zevkinize Göre Düzenleyebilirsiniz.",
          image: Align(
            child: Image.asset(sayfa2, height: 250),
            alignment: Alignment.bottomCenter,
          ),
          decoration: PageDecoration(
            pageColor: Colors.transparent
          ),
        ),
        PageViewModel(
          "Öğrenci Dostu",
          "Uygulama İle Zamanınız Size Kalır Bütün Aktivitelerinizi Rahatlıkla Takip Edebilirsiniz.",
          image: Align(
            child: Image.asset(sayfa3, height: 250),
            alignment: Alignment.bottomCenter,
          ),
          decoration: PageDecoration(
            pageColor: Colors.transparent
          )
        ),

      ];

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => AnaSayfaMain()));
    
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: _buildPages(),
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text('Geç'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Bitir', style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}