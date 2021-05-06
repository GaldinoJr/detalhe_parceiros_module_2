import 'package:detalhe_parceiros_module_2/myMaterialApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DotsIndicator.dart';
import 'package:cached_network_image/cached_network_image.dart';


void main() {
  runApp(MyMaterialApp());
}

// flutter build aar --build-number 3.3.4

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  static const CHANNEL = "CHANNEL_MODULE_PARTNERS";
  static const METHOD_ARGUMENT = "METHOD_ARGUMENT";

  static const ARG_BUTTON_TEXT = "arg_button_text";
  static const ARG_IMAGE_URL = "arg_image_url";
  static const ARG_TEXT_LIST = "arg_text_list";
  static const ARG_PARTNER_URL = "arg_partner_url";

  static const methodChannel = const MethodChannel(CHANNEL);
  String buttonText = "";
  List textsDetails = [];
  String imageUrl = "";
  String partnerUrl = "";

  @override
  void initState() {
    super.initState();

    methodChannel.setMethodCallHandler((methodCall) {
      setState(() {
        if(methodCall.method == METHOD_ARGUMENT){
          buttonText = methodCall.arguments[ARG_BUTTON_TEXT];
          imageUrl = methodCall.arguments[ARG_IMAGE_URL];
          textsDetails = methodCall.arguments[ARG_TEXT_LIST] as List;
          partnerUrl = methodCall.arguments[ARG_PARTNER_URL];
          //methodChannel.invokeMethod<List<String>>("sadad") as List;
        }
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: _screenBody(
            imageUrl,
            buttonText,
            textsDetails,
            partnerUrl,
            context));
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}


Widget _screenBody(String urlImage, String buttonText, List details, String partnerUrl, BuildContext context) {
  MaterialColor redColor = MaterialColor(0xFFCF2860, redColors);

  return Column(children: [
    Flexible(
        flex: 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(image: NetworkImage(urlImage), fit: BoxFit.cover),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.fromLTRB(34, 0, 34, 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(buttonText,
                          style: TextStyle(fontSize: 18, fontFamily: 'Nunito')),
                      style: ElevatedButton.styleFrom(
                          primary: redColor[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(12)),
                      onPressed: () {
                        // chamar proxima tela
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SecondRoute()),
                        // );
                        // chamar próxima tela por rota
                        // Navigator.pushNamed(context, '/second');
                        // chamar a parte nativa do android
                        // methodChannel.invokeMethod("method_test");
                        // abrir url
                        _launchURL(partnerUrl);
                      },
                    )))
          ],
        )),
    Flexible(
        flex: 4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: details.length,
              itemBuilder: (_, i) {
                return pagerDetail(details[i]);
              },
            ),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                    child: generateDotIndicator(details))),
          ],
        ))
  ]);
}


final _controller = new PageController();
const _kDuration = const Duration(milliseconds: 300);
const _kCurve = Curves.ease;


Widget generateDotIndicator(List details) {
  return DotsIndicator(
    controller: _controller,
    itemCount: details.length,
    onPageSelected: (int page) {
      _controller.animateToPage(
        page,
        duration: _kDuration,
        curve: _kCurve,
      );
    },
    color: MaterialColor(0xFF79BDC5, indicatorColor),
    selectedColor: MaterialColor(0xFF048e9a, selectedIndicatorColor),
  );
}

Widget pagerDetail(String text) {
  MaterialColor browColor = MaterialColor(0xFF8a8a8a, browColors);
  return Align(
      alignment: Alignment.topCenter,
      child: Container(
          margin: EdgeInsets.fromLTRB(34, 34, 34, 0),
          height: 144,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 6,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child:
                        Image(image: AssetImage('images/ic_celular.png'))),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Text(
                             text,
                              style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  color: browColor,
                                  fontSize: 15),
                            )))
                  ],
                ),
              ))));
}

Map<int, Color> redColors = {
  50: Color.fromRGBO(207, 40, 96, .1),
  100: Color.fromRGBO(207, 40, 96, .2),
  200: Color.fromRGBO(207, 40, 96, .3),
  300: Color.fromRGBO(207, 40, 96, .4),
  400: Color.fromRGBO(207, 40, 96, .5),
  500: Color.fromRGBO(207, 40, 96, .6),
  600: Color.fromRGBO(207, 40, 96, .7),
  700: Color.fromRGBO(207, 40, 96, .8),
  800: Color.fromRGBO(207, 40, 96, .9),
  900: Color.fromRGBO(207, 40, 96, 1),
};

Map<int, Color> browColors = {
  50: Color.fromRGBO(138, 138, 138, .1),
  100: Color.fromRGBO(138, 138, 138, .2),
  200: Color.fromRGBO(138, 138, 138, .3),
  300: Color.fromRGBO(138, 138, 138, .4),
  400: Color.fromRGBO(138, 138, 138, .5),
  500: Color.fromRGBO(138, 138, 138, .6),
  600: Color.fromRGBO(138, 138, 138, .7),
  700: Color.fromRGBO(138, 138, 138, .8),
  800: Color.fromRGBO(138, 138, 138, .9),
  900: Color.fromRGBO(138, 138, 138, 1),
};

Map<int, Color> selectedIndicatorColor = {
  50: Color.fromRGBO(4, 142, 154, .1),
  100: Color.fromRGBO(4, 142, 154, .2),
  200: Color.fromRGBO(4, 142, 154, .3),
  300: Color.fromRGBO(4, 142, 154, .4),
  400: Color.fromRGBO(4, 142, 154, .5),
  500: Color.fromRGBO(4, 142, 154, .6),
  600: Color.fromRGBO(4, 142, 154, .7),
  700: Color.fromRGBO(4, 142, 154, .8),
  800: Color.fromRGBO(4, 142, 154, .9),
  900: Color.fromRGBO(4, 142, 154, 1),
};

Map<int, Color> indicatorColor = {
  50: Color.fromRGBO(122, 186, 192, .1),
  100: Color.fromRGBO(122, 186, 192, .2),
  200: Color.fromRGBO(122, 186, 192, .3),
  300: Color.fromRGBO(122, 186, 192, .4),
  400: Color.fromRGBO(122, 186, 192, .5),
  500: Color.fromRGBO(122, 186, 192, .6),
  600: Color.fromRGBO(122, 186, 192, .7),
  700: Color.fromRGBO(122, 186, 192, .8),
  800: Color.fromRGBO(122, 186, 192, .9),
  900: Color.fromRGBO(122, 186, 192, 1),
};

class ScreenArguments {
  final String buttonText;

  ScreenArguments(this.buttonText);
}